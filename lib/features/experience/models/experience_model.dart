class ExperienceModel {
  final String id;
  final String jobTitle;
  final String company;
  final String duration;
  final String startDate;
  final String endDate;
  final bool isCurrent;
  final List<String> responsibilities;
  final List<String> achievements;
  final List<String> technologies;
  final String? companyUrl;
  final String location;

  const ExperienceModel({
    required this.id,
    required this.jobTitle,
    required this.company,
    required this.duration,
    required this.startDate,
    required this.endDate,
    this.isCurrent = false,
    required this.responsibilities,
    required this.achievements,
    required this.technologies,
    this.companyUrl,
    required this.location,
  });
}
