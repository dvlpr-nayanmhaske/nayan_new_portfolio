import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import '../../../core/constants/constants.dart';
import '../../../core/responsive/responsive_utils.dart';
import '../../../core/services/url_service.dart';
import '../../../core/widgets/widgets.dart';
import '../controllers/home_controller.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);
    final isTablet = ResponsiveUtils.isTablet(context);

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height,
      ),
      decoration: const BoxDecoration(
        color: AppColors.primaryBackground,
      ),
      child: Stack(
        children: [
          // Background decorative elements
          Positioned(
            top: -100,
            right: -100,
            child: _buildGlowOrb(AppColors.primaryAccent, 400),
          ),
          Positioned(
            bottom: 100,
            left: -100,
            child: _buildGlowOrb(AppColors.secondaryAccent, 300),
          ),
          // Grid pattern overlay
          Positioned.fill(
            child: CustomPaint(
              painter: _GridPainter(),
            ),
          ),
          // Main Content
          Center(
            child: Padding(
              padding: ResponsiveUtils.sectionPadding(context).copyWith(
                top: 120,
                bottom: 80,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: ResponsiveUtils.maxContentWidth(context),
                ),
                child: isMobile || isTablet
                    ? _buildMobileContent(context)
                    : _buildDesktopContent(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopContent(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 55,
          child: _buildTextContent(context),
        ),
        const SizedBox(width: 60),
        Expanded(
          flex: 45,
          child: _buildHeroVisual(context),
        ),
      ],
    );
  }

  Widget _buildMobileContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildHeroVisual(context),
        const SizedBox(height: 48),
        _buildTextContent(context),
      ],
    );
  }

  Widget _buildTextContent(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);
    final controller = Get.find<HomeController>();

    return Column(
      crossAxisAlignment:
          isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        // Available badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
          decoration: BoxDecoration(
            color: AppColors.accentGreen.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              color: AppColors.accentGreen.withValues(alpha: 0.3),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: AppColors.accentGreen,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'Available for opportunities',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.accentGreen,
                ),
              ),
            ],
          ),
        )
            .animate()
            .fadeIn(duration: 600.ms, delay: 200.ms)
            .slideY(begin: -0.3, end: 0, duration: 600.ms, delay: 200.ms),
        const SizedBox(height: 24),

        // Hello greeting
        Text(
          'Hello, I\'m',
          style: GoogleFonts.inter(
            fontSize: isMobile ? 18 : 20,
            fontWeight: FontWeight.w500,
            color: AppColors.secondaryAccent,
          ),
        )
            .animate()
            .fadeIn(duration: 600.ms, delay: 350.ms)
            .slideX(begin: -0.2, end: 0, duration: 600.ms, delay: 350.ms),
        const SizedBox(height: 8),

        // Name
        Text(
          AppStrings.fullName,
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          style: GoogleFonts.inter(
            fontSize: ResponsiveUtils.heroTitleSize(context),
            fontWeight: FontWeight.w800,
            color: AppColors.primaryText,
            height: 1.0,
            letterSpacing: -2,
          ),
        )
            .animate()
            .fadeIn(duration: 700.ms, delay: 450.ms)
            .slideY(begin: 0.3, end: 0, duration: 700.ms, delay: 450.ms),
        const SizedBox(height: 12),

        // Title with gradient
        ShaderMask(
          shaderCallback: (bounds) =>
              AppColors.primaryGradient.createShader(bounds),
          child: Text(
            '${AppStrings.title} · ${AppStrings.subtitle}',
            textAlign: isMobile ? TextAlign.center : TextAlign.start,
            style: GoogleFonts.inter(
              fontSize: isMobile ? 16 : 20,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        )
            .animate()
            .fadeIn(duration: 700.ms, delay: 550.ms)
            .slideY(begin: 0.3, end: 0, duration: 700.ms, delay: 550.ms),
        const SizedBox(height: 24),

        // Headline
        Text(
          AppStrings.heroHeadline,
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          style: GoogleFonts.inter(
            fontSize: isMobile ? 15 : 17,
            fontWeight: FontWeight.w400,
            color: AppColors.secondaryText,
            height: 1.7,
          ),
        )
            .animate()
            .fadeIn(duration: 700.ms, delay: 650.ms)
            .slideY(begin: 0.3, end: 0, duration: 700.ms, delay: 650.ms),
        const SizedBox(height: 40),

        // CTA Buttons
        Wrap(
          alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
          spacing: 16,
          runSpacing: 16,
          children: [
            AppButton(
              label: 'Explore My Work',
              trailingIcon: Icons.arrow_forward_rounded,
              onTap: () => controller.scrollToSection(
                  controller.projectsKey, 3),
            ),
            AppButton(
              label: 'Download Resume',
              variant: AppButtonVariant.secondary,
              icon: Icons.download_rounded,
              onTap: () => UrlService.launch(AppStrings.resumeUrl),
            ),
            AppButton(
              label: "Let's Connect",
              variant: AppButtonVariant.outline,
              icon: Icons.email_rounded,
              onTap: () => controller.scrollToSection(
                  controller.contactKey, 5),
            ),
          ],
        )
            .animate()
            .fadeIn(duration: 700.ms, delay: 750.ms)
            .slideY(begin: 0.3, end: 0, duration: 700.ms, delay: 750.ms),

        const SizedBox(height: 48),

        // Quick stats
        _buildQuickStats(context)
            .animate()
            .fadeIn(duration: 700.ms, delay: 900.ms),
      ],
    );
  }

  Widget _buildQuickStats(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);
    final stats = [
      ('3+', 'Years Exp.'),
      ('15+', 'Projects'),
      ('10+', 'Apps Built'),
    ];

    return Row(
      mainAxisAlignment:
          isMobile ? MainAxisAlignment.center : MainAxisAlignment.start,
      children: stats.asMap().entries.map((entry) {
        final i = entry.key;
        final stat = entry.value;
        return Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShaderMask(
                  shaderCallback: (bounds) =>
                      AppColors.primaryGradient.createShader(bounds),
                  child: Text(
                    stat.$1,
                    style: GoogleFonts.inter(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                ),
                Text(
                  stat.$2,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.tertiaryText,
                  ),
                ),
              ],
            ),
            if (i < stats.length - 1) ...[
              const SizedBox(width: 24),
              Container(
                width: 1,
                height: 40,
                color: AppColors.borderColor,
              ),
              const SizedBox(width: 24),
            ],
          ],
        );
      }).toList(),
    );
  }

  Widget _buildHeroVisual(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);
    final size = isMobile ? 260.0 : 380.0;

    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Outer ring
            _buildRotatingRing(size, AppColors.primaryAccent.withValues(alpha: 0.15))
                .animate(onPlay: (c) => c.repeat())
                .rotate(
                    duration: const Duration(seconds: 20),
                    begin: 0,
                    end: 1,
                    curve: Curves.linear),

            // Inner ring
            _buildRotatingRing(size * 0.75, AppColors.secondaryAccent.withValues(alpha: 0.1))
                .animate(onPlay: (c) => c.repeat())
                .rotate(
                    duration: const Duration(seconds: 15),
                    begin: 1,
                    end: 0,
                    curve: Curves.linear),

            // Profile image
            Container(
              width: size * 0.65,
              height: size * 0.65,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: AppColors.primaryGradient,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryAccent.withValues(alpha: 0.4),
                    blurRadius: 40,
                    spreadRadius: 5,
                  ),
                ],
              ),
              padding: const EdgeInsets.all(3),
              child: ClipOval(
                child: Image.asset(
                  'assets/images/profile.jpg',
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                  errorBuilder: (_, __, ___) => Container(
                    color: AppColors.cardBackground,
                    child: const Icon(
                      Icons.person_rounded,
                      size: 80,
                      color: AppColors.secondaryText,
                    ),
                  ),
                ),
              ),
            )
                .animate()
                .fadeIn(duration: 800.ms, delay: 300.ms)
                .scale(
                    begin: const Offset(0.8, 0.8),
                    end: const Offset(1, 1),
                    duration: 800.ms,
                    delay: 300.ms),

            // Tech badges around the circle
            ..._buildTechBadges(size),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildTechBadges(double size) {
    final badges = [
      (Icons.flutter_dash, AppColors.primaryAccent, Alignment.topRight),
      (Icons.fire_truck_rounded, AppColors.secondaryAccent, Alignment.bottomLeft),
      (Icons.code_rounded, AppColors.accentGreen, Alignment.topLeft),
      (Icons.phone_android_rounded, AppColors.accentPink, Alignment.bottomRight),
    ];

    return badges.asMap().entries.map((entry) {
      final i = entry.key;
      final badge = entry.value;
      final x = (size / 2 - 20) * 0.72 * (i.isEven ? 1 : -1);
      final y = (size / 2 - 20) * 0.72 * (i < 2 ? -1 : 1);

      return Positioned(
        left: size / 2 + x - 22,
        top: size / 2 + y - 22,
        child: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: badge.$2.withValues(alpha: 0.15),
            shape: BoxShape.circle,
            border: Border.all(color: badge.$2.withValues(alpha: 0.4)),
          ),
          child: Icon(badge.$1, size: 20, color: badge.$2),
        )
            .animate(delay: Duration(milliseconds: 500 + i * 150))
            .fadeIn(duration: 500.ms)
            .scale(
                begin: const Offset(0, 0),
                end: const Offset(1, 1),
                duration: 500.ms),
      );
    }).toList();
  }

  Widget _buildRotatingRing(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: color, width: 1.5),
      ),
    );
  }

  Widget _buildGlowOrb(Color color, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            color.withValues(alpha: 0.08),
            color.withValues(alpha: 0.0),
          ],
        ),
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.borderColor.withValues(alpha: 0.3)
      ..strokeWidth = 0.5;

    const spacing = 60.0;
    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(_GridPainter oldDelegate) => false;
}
