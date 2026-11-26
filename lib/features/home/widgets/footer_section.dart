import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/constants.dart';
import '../../../core/responsive/responsive_utils.dart';
import '../../../core/services/url_service.dart';
import '../controllers/home_controller.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);
    final controller = Get.find<HomeController>();

    return Container(
      width: double.infinity,
      color: AppColors.primaryBackground,
      child: Column(
        children: [
          // Top gradient divider
          Container(
            height: 1,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  AppColors.primaryAccent,
                  AppColors.secondaryAccent,
                  Colors.transparent,
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 20 : 48,
              vertical: 60,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    maxWidth: ResponsiveUtils.maxContentWidth(context)),
                child: isMobile
                    ? _buildMobileFooter(context, controller)
                    : _buildDesktopFooter(context, controller),
              ),
            ),
          ),
          // Bottom bar
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 20 : 48,
              vertical: 20,
            ),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: AppColors.borderColor)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppStrings.copyright,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: AppColors.tertiaryText,
                  ),
                ),
                ShaderMask(
                  shaderCallback: (bounds) =>
                      AppColors.primaryGradient.createShader(bounds),
                  child: Text(
                    AppStrings.footerTagline,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopFooter(BuildContext context, HomeController controller) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Brand column
        Expanded(
          flex: 35,
          child: _buildBrandColumn(),
        ),
        // Quick Links
        Expanded(
          flex: 25,
          child: _buildLinksColumn('Quick Links', [
            ('Home', () => controller.scrollToSection(controller.heroKey, 0)),
            ('About', () => controller.scrollToSection(controller.aboutKey, 1)),
            ('Skills', () => controller.scrollToSection(controller.skillsKey, 2)),
            ('Projects', () => controller.scrollToSection(controller.projectsKey, 3)),
            ('Experience', () => controller.scrollToSection(controller.experienceKey, 4)),
            ('Contact', () => controller.scrollToSection(controller.contactKey, 5)),
          ]),
        ),
        // Connect column
        Expanded(
          flex: 25,
          child: _buildLinksColumn('Connect', [
            ('GitHub', () => UrlService.launch(AppStrings.github)),
            ('LinkedIn', () => UrlService.launch(AppStrings.linkedIn)),
            ('WhatsApp', () => UrlService.launch(AppStrings.whatsapp)),
            ('Email Me', () => UrlService.launchEmail(AppStrings.email)),
            ('Download Resume', () => UrlService.launch(AppStrings.resumeUrl)),
          ]),
        ),
      ],
    );
  }

  Widget _buildMobileFooter(BuildContext context, HomeController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildBrandColumn(centered: true),
        const SizedBox(height: 40),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _buildLinksColumn('Quick Links', [
                ('Home', () => controller.scrollToSection(controller.heroKey, 0)),
                ('About', () => controller.scrollToSection(controller.aboutKey, 1)),
                ('Skills', () => controller.scrollToSection(controller.skillsKey, 2)),
                ('Projects', () => controller.scrollToSection(controller.projectsKey, 3)),
              ]),
            ),
            Expanded(
              child: _buildLinksColumn('Connect', [
                ('GitHub', () => UrlService.launch(AppStrings.github)),
                ('LinkedIn', () => UrlService.launch(AppStrings.linkedIn)),
                ('Email Me', () => UrlService.launchEmail(AppStrings.email)),
                ('Resume', () => UrlService.launch(AppStrings.resumeUrl)),
              ]),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBrandColumn({bool centered = false}) {
    return Column(
      crossAxisAlignment:
          centered ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        // Logo
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Text(
                  'N',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              AppStrings.fullName,
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.primaryText,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          AppStrings.title,
          style: GoogleFonts.inter(
            fontSize: 14,
            color: AppColors.primaryAccent,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Building beautiful digital experiences\nwith Flutter.',
          textAlign: centered ? TextAlign.center : TextAlign.start,
          style: GoogleFonts.inter(
            fontSize: 14,
            color: AppColors.secondaryText,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 24),
        // Social icons
        Row(
          mainAxisAlignment:
              centered ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: [
            _socialBtn(Icons.code_rounded, AppStrings.github),
            const SizedBox(width: 10),
            _socialBtn(Icons.business_center_rounded, AppStrings.linkedIn),
            const SizedBox(width: 10),
            _socialBtn(Icons.chat_rounded, AppStrings.whatsapp),
          ],
        ),
      ],
    );
  }

  Widget _buildLinksColumn(
      String title, List<(String, VoidCallback)> links) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: AppColors.primaryText,
          ),
        ),
        const SizedBox(height: 20),
        ...links.map((link) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: GestureDetector(
                onTap: link.$2,
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Text(
                    link.$1,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: AppColors.secondaryText,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            )),
      ],
    );
  }

  Widget _socialBtn(IconData icon, String url) {
    return GestureDetector(
      onTap: () => UrlService.launch(url),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.borderColor),
          ),
          child: Center(child: Icon(icon, size: 16, color: AppColors.secondaryText)),
        ),
      ),
    );
  }
}
