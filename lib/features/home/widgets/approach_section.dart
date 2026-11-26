import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/constants.dart';
import '../../../core/responsive/responsive_utils.dart';
import '../../../core/widgets/widgets.dart';

class ApproachSection extends StatelessWidget {
  const ApproachSection({super.key});

  static final List<Map<String, dynamic>> steps = [
    {
      'step': '01',
      'title': 'Understanding Requirements',
      'description':
          'Deep dive into project goals, target audience, and functional requirements. I analyze user stories and create clear acceptance criteria before writing a single line of code.',
      'icon': Icons.lightbulb_rounded,
      'color': AppColors.primaryAccent,
    },
    {
      'step': '02',
      'title': 'Planning Architecture',
      'description':
          'Designing a scalable, maintainable codebase using Feature-First Architecture. Defining folder structure, state management strategy, and data flow patterns.',
      'icon': Icons.architecture_rounded,
      'color': AppColors.secondaryAccent,
    },
    {
      'step': '03',
      'title': 'Designing User Interfaces',
      'description':
          'Translating wireframes and designs into pixel-perfect Flutter widgets. Building responsive layouts that work flawlessly across all screen sizes.',
      'icon': Icons.palette_rounded,
      'color': Color(0xFF34D399),
    },
    {
      'step': '04',
      'title': 'Implementing Features',
      'description':
          'Writing clean, well-structured Dart code with proper separation of concerns. Using GetX for state management, routing, and dependency injection.',
      'icon': Icons.code_rounded,
      'color': Color(0xFFF59E0B),
    },
    {
      'step': '05',
      'title': 'API & Backend Integration',
      'description':
          'Seamlessly integrating REST APIs and Firebase services. Implementing proper error handling, loading states, and data persistence for a smooth user experience.',
      'icon': Icons.cloud_sync_rounded,
      'color': Color(0xFFEC4899),
    },
    {
      'step': '06',
      'title': 'Testing & Optimization',
      'description':
          'Thorough testing across devices and screen sizes. Performance profiling, memory optimization, and ensuring 60fps smooth animations before release.',
      'icon': Icons.speed_rounded,
      'color': Color(0xFF6366F1),
    },
    {
      'step': '07',
      'title': 'Deployment & Maintenance',
      'description':
          'Preparing release builds for App Store and Google Play, configuring CI/CD pipelines, and providing ongoing maintenance and feature updates post-launch.',
      'icon': Icons.rocket_launch_rounded,
      'color': Color(0xFF8B5CF6),
    },
  ];

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
                  label: 'My Approach',
                  title: 'How I Build\nGreat Software',
                  subtitle:
                      'A systematic, quality-first development workflow that consistently delivers polished products.',
                ),
              ),
              const SizedBox(height: 64),
              isMobile || isTablet
                  ? _buildMobileList(context)
                  : _buildDesktopGrid(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopGrid(BuildContext context) {
    return Column(
      children: steps.asMap().entries.map((entry) {
        final i = entry.key;
        final step = entry.value;
        final isEven = i % 2 == 0;
        return AnimatedVisibility(
          delay: Duration(milliseconds: i * 100),
          child: Row(
            children: [
              if (isEven)
                Expanded(child: _buildStepCard(step, context))
              else
                const Expanded(child: SizedBox()),
              _buildTimelineConnector(step, i, steps.length),
              if (!isEven)
                Expanded(child: _buildStepCard(step, context))
              else
                const Expanded(child: SizedBox()),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildMobileList(BuildContext context) {
    return Column(
      children: steps.asMap().entries.map((entry) {
        final i = entry.key;
        final step = entry.value;
        return AnimatedVisibility(
          delay: Duration(milliseconds: i * 100),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: (step['color'] as Color).withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: (step['color'] as Color).withValues(alpha: 0.4)),
                    ),
                    child: Center(
                      child: Text(
                        step['step'] as String,
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          color: step['color'] as Color,
                        ),
                      ),
                    ),
                  ),
                  if (i < steps.length - 1)
                    Container(
                      width: 2,
                      height: 80,
                      color: AppColors.borderColor,
                    ),
                ],
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: _buildStepCard(step, context),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTimelineConnector(Map step, int index, int total) {
    return Column(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: (step['color'] as Color).withValues(alpha: 0.12),
            shape: BoxShape.circle,
            border: Border.all(
                color: (step['color'] as Color).withValues(alpha: 0.4)),
          ),
          child: Icon(step['icon'] as IconData,
              color: step['color'] as Color, size: 26),
        ),
        if (index < total - 1)
          Container(
            width: 2,
            height: 60,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primaryAccent, AppColors.secondaryAccent],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildStepCard(Map step, BuildContext context) {
    return AnimatedCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                step['step'] as String,
                style: GoogleFonts.inter(
                  fontSize: 40,
                  fontWeight: FontWeight.w900,
                  color: (step['color'] as Color).withValues(alpha: 0.15),
                  height: 1,
                ),
              ),
              const Spacer(),
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: (step['color'] as Color).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(step['icon'] as IconData,
                    size: 18, color: step['color'] as Color),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            step['title'] as String,
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.primaryText,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            step['description'] as String,
            style: GoogleFonts.inter(
              fontSize: 13,
              color: AppColors.secondaryText,
              height: 1.7,
            ),
          ),
        ],
      ),
    );
  }
}
