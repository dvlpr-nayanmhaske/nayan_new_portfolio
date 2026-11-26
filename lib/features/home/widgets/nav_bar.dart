import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/constants.dart';
import '../../../core/responsive/responsive_utils.dart';
import '../../../core/services/url_service.dart';
import '../controllers/home_controller.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    final controller = Get.find<HomeController>();
    controller.scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final controller = Get.find<HomeController>();
    final scrolled = controller.scrollController.offset > 50;
    if (scrolled != _isScrolled) {
      setState(() => _isScrolled = scrolled);
    }
  }

  @override
  void dispose() {
    final controller = Get.find<HomeController>();
    controller.scrollController.removeListener(_onScroll);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: AppDimensions.navHeight,
      decoration: BoxDecoration(
        color: _isScrolled
            ? AppColors.secondaryBackground.withValues(alpha: 0.95)
            : Colors.transparent,
        border: _isScrolled
            ? const Border(
                bottom: BorderSide(color: AppColors.borderColor, width: 1),
              )
            : null,
        boxShadow: _isScrolled
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                )
              ]
            : [],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 20 : 48,
        ),
        child: isMobile ? _buildMobileNav(context) : _buildDesktopNav(context),
      ),
    );
  }

  Widget _buildDesktopNav(BuildContext context) {
    final controller = Get.find<HomeController>();
    return Row(
      children: [
        // Logo / Name
        _buildLogo(),
        const Spacer(),
        // Nav Items
        Row(
          children: [
            _navItem('Home', 0, controller, controller.heroKey),
            _navItem('About', 1, controller, controller.aboutKey),
            _navItem('Skills', 2, controller, controller.skillsKey),
            _navItem('Projects', 3, controller, controller.projectsKey),
            _navItem('Experience', 4, controller, controller.experienceKey),
            _navItem('Contact', 5, controller, controller.contactKey),
          ],
        ),
        const SizedBox(width: 24),
        // Resume Button
        _buildResumeButton(),
      ],
    );
  }

  Widget _buildMobileNav(BuildContext context) {
    final controller = Get.find<HomeController>();
    return Row(
      children: [
        _buildLogo(),
        const Spacer(),
        // Hamburger
        Obx(() => IconButton(
              onPressed: controller.toggleMobileMenu,
              icon: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: controller.isMobileMenuOpen.value
                    ? const Icon(Icons.close_rounded,
                        color: AppColors.primaryText, size: 26, key: ValueKey('close'))
                    : const Icon(Icons.menu_rounded,
                        color: AppColors.primaryText, size: 26, key: ValueKey('menu')),
              ),
            )),
      ],
    );
  }

  Widget _buildLogo() {
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Center(
            child: Text(
              'N',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          AppStrings.fullName,
          style: GoogleFonts.inter(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: AppColors.primaryText,
          ),
        ),
      ],
    );
  }

  Widget _navItem(
      String label, int index, HomeController controller, GlobalKey key) {
    return Obx(() {
      final isActive = controller.activeSectionIndex.value == index;
      return _NavLink(
        label: label,
        isActive: isActive,
        onTap: () => controller.scrollToSection(key, index),
      );
    });
  }

  Widget _buildResumeButton() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => UrlService.launch(AppStrings.resumeUrl),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.download_rounded, size: 16, color: Colors.white),
              const SizedBox(width: 6),
              Text(
                'Resume',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavLink extends StatefulWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavLink({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.label,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: widget.isActive ? FontWeight.w600 : FontWeight.w400,
                  color: widget.isActive || _isHovered
                      ? AppColors.primaryText
                      : AppColors.secondaryText,
                ),
              ),
              const SizedBox(height: 2),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 2,
                width: widget.isActive ? 20 : (_isHovered ? 10 : 0),
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
