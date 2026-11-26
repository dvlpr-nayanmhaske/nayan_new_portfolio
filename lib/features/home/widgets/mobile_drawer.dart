import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/constants.dart';
import '../../../core/services/url_service.dart';
import '../controllers/home_controller.dart';

class MobileDrawer extends StatelessWidget {
  const MobileDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return Obx(() {
      final isOpen = controller.isMobileMenuOpen.value;
      return AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        height: isOpen ? null : 0,
        child: isOpen
            ? Container(
                decoration: const BoxDecoration(
                  color: AppColors.secondaryBackground,
                  border: Border(
                    bottom: BorderSide(color: AppColors.borderColor, width: 1),
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _mobileNavItem('Home', 0, controller, controller.heroKey),
                    _mobileNavItem('About', 1, controller, controller.aboutKey),
                    _mobileNavItem('Skills', 2, controller, controller.skillsKey),
                    _mobileNavItem('Projects', 3, controller, controller.projectsKey),
                    _mobileNavItem('Experience', 4, controller, controller.experienceKey),
                    _mobileNavItem('Contact', 5, controller, controller.contactKey),
                    const SizedBox(height: 16),
                    const Divider(color: AppColors.borderColor),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () => UrlService.launch(AppStrings.resumeUrl),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          gradient: AppColors.primaryGradient,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.download_rounded,
                                size: 18, color: Colors.white),
                            const SizedBox(width: 8),
                            Text(
                              'Download Resume',
                              style: GoogleFonts.inter(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : const SizedBox.shrink(),
      );
    });
  }

  Widget _mobileNavItem(
      String label, int index, HomeController controller, GlobalKey key) {
    return GestureDetector(
      onTap: () => controller.scrollToSection(key, index),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.primaryText,
          ),
        ),
      ),
    );
  }
}
