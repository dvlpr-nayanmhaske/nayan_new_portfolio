class ProjectModel {
  final String id;
  final String title;
  final String description;
  final String longDescription;
  final List<String> technologies;
  final List<String> features;
  final String? githubUrl;
  final String? liveUrl;
  final String? imageUrl;
  final String category;
  final bool isFeatured;

  const ProjectModel({
    required this.id,
    required this.title,
    required this.description,
    required this.longDescription,
    required this.technologies,
    required this.features,
    this.githubUrl,
    this.liveUrl,
    this.imageUrl,
    required this.category,
    this.isFeatured = false,
  });
}
