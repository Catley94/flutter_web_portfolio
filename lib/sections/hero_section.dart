import 'dart:math';

import 'package:flutter/material.dart';
import '../widgets/circular_nav.dart';

class HeroSection extends StatefulWidget {
  final VoidCallback onProjectsTap;
  const HeroSection({super.key, required this.onProjectsTap});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(seconds: 20))
      ..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: 600,
      child: Stack(
        fit: StackFit.expand,
        children: [
          AnimatedBuilder(
            animation: _ctrl,
            builder: (context, _) => CustomPaint(
              painter: _StarsPainter(progress: _ctrl.value),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0x4400FFC6), Color(0x229B5CFF), Colors.transparent],
              ),
            ),
          ),
          // Subtle sacred-geometry overlay for a contemplative vibe
          IgnorePointer(
            child: CustomPaint(
              painter: _SacredGeometryPainter(opacity: 0.08),
              size: Size.infinite,
            ),
          ),
          Center(
            child: _CircularHero(onProjectsTap: widget.onProjectsTap),
          ),
        ],
      ),
    );
  }
}

class _CircularHero extends StatelessWidget {
  final VoidCallback onProjectsTap;
  const _CircularHero({required this.onProjectsTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 18.0),
          child: ShaderMask(
            shaderCallback: (rect) => const LinearGradient(
              colors: [Color(0xFF00FFC6), Color(0xFF9B5CFF)],
            ).createShader(rect),
            child: const Text(
              'SAM • CRAFT • CODE • CURIO',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'monospace',
                fontWeight: FontWeight.w800,
                letterSpacing: 2,
                fontSize: 22,
                color: Colors.white,
              ),
            ),
          ),
        ),
        CircularNav(
          radius: MediaQuery.of(context).size.width.clamp(320, 1200) / 4.2,
          items: [
            CircularNavItem(label: 'Projects', icon: Icons.grid_view_rounded, onTap: onProjectsTap),
            CircularNavItem(label: 'About', icon: Icons.person_outline, onTap: () {}),
            CircularNavItem(label: 'Contact', icon: Icons.email_outlined, onTap: () {}),
            CircularNavItem(label: 'Resume', icon: Icons.description_outlined, onTap: () {}),
            CircularNavItem(label: 'GitHub', icon: Icons.code, onTap: () {}),
            CircularNavItem(label: 'LinkedIn', icon: Icons.work_outline, onTap: () {}),
          ],
        ),
        const SizedBox(height: 22),
        Text(
          'Crafting playful systems with mindful engineering — where curiosity meets clarity',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
            letterSpacing: -0.2,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Opacity(
          opacity: 0.72,
          child: Text(
            'Play. Pause. Breathe. Build.',
            style: theme.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

class _SacredGeometryPainter extends CustomPainter {
  final double opacity;
  _SacredGeometryPainter({this.opacity = 0.08});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = const Color(0xFFFFFFFF).withOpacity(opacity);

    final double r = min(size.width, size.height) * 0.22;
    // Draw concentric circles
    for (int i = 1; i <= 4; i++) {
      canvas.drawCircle(center, r * i / 4, paint);
    }
    // Flower of life style petals
    int petals = 6;
    for (int i = 0; i < petals; i++) {
      final angle = (2 * pi / petals) * i;
      final o = center + Offset(r * cos(angle), r * sin(angle));
      canvas.drawCircle(o, r, paint..color = Colors.white.withOpacity(opacity * 0.8));
    }
    // Inner triangle (simple yantra cue)
    final triR = r * 0.75;
    final p1 = center + Offset(0, -triR);
    final p2 = center + Offset(triR * cos(2 * pi / 3), -triR * sin(2 * pi / 3));
    final p3 = center + Offset(triR * cos(4 * pi / 3), -triR * sin(4 * pi / 3));
    final path = Path()
      ..moveTo(p1.dx, p1.dy)
      ..lineTo(p2.dx, p2.dy)
      ..lineTo(p3.dx, p3.dy)
      ..close();
    canvas.drawPath(path, paint..color = Colors.white.withOpacity(opacity * 0.9));
  }

  @override
  bool shouldRepaint(covariant _SacredGeometryPainter oldDelegate) => oldDelegate.opacity != opacity;
}

class _StarsPainter extends CustomPainter {
  final double progress;
  _StarsPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final rnd = Random(42);
    final paint = Paint()..color = const Color(0x22FFFFFF);

    for (var i = 0; i < 180; i++) {
      final x = rnd.nextDouble() * size.width;
      final y = (rnd.nextDouble() * size.height + progress * 80) % size.height;
      final r = rnd.nextDouble() * 1.8 + 0.2;
      canvas.drawCircle(Offset(x, y), r, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _StarsPainter oldDelegate) => oldDelegate.progress != progress;
}
