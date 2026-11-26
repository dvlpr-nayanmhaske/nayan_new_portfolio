import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/constants.dart';
import '../../../core/responsive/responsive_utils.dart';
import '../../../core/widgets/widgets.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  static final List<Map<String, dynamic>> skillCategories = [
    {
      'category': 'Programming',
      'icon': Icons.code_rounded,
      'color': AppColors.primaryAccent,
      'skills': ['Dart', 'JavaScript (Basic)'],
    },
    {
      'category': 'Framework',
      'icon': Icons.flutter_dash,
      'color': AppColors.secondaryAccent,
      'skills': ['Flutter', 'Flutter Web'],
    },
    {
      'category': 'State Management',
      'icon': Icons.refresh_rounded,
      'color': AppColors.accentGreen,
      'skills': ['GetX', 'Provider', 'BLoC / Cubit'],
    },
    {
      'category': 'Architecture',
      'icon': Icons.architecture_rounded,
      'color': AppColors.accentPink,
      'skills': ['Feature-First', 'Clean Architecture', 'MVC', 'MVVM'],
    },
    {
      'category': 'Backend & Integration',
      'icon': Icons.cloud_rounded,
      'color': Color(0xFFF59E0B),
      'skills': ['REST APIs', 'Firebase (Auth, Firestore, Storage)', 'Firebase Cloud Messaging'],
    },
    {
      'category': 'Tools & Platforms',
      'icon': Icons.build_rounded,
      'color': Color(0xFF6366F1),
      'skills': ['Git & GitHub', 'Android Studio', 'VS Code', 'Postman', 'Figma (Basic)'],
    },
    {
      'category': 'Target Platforms',
      'icon': Icons.phone_android_rounded,
      'color': Color(0xFF10B981),
      'skills': ['Android', 'iOS', 'Web'],
    },
    {
      'category': 'Third-Party SDKs',
      'icon': Icons.extension_rounded,
      'color': Color(0xFFEC4899),
      'skills': ['Payment Gateways', 'Maps & Location', 'Push Notifications', 'Social Auth'],
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);

    return Container(
      width: double.infinity,
      color: AppColors.primaryBackground,
      padding: ResponsiveUtils.sectionPadding(context),
      child: Center(
        child: ConstrainedBox(
          constraints:
              BoxConstraints(maxWidth: ResponsiveUtils.maxContentWidth(context)),
          child: Column(
            children: [
              AnimatedVisibility(
                child: SectionHeader(
                  label: 'Technical Skills',
                  title: 'Tools & Technologies\nI Work With',
                  subtitle:
                      'A comprehensive toolkit for building modern, production-ready mobile applications.',
                ),
              ),
              const SizedBox(height: 64),
              LayoutBuilder(
                builder: (context, constraints) {
                  final crossAxis = isMobile
                      ? 1
                      : constraints.maxWidth > 900
                          ? 4
                          : 2;
                  return _buildSkillGrid(context, crossAxis);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSkillGrid(BuildContext context, int crossAxis) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxis,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        childAspectRatio: crossAxis == 1 ? 2.0 : 1.3,
      ),
      itemCount: skillCategories.length,
      itemBuilder: (context, i) {
        final cat = skillCategories[i];
        return AnimatedVisibility(
          delay: Duration(milliseconds: i * 80),
          child: _SkillCard(
            category: cat['category'] as String,
            icon: cat['icon'] as IconData,
            color: cat['color'] as Color,
            skills: cat['skills'] as List<String>,
          ),
        );
      },
    );
  }
}

class _SkillCard extends StatefulWidget {
  final String category;
  final IconData icon;
  final Color color;
  final List<String> skills;

  const _SkillCard({
    required this.category,
    required this.icon,
    required this.color,
    required this.skills,
  });

  @override
  State<_SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<_SkillCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        transform: _isHovered
            ? Matrix4.translationValues(0.0, -4.0, 0.0)
            : Matrix4.identity(),
        decoration: BoxDecoration(
          color: _isHovered ? AppColors.cardBackgroundHover : AppColors.cardBackground,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _isHovered
                ? widget.color.withValues(alpha: 0.5)
                : AppColors.borderColor,
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: widget.color.withValues(alpha: 0.15),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ]
              : [],
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: widget.color.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(widget.icon, size: 20, color: widget.color),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    widget.category,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryText,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Wrap(
                spacing: 6,
                runSpacing: 6,
                children: widget.skills.map((s) => _SkillChip(label: s, color: widget.color)).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SkillChip extends StatelessWidget {
  final String label;
  final Color color;

  const _SkillChip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}
