class Project {
  final String title;
  final String description;
  final List<String> tags;
  final String link;
  final String? imageUrl;
  final ProjectType type;

  const Project({
    required this.title,
    required this.description,
    required this.tags,
    required this.link,
    this.imageUrl,
    required this.type,
  });
}

enum ProjectType { game, software }

final demoProjects = <Project>[
  Project(
    title: 'Neon Rift',
    description: 'A WebGL cyberpunk shooter built with Unity. Dynamic AI swarms and VFX heavy combat.',
    tags: ['Unity', 'C#', 'AI', 'VFX'],
    link: 'https://example.com/neon-rift',
    imageUrl: null,
    type: ProjectType.game,
  ),
  Project(
    title: 'VoxelForge',
    description: 'Procedural voxel engine prototype with marching cubes and GPU instancing.',
    tags: ['C++', 'OpenGL', 'Procedural'],
    link: 'https://example.com/voxelforge',
    type: ProjectType.game,
  ),
  Project(
    title: 'DeployCraft',
    description: 'Full-stack CI/CD dashboard with real-time build telemetry.',
    tags: ['Flutter', 'Dart', 'Firebase', 'Cloud'],
    link: 'https://example.com/deploycraft',
    type: ProjectType.software,
  ),
  Project(
    title: 'Pathfinder',
    description: 'Graph algorithm visualizer for A*, Dijkstra and Flow networks.',
    tags: ['Dart', 'Algorithms', 'Web'],
    link: 'https://example.com/pathfinder',
    type: ProjectType.software,
  ),
];
