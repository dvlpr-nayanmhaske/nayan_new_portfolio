import 'package:get/get.dart';
import '../models/project_model.dart';

class ProjectsController extends GetxController {
  final RxList<ProjectModel> projects = <ProjectModel>[].obs;
  final RxString selectedFilter = 'All'.obs;

  final List<String> filters = ['All', 'Live Product', 'Self Project', 'Firebase'];

  @override
  void onInit() {
    super.onInit();
    _loadProjects();
  }

  void _loadProjects() {
    projects.addAll([
      const ProjectModel(
        id: '1',
        title: 'Reshimgathi Maratha Matrimony',
        description:
            'Live matrimonial app for the Maratha community with 10K+ downloads and 5K+ daily active users.',
        longDescription:
            'Designed and deployed a full-featured matrimonial mobile application for Android. '
            'Includes profile creation, advanced search filters, real-time chat, and subscription plans.',
        technologies: ['Flutter', 'Dart', 'Firebase', 'REST APIs'],
        features: [
          '10K+ downloads & 5K+ daily active users',
          'Profile creation & advanced search filters',
          'Real-time chat & in-app subscriptions',
          '99.9% uptime with continuous updates',
        ],
        liveUrl: 'https://play.google.com/store', // 🔄 Replace with exact Play Store link
        category: 'Live Product',
        isFeatured: true,
      ),
      const ProjectModel(
        id: '2',
        title: 'OKBarter',
        description:
            'Live cross-platform marketplace and barter platform deployed on Google Play Store and Apple App Store.',
        longDescription:
            'Developed a marketplace and barter platform for Android and iOS with product listing, '
            'real-time chat, authentication, and search filters.',
        technologies: ['Flutter', 'Dart', 'Firebase', 'Node.js', 'REST APIs'],
        features: [
          'Live on Android & iOS App Stores',
          'Product listing & barter workflow',
          'Real-time chat & authentication',
          'Smart search filters',
        ],
        liveUrl: 'https://play.google.com/store', // 🔄 Replace with exact Store link
        category: 'Live Product',
        isFeatured: true,
      ),
      const ProjectModel(
        id: '3',
        title: 'Turf Booking App',
        description:
            'Self-initiated sports turf booking application with slot scheduling, payments, and booking history.',
        longDescription:
            'A complete turf reservation app built with Flutter and GetX featuring real-time slot '
            'availability, payment gateway integration, and user booking management.',
        technologies: ['Flutter', 'GetX', 'Firebase', 'REST APIs'],
        features: [
          'Real-time slot availability & booking',
          'Payment gateway integration',
          'Booking history & notifications',
        ],
        githubUrl: 'https://github.com/nayanmhaske', // 🔄 Replace with exact repo URL
        category: 'Self Project',
        isFeatured: true,
      ),
      const ProjectModel(
        id: '4',
        title: 'E-Commerce App',
        description:
            'Modern shopping application with product catalog, cart management, and checkout flow.',
        longDescription:
            'Built a scalable e-commerce app with clean architecture, cart state management, '
            'wishlist, and order tracking.',
        technologies: ['Flutter', 'Dart', 'GetX', 'REST APIs'],
        features: [
          'Product catalog with search & filters',
          'Cart & wishlist management',
          'Order tracking & checkout flow',
        ],
        githubUrl: 'https://github.com/nayanmhaske', // 🔄 Replace with exact repo URL
        category: 'Self Project',
        isFeatured: false,
      ),
      const ProjectModel(
        id: '5',
        title: 'Social Media App',
        description:
            'Real-time social networking app with feed, likes, comments, and user profiles powered by Firebase.',
        longDescription:
            'A feature-rich social application built with Flutter and Firebase supporting posts, '
            'real-time interactions, authentication, and cloud storage.',
        technologies: ['Flutter', 'Firebase', 'Firestore', 'Auth'],
        features: [
          'Real-time feed, likes & comments',
          'Firebase Auth & Cloud Storage',
          'User profiles & media uploads',
        ],
        githubUrl: 'https://github.com/nayanmhaske', // 🔄 Replace with exact repo URL
        category: 'Firebase',
        isFeatured: false,
      ),
    ]);
  }

  List<ProjectModel> get filteredProjects {
    if (selectedFilter.value == 'All') return projects;
    return projects.where((p) => p.category == selectedFilter.value).toList();
  }

  void setFilter(String filter) {
    selectedFilter.value = filter;
  }
}
