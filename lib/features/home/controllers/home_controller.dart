import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  // Scroll controller for the whole page
  final scrollController = ScrollController();

  // Current active section index
  final RxInt activeSectionIndex = 0.obs;

  // Mobile drawer state
  final RxBool isMobileMenuOpen = false.obs;

  // Section keys for scroll-to navigation
  final GlobalKey heroKey = GlobalKey();
  final GlobalKey aboutKey = GlobalKey();
  final GlobalKey skillsKey = GlobalKey();
  final GlobalKey projectsKey = GlobalKey();
  final GlobalKey experienceKey = GlobalKey();
  final GlobalKey contactKey = GlobalKey();

  final List<String> navItems = [
    'Home',
    'About',
    'Skills',
    'Projects',
    'Experience',
    'Contact',
  ];

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_onScroll);
  }

  @override
  void onClose() {
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    super.onClose();
  }

  void _onScroll() {
    // Update active nav based on scroll position
    final offset = scrollController.offset;
    if (offset < 400) {
      activeSectionIndex.value = 0;
    } else if (offset < 900) {
      activeSectionIndex.value = 1;
    } else if (offset < 1600) {
      activeSectionIndex.value = 2;
    } else if (offset < 2500) {
      activeSectionIndex.value = 3;
    } else if (offset < 3400) {
      activeSectionIndex.value = 4;
    } else {
      activeSectionIndex.value = 5;
    }
  }

  void scrollToSection(GlobalKey key, int index) {
    activeSectionIndex.value = index;
    isMobileMenuOpen.value = false;

    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOut,
      );
    }
  }

  void toggleMobileMenu() {
    isMobileMenuOpen.toggle();
  }

  void closeMobileMenu() {
    isMobileMenuOpen.value = false;
  }
}
