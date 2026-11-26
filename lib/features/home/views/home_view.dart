import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/constants.dart';
import '../../../features/experience/bindings/experience_binding.dart';
import '../../../features/projects/bindings/projects_binding.dart';
import '../../../features/contact/bindings/contact_binding.dart';
import '../controllers/home_controller.dart';
import '../widgets/nav_bar.dart';
import '../widgets/mobile_drawer.dart';
import '../widgets/hero_section.dart';
import '../widgets/approach_section.dart';
import '../widgets/footer_section.dart';
import '../../about/views/about_section.dart';
import '../../skills/views/skills_section.dart';
import '../../projects/views/projects_section.dart';
import '../../experience/views/experience_section.dart';
import '../../contact/views/contact_section.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late HomeController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Get.find<HomeController>();
    // Initialize feature bindings
    ProjectsBinding().dependencies();
    ExperienceBinding().dependencies();
    ContactBinding().dependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      body: Stack(
        children: [
          // Main scrollable content
          SingleChildScrollView(
            controller: _controller.scrollController,
            physics: const ClampingScrollPhysics(),
            child: Column(
              children: [
                // Spacer for the fixed navbar
                const SizedBox(height: AppDimensions.navHeight),
                // Hero Section
                HeroSection(key: _controller.heroKey),
                // About Section
                AboutSection(key: _controller.aboutKey),
                // Skills Section
                SkillsSection(key: _controller.skillsKey),
                // Projects Section
                ProjectsSection(key: _controller.projectsKey),
                // Experience Section
                ExperienceSection(key: _controller.experienceKey),
                // Approach Section
                const ApproachSection(),
                // Contact Section
                ContactSection(key: _controller.contactKey),
                // Footer
                const FooterSection(),
              ],
            ),
          ),
          // Fixed overlay: NavBar + Mobile Drawer
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                const NavBar(),
                const MobileDrawer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
