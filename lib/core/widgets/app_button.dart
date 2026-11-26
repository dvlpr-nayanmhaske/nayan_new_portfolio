import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';

enum AppButtonVariant { primary, secondary, outline, ghost }

class AppButton extends StatefulWidget {
  final String label;
  final VoidCallback? onTap;
  final AppButtonVariant variant;
  final IconData? icon;
  final IconData? trailingIcon;
  final bool isLoading;
  final double? width;

  const AppButton({
    super.key,
    required this.label,
    this.onTap,
    this.variant = AppButtonVariant.primary,
    this.icon,
    this.trailingIcon,
    this.isLoading = false,
    this.width,
  });

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.isLoading ? null : widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: widget.width,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 13),
          decoration: _buildDecoration(),
          child: _buildContent(),
        ),
      ),
    );
  }

  BoxDecoration _buildDecoration() {
    switch (widget.variant) {
      case AppButtonVariant.primary:
        return BoxDecoration(
          gradient: _isHovered
              ? const LinearGradient(
                  colors: [Color(0xFF9D6FFF), Color(0xFF54C5F8)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : AppColors.primaryGradient,
          borderRadius: BorderRadius.circular(10),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: AppColors.primaryAccent.withValues(alpha: 0.4),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  )
                ]
              : [],
        );
      case AppButtonVariant.secondary:
        return BoxDecoration(
          color: _isHovered
              ? AppColors.primaryAccent.withValues(alpha: 0.15)
              : AppColors.primaryAccent.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: _isHovered ? AppColors.primaryAccent : AppColors.borderColor,
          ),
        );
      case AppButtonVariant.outline:
        return BoxDecoration(
          color: _isHovered
              ? AppColors.primaryAccent.withValues(alpha: 0.08)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: _isHovered ? AppColors.primaryAccent : AppColors.borderColor,
          ),
        );
      case AppButtonVariant.ghost:
        return BoxDecoration(
          color: _isHovered
              ? AppColors.cardBackground
              : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        );
    }
  }

  Widget _buildContent() {
    final textColor = widget.variant == AppButtonVariant.primary
        ? Colors.white
        : AppColors.primaryText;

    if (widget.isLoading) {
      return SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: textColor,
        ),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.icon != null) ...[
          Icon(widget.icon, size: 18, color: textColor),
          const SizedBox(width: 8),
        ],
        Text(
          widget.label,
          style: GoogleFonts.inter(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: textColor,
            letterSpacing: 0.2,
          ),
        ),
        if (widget.trailingIcon != null) ...[
          const SizedBox(width: 8),
          AnimatedSlide(
            duration: const Duration(milliseconds: 200),
            offset: _isHovered ? const Offset(0.2, 0) : Offset.zero,
            child: Icon(widget.trailingIcon, size: 18, color: textColor),
          ),
        ],
      ],
    );
  }
}
