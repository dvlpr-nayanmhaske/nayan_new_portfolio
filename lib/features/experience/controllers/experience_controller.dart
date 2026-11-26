import 'package:get/get.dart';
import '../models/experience_model.dart';

class ExperienceController extends GetxController {
  final RxList<ExperienceModel> experiences = <ExperienceModel>[].obs;
  final RxInt expandedIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    _loadExperiences();
  }

  void _loadExperiences() {
    experiences.addAll([
      const ExperienceModel(
        id: '1',
        jobTitle: 'Jr. Flutter Developer',
        company: 'Probity IT Services',
        duration: '1.6+ Years',
        startDate: 'January 2025',
        endDate: 'Present',
        isCurrent: true,
        location: 'Nashik, Maharashtra',
        responsibilities: [
          'Designed and deployed Reshimgathi Maratha Matrimony, achieving 10K+ downloads and 5K+ daily active users',
          'Converted Figma UI/UX into responsive, pixel-perfect Flutter applications with robust state management',
          'Integrated REST APIs, monitored app performance, and delivered updates to maintain 99.9% uptime',
          'Implemented Push Notifications, Payment Gateway Integration, and Firebase services',
        ],
        achievements: [
          'Scaled Reshimgathi Maratha Matrimony to 10K+ downloads and 5K+ DAU',
          'Maintained 99.9% app uptime across production releases',
          'Shipped OKBarter across both Google Play Store and Apple App Store',
        ],
        technologies: ['Flutter', 'Dart', 'GetX', 'BLoC', 'Firebase', 'REST APIs'],
      ),
      const ExperienceModel(
        id: '2',
        jobTitle: 'Flutter Developer Intern',
        company: 'Probity IT Services',
        duration: '6 Months',
        startDate: 'July 2024',
        endDate: 'December 2024',
        isCurrent: false,
        location: 'Nashik, Maharashtra',
        responsibilities: [
          'Developed Flutter components following industry coding standards and best practices',
          'Assisted in API integration, state management, and responsive UI implementation',
          'Contributed to bug fixing, testing, and performance optimization for in-house projects',
        ],
        achievements: [
          'Transitioned to full-time Jr. Flutter Developer based on performance',
          'Built reusable UI components adopted across multiple company products',
        ],
        technologies: ['Flutter', 'Dart', 'Provider', 'MVC', 'REST APIs', 'Git'],
      ),
    ]);
  }

  void toggleExpanded(int index) {
    if (expandedIndex.value == index) {
      expandedIndex.value = -1;
    } else {
      expandedIndex.value = index;
    }
  }
}
