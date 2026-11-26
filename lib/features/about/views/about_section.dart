import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/constants.dart';
import '../../../core/responsive/responsive_utils.dart';
import '../../../core/widgets/widgets.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);
    final isTablet = ResponsiveUtils.isTablet(context);

    return Container(
      width: double.infinity,
      color: AppColors.secondaryBackground,
      padding: ResponsiveUtils.sectionPadding(context),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
              maxWidth: ResponsiveUtils.maxContentWidth(context)),
          child: Column(
            children: [
              AnimatedVisibility(
                child: SectionHeader(
                  label: 'About Me',
                  title: 'Passionate About Craft,\nDriven by Results',
                  subtitle:
                      'Building exceptional mobile experiences, one Flutter app at a time.',
                ),
              ),
              const SizedBox(height: 64),
              isMobile || isTablet
                  ? _buildMobileLayout(context)
                  : _buildDesktopLayout(context),
              const SizedBox(height: 64),
              AnimatedVisibility(
                delay: const Duration(milliseconds: 200),
                child: _buildStatsRow(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return AnimatedVisibility(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 45, child: _buildProfileCard(context)),
          const SizedBox(width: 60),
          Expanded(flex: 55, child: _buildAboutContent(context)),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      children: [
        AnimatedVisibility(child: _buildProfileCard(context)),
        const SizedBox(height: 40),
        AnimatedVisibility(
          delay: const Duration(milliseconds: 200),
          child: _buildAboutContent(context),
        ),
      ],
    );
  }

  Widget _buildProfileCard(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        AnimatedCard(
          enableHover: false,
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              // Profile Image
              Container(
                height: 300,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                clipBehavior: Clip.antiAlias,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      'assets/images/profile.jpg',
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                      errorBuilder: (_, __, ___) => Container(
                        color: AppColors.cardBackground,
                        child: const Center(
                          child: Icon(Icons.person_rounded,
                              size: 80, color: AppColors.secondaryText),
                        ),
                      ),
                    ),
                    // Gradient overlay at bottom
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 100,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.transparent, AppColors.cardBackground],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.fullName,
                      style: GoogleFonts.inter(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryText,
                      ),
                    ),
                    const SizedBox(height: 4),
                    ShaderMask(
                      shaderCallback: (bounds) =>
                          AppColors.primaryGradient.createShader(bounds),
                      child: Text(
                        AppStrings.title,
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Contact quick links
                    _quickLink(Icons.email_rounded, AppStrings.email),
                    const SizedBox(height: 10),
                    _quickLink(Icons.location_on_rounded, AppStrings.location),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Floating experience badge
        Positioned(
          top: -16,
          right: -16,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryAccent.withValues(alpha: 0.4),
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Column(
              children: [
                Text(
                  '3+',
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Years',
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _quickLink(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.primaryAccent),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.inter(
              fontSize: 13,
              color: AppColors.secondaryText,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildAboutContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Who I Am',
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: AppColors.primaryAccent,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'A Flutter Developer\nBuilding the Future of Mobile',
          style: GoogleFonts.inter(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: AppColors.primaryText,
            height: 1.25,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          AppStrings.aboutBio,
          style: GoogleFonts.inter(
            fontSize: 15,
            color: AppColors.secondaryText,
            height: 1.8,
          ),
        ),
        const SizedBox(height: 32),
        // Expertise highlights
        ..._buildExpertiseList(),
        const SizedBox(height: 32),
        // Core values
        _buildCoreValues(),
      ],
    );
  }

  List<Widget> _buildExpertiseList() {
    final items = [
      ('Feature-First Architecture', Icons.architecture_rounded),
      ('GetX State Management', Icons.refresh_rounded),
      ('Clean & Reusable Code', Icons.code_rounded),
      ('REST APIs & Firebase', Icons.cloud_rounded),
      ('Android & iOS Development', Icons.phone_android_rounded),
      ('Performance Optimization', Icons.speed_rounded),
    ];

    return items.map((item) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: AppColors.primaryAccent.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(item.$2, size: 16, color: AppColors.primaryAccent),
            ),
            const SizedBox(width: 12),
            Text(
              item.$1,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.primaryText,
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  Widget _buildCoreValues() {
    final values = [
      ('Clean Code', 'Writing readable,\nmaintainable code'),
      ('Performance', 'Optimized apps\nthat run smoothly'),
      ('UX Focus', 'Beautiful interfaces\nusers love'),
    ];

    return Row(
      children: values.map((v) {
        return Expanded(
          child: Container(
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.borderColor),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  v.$1,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryText,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  v.$2,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: AppColors.tertiaryText,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildStatsRow(BuildContext context) {
    final stats = [
      (AppStrings.yearsExperience, 'Years\nExperience', Icons.work_history_rounded),
      (AppStrings.projectsCompleted, 'Projects\nCompleted', Icons.folder_rounded),
      (AppStrings.appsPublished, 'Apps\nPublished', Icons.phone_android_rounded),
      (AppStrings.technologiesUsed, 'Technologies\nUsed', Icons.code_rounded),
    ];

    final isMobile = ResponsiveUtils.isMobile(context);

    return Wrap(
      spacing: 20,
      runSpacing: 20,
      alignment: WrapAlignment.center,
      children: stats.asMap().entries.map((entry) {
        final i = entry.key;
        final stat = entry.value;
        return AnimatedCard(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 24 : 36,
            vertical: 24,
          ),
          child: Column(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.primaryAccent.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(stat.$3, color: AppColors.primaryAccent, size: 24),
              ),
              const SizedBox(height: 12),
              ShaderMask(
                shaderCallback: (bounds) =>
                    AppColors.primaryGradient.createShader(bounds),
                child: Text(
                  stat.$1,
                  style: GoogleFonts.inter(
                    fontSize: 36,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                stat.$2,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: AppColors.secondaryText,
                  height: 1.4,
                ),
              ),
            ],
          ),
        )
            .animate(delay: Duration(milliseconds: i * 100))
            .fadeIn(duration: 500.ms)
            .slideY(begin: 0.3, end: 0, duration: 500.ms);
      }).toList(),
    );
  }
}
