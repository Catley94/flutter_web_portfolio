import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/project.dart';

class ProjectsSection extends StatefulWidget {
  final List<Project> projects;
  const ProjectsSection({super.key, required this.projects});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  ProjectType? filter;

  @override
  Widget build(BuildContext context) {
    final filtered = filter == null
        ? widget.projects
        : widget.projects.where((p) => p.type == filter).toList();

    final width = MediaQuery.of(context).size.width;
    final cols = width > 1200 ? 3 : width > 800 ? 2 : 1;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Projects', style: Theme.of(context).textTheme.displaySmall),
              Wrap(
                spacing: 8,
                children: [
                  FilterChip(
                    selected: filter == null,
                    label: const Text('All'),
                    onSelected: (_) => setState(() => filter = null),
                  ),
                  FilterChip(
                    selected: filter == ProjectType.game,
                    label: const Text('Games'),
                    onSelected: (_) => setState(() => filter = ProjectType.game),
                  ),
                  FilterChip(
                    selected: filter == ProjectType.software,
                    label: const Text('Software'),
                    onSelected: (_) => setState(() => filter = ProjectType.software),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: cols,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.5,
            ),
            itemCount: filtered.length,
            itemBuilder: (context, i) => _ProjectCard(project: filtered[i]),
          ),
        ],
      ),
    );
  }
}

class _ProjectCard extends StatefulWidget {
  final Project project;
  const _ProjectCard({required this.project});

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool hovered = false;
  @override
  Widget build(BuildContext context) {
    final p = widget.project;
    final color = Theme.of(context).colorScheme;
    return MouseRegion(
      onEnter: (_) => setState(() => hovered = true),
      onExit: (_) => setState(() => hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: color.surface.withOpacity(0.6),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: hovered ? color.primary : color.surface, width: 1),
          boxShadow: [
            if (hovered)
              BoxShadow(color: color.primary.withOpacity(0.2), blurRadius: 18, spreadRadius: 1),
          ],
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(p.type == ProjectType.game ? Icons.sports_esports : Icons.code, color: color.primary),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(p.title, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                ),
                IconButton(
                  tooltip: 'Open',
                  onPressed: () => _launch(p.link),
                  icon: const Icon(Icons.arrow_outward),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Text(p.description, style: Theme.of(context).textTheme.bodyLarge),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              runSpacing: -8,
              children: p.tags
                  .map((t) => Chip(
                        label: Text(t),
                        visualDensity: VisualDensity.compact,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, webOnlyWindowName: '_blank')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open link')),
      );
    }
  }
}
