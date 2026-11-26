import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/constants.dart';
import '../../../core/responsive/responsive_utils.dart';
import '../../../core/widgets/widgets.dart';
import '../controllers/experience_controller.dart';
import '../models/experience_model.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ExperienceController>();
    final isMobile = ResponsiveUtils.isMobile(context);

    return Container(
      width: double.infinity,
      color: AppColors.primaryBackground,
      padding: ResponsiveUtils.sectionPadding(context),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
              maxWidth: ResponsiveUtils.maxContentWidth(context)),
          child: Column(
            children: [
              AnimatedVisibility(
                child: SectionHeader(
                  label: 'Work Experience',
                  title: 'Professional\nJourney',
                  subtitle:
                      '3+ years of building and shipping Flutter applications in production environments.',
                ),
              ),
              const SizedBox(height: 64),
              Obx(() => Column(
                    children: controller.experiences.asMap().entries.map((entry) {
                      final i = entry.key;
                      final exp = entry.value;
                      return AnimatedVisibility(
                        delay: Duration(milliseconds: i * 150),
                        child: _buildTimelineItem(
                          context,
                          exp,
                          i,
                          i == controller.experiences.length - 1,
                          controller,
                          isMobile,
                        ),
                      );
                    }).toList(),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimelineItem(
    BuildContext context,
    ExperienceModel exp,
    int index,
    bool isLast,
    ExperienceController controller,
    bool isMobile,
  ) {
    return Obx(() {
      final isExpanded = controller.expandedIndex.value == index;
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isMobile)
            // Timeline indicator
            Column(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    gradient: exp.isCurrent ? AppColors.primaryGradient : null,
                    color: exp.isCurrent ? null : AppColors.cardBackground,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: exp.isCurrent
                          ? Colors.transparent
                          : AppColors.borderColor,
                      width: 2,
                    ),
                    boxShadow: exp.isCurrent
                        ? [
                            BoxShadow(
                              color: AppColors.primaryAccent.withValues(alpha: 0.4),
                              blurRadius: 16,
                            )
                          ]
                        : [],
                  ),
                  child: const Icon(
                    Icons.work_rounded,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
                if (!isLast)
                  Container(
                    width: 2,
                    height: isExpanded ? 320 : 100,
                    color: AppColors.borderColor,
                  ),
              ],
            ),
          if (!isMobile) const SizedBox(width: 24),
          // Content
          Expanded(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () => controller.toggleExpanded(index),
                  child: AnimatedCard(
                    enableHover: true,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: _buildExpHeader(exp)),
                            Icon(
                              isExpanded
                                  ? Icons.keyboard_arrow_up_rounded
                                  : Icons.keyboard_arrow_down_rounded,
                              color: AppColors.secondaryText,
                            ),
                          ],
                        ),
                        if (!isExpanded) ...[
                          const SizedBox(height: 12),
                          Text(
                            exp.responsibilities.first,
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              color: AppColors.secondaryText,
                              height: 1.6,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                        if (isExpanded) _buildExpandedContent(exp),
                      ],
                    ),
                  ),
                ),
                if (!isLast) const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      );
    });
  }

  Widget _buildExpHeader(ExperienceModel exp) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                exp.jobTitle,
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryText,
                ),
              ),
            ),
            if (exp.isCurrent)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.accentGreen.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(
                      color: AppColors.accentGreen.withValues(alpha: 0.3)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: AppColors.accentGreen,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Current',
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: AppColors.accentGreen,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            ShaderMask(
              shaderCallback: (bounds) =>
                  AppColors.primaryGradient.createShader(bounds),
              child: Text(
                exp.company,
                style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 12),
            const Icon(Icons.circle, size: 4, color: AppColors.tertiaryText),
            const SizedBox(width: 12),
            Text(
              exp.location,
              style: GoogleFonts.inter(
                  fontSize: 13, color: AppColors.tertiaryText),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            const Icon(Icons.calendar_today_rounded,
                size: 13, color: AppColors.tertiaryText),
            const SizedBox(width: 6),
            Text(
              '${exp.startDate} — ${exp.endDate}  ·  ${exp.duration}',
              style: GoogleFonts.inter(
                fontSize: 13,
                color: AppColors.tertiaryText,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildExpandedContent(ExperienceModel exp) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        const Divider(color: AppColors.borderColor),
        const SizedBox(height: 20),
        // Responsibilities
        _sectionLabel('Responsibilities'),
        const SizedBox(height: 10),
        ...exp.responsibilities.map((r) => _bulletPoint(r)),
        const SizedBox(height: 20),
        // Achievements
        _sectionLabel('Key Achievements'),
        const SizedBox(height: 10),
        ...exp.achievements.map((a) => _achievementPoint(a)),
        const SizedBox(height: 20),
        // Technologies
        _sectionLabel('Technologies Used'),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: exp.technologies.map((t) {
            return Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              decoration: BoxDecoration(
                color: AppColors.primaryAccent.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                    color: AppColors.primaryAccent.withValues(alpha: 0.2)),
              ),
              child: Text(
                t,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryAccent,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _sectionLabel(String label) {
    return Text(
      label,
      style: GoogleFonts.inter(
        fontSize: 13,
        fontWeight: FontWeight.w700,
        color: AppColors.primaryText,
        letterSpacing: 0.5,
      ),
    );
  }

  Widget _bulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 7),
            child: Container(
              width: 5,
              height: 5,
              decoration: const BoxDecoration(
                color: AppColors.primaryAccent,
                shape: BoxShape.circle,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.inter(
                fontSize: 13,
                color: AppColors.secondaryText,
                height: 1.6,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _achievementPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.star_rounded, size: 16, color: Color(0xFFF59E0B)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.inter(
                fontSize: 13,
                color: AppColors.secondaryText,
                height: 1.6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
