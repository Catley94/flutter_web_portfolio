import 'dart:math';

import 'package:flutter/material.dart';

class CircularNav extends StatelessWidget {
  final List<CircularNavItem> items;
  final double radius;
  final Widget? center;
  final Duration rotateDuration;

  const CircularNav({
    super.key,
    required this.items,
    this.radius = 140,
    this.center,
    this.rotateDuration = const Duration(milliseconds: 600),
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final r = radius.clamp(80.0, 260.0);

    return LayoutBuilder(
      builder: (context, constraints) {
        final size = min(constraints.maxWidth, 2 * r + 180);
        return SizedBox(
          width: size,
          height: size,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // subtle circular glow ring
              _NeonRing(radius: r + 8),
              ..._positionedItems(context, r),
              Center(
                child: center ?? _DefaultCenter(theme: theme),
              )
            ],
          ),
        );
      },
    );
  }

  List<Widget> _positionedItems(BuildContext context, double r) {
    final n = items.length;
    final widgets = <Widget>[];
    for (int i = 0; i < n; i++) {
      final angle = -pi / 2 + (2 * pi * i / n);
      final dx = r * cos(angle);
      final dy = r * sin(angle);
      widgets.add(
        Transform.translate(
          offset: Offset(dx, dy),
          child: _NavDot(item: items[i]),
        ),
      );
    }
    return widgets;
  }
}

class _DefaultCenter extends StatelessWidget {
  // Simple ensō-like brush ring inside the center for a meditative cue
  Path _enso(Size size) {
    final r = size.width / 2 - 6;
    final path = Path();
    for (double t = 0; t <= 2 * pi; t += 0.05) {
      final x = size.width / 2 + r * cos(t);
      final y = size.height / 2 + r * sin(t);
      if (t == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    return path;
  }
  final ThemeData theme;
  const _DefaultCenter({required this.theme});
  @override
  Widget build(BuildContext context) {
    final color = theme.colorScheme.primary;
    return Container(
      width: 160,
      height: 160,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(colors: [color.withOpacity(0.35), Colors.transparent]),
        border: Border.all(color: color.withOpacity(0.6), width: 2),
        boxShadow: [
          BoxShadow(color: color.withOpacity(0.35), blurRadius: 24, spreadRadius: 6),
        ],
      ),
      alignment: Alignment.center,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: const Size(140, 140),
            painter: _EnsoPainter(color.withOpacity(0.5)),
          ),
          Text(
            'SAM',
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w900,
              letterSpacing: 6,
            ),
          ),
        ],
      ),
    );
  }
}

class _EnsoPainter extends CustomPainter {
  final Color color;
  _EnsoPainter(this.color);
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 6
      ..color = color;
    final rect = Rect.fromLTWH(6, 6, size.width - 12, size.height - 12);
    // Draw an open circular stroke to allude to an ensō
    canvas.drawArc(rect, -pi / 3, 4.6, false, paint);
  }

  @override
  bool shouldRepaint(covariant _EnsoPainter oldDelegate) => oldDelegate.color != color;
}

class _NeonRing extends StatelessWidget {
  final double radius;
  const _NeonRing({required this.radius});
  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    final secondary = Theme.of(context).colorScheme.secondary;
    return SizedBox(
      width: radius * 2,
      height: radius * 2,
      child: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: SweepGradient(colors: [primary.withOpacity(0.4), secondary.withOpacity(0.35), Colors.amberAccent.withOpacity(0.18), primary.withOpacity(0.4)]),
          boxShadow: [
            BoxShadow(color: primary.withOpacity(0.25), blurRadius: 40, spreadRadius: 2),
          ],
        ),
      ),
    );
  }
}

class CircularNavItem {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  CircularNavItem({required this.label, required this.icon, required this.onTap});
}

class _NavDot extends StatefulWidget {
  final CircularNavItem item;
  const _NavDot({required this.item});
  @override
  State<_NavDot> createState() => _NavDotState();
}

class _NavDotState extends State<_NavDot> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.item.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _hover ? primary.withOpacity(0.18) : Colors.white.withOpacity(0.06),
            shape: BoxShape.circle,
            border: Border.all(color: primary.withOpacity(_hover ? 0.9 : 0.5), width: _hover ? 2 : 1),
            boxShadow: _hover
                ? [
                    BoxShadow(color: primary.withOpacity(0.45), blurRadius: 24, spreadRadius: 2),
                  ]
                : [],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(widget.item.icon, size: 22),
              const SizedBox(height: 4),
              Text(widget.item.label, style: const TextStyle(fontSize: 11, letterSpacing: 0.5)),
            ],
          ),
        ),
      ),
    );
  }
}
