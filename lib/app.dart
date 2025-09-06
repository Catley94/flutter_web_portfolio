import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'models/project.dart';
import 'sections/hero_section.dart';
import 'sections/projects_section.dart';
import 'theme.dart';

class PortfolioApp extends StatefulWidget {
  const PortfolioApp({super.key});

  @override
  State<PortfolioApp> createState() => _PortfolioAppState();
}

class _PortfolioAppState extends State<PortfolioApp> {
  final _scrollCtrl = ScrollController();
  final _projectsKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    SystemChrome.setApplicationSwitcherDescription(const ApplicationSwitcherDescription(
      label: 'Sam — Game Dev & Software Engineer',
    ));
  }

  void _scrollToProjects() {
    final ctx = _projectsKey.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sam — Game Dev & Software Engineer',
      theme: PortfolioTheme.darkNeon(),
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(64),
          child: _TopNav(onProjects: _scrollToProjects),
        ),
        body: SingleChildScrollView(
          controller: _scrollCtrl,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              HeroSection(onProjectsTap: _scrollToProjects),
              Container(
                key: _projectsKey,
                child: ProjectsSection(projects: demoProjects),
              ),
              const SizedBox(height: 60),
              const _Footer(),
            ],
          ),
        ),
      ),
    );
  }
}

class _TopNav extends StatelessWidget {
  final VoidCallback onProjects;
  const _TopNav({required this.onProjects});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        border: Border(bottom: BorderSide(color: Colors.white10)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 8)],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Text('SAM', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800, letterSpacing: 2)),
          const Spacer(),
          TextButton.icon(onPressed: onProjects, icon: const Icon(Icons.grid_view_outlined), label: const Text('Projects')),
          const SizedBox(width: 8),
          FilledButton.icon(
            onPressed: () {},
            style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(color.primary)),
            icon: const Icon(Icons.email_outlined),
            label: const Text('Hire Me'),
          ),
        ],
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 28.0, horizontal: 16),
      child: Opacity(
        opacity: 0.6,
        child: Text(
          '© ${DateTime.now().year} Sam. Built with Flutter.',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
