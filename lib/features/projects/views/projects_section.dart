import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/constants.dart';
import '../../../core/responsive/responsive_utils.dart';
import '../../../core/services/url_service.dart';
import '../../../core/widgets/widgets.dart';
import '../controllers/projects_controller.dart';
import '../models/project_model.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProjectsController>();

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
                  label: 'Featured Projects',
                  title: 'Things I\'ve\nBuilt & Shipped',
                  subtitle:
                      'Real-world applications built with Flutter, deployed to production.',
                ),
              ),
              const SizedBox(height: 40),
              // Filter tabs
              AnimatedVisibility(
                delay: const Duration(milliseconds: 200),
                child: Obx(() => _buildFilterTabs(controller)),
              ),
              const SizedBox(height: 48),
              // Project grid
              Obx(() => _buildProjectGrid(context, controller)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterTabs(ProjectsController controller) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: controller.filters.map((filter) {
          final isSelected = controller.selectedFilter.value == filter;
          return GestureDetector(
            onTap: () => controller.setFilter(filter),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                gradient: isSelected ? AppColors.primaryGradient : null,
                color: isSelected ? null : AppColors.cardBackground,
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                  color: isSelected
                      ? Colors.transparent
                      : AppColors.borderColor,
                ),
              ),
              child: Text(
                filter,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  color: isSelected ? Colors.white : AppColors.secondaryText,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildProjectGrid(
      BuildContext context, ProjectsController controller) {
    final projects = controller.filteredProjects;
    final isMobile = ResponsiveUtils.isMobile(context);
    final isTablet = ResponsiveUtils.isTablet(context);

    if (projects.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(60),
        child: Text(
          'No projects in this category yet.',
          style: GoogleFonts.inter(color: AppColors.secondaryText),
        ),
      );
    }

    final crossAxis = isMobile ? 1 : (isTablet ? 2 : 3);

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxis,
        crossAxisSpacing: 24,
        mainAxisSpacing: 24,
        childAspectRatio: isMobile ? 1.1 : 0.85,
      ),
      itemCount: projects.length,
      itemBuilder: (context, i) {
        return AnimatedVisibility(
          delay: Duration(milliseconds: i * 100),
          child: _ProjectCard(project: projects[i]),
        );
      },
    );
  }
}

class _ProjectCard extends StatefulWidget {
  final ProjectModel project;

  const _ProjectCard({required this.project});

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        transform: _isHovered
            ? Matrix4.translationValues(0.0, -6.0, 0.0)
            : Matrix4.identity(),
        decoration: BoxDecoration(
          color: _isHovered
              ? AppColors.cardBackgroundHover
              : AppColors.cardBackground,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _isHovered
                ? AppColors.primaryAccent.withValues(alpha: 0.5)
                : AppColors.borderColor,
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: AppColors.primaryAccent.withValues(alpha: 0.15),
                    blurRadius: 30,
                    offset: const Offset(0, 10),
                  )
                ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Project header
            _buildProjectHeader(),
            // Content
            Expanded(child: _buildProjectContent()),
            // Footer
            _buildProjectFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectHeader() {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primaryAccent.withValues(alpha: 0.15),
            AppColors.secondaryAccent.withValues(alpha: 0.08),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.primaryAccent.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                  color: AppColors.primaryAccent.withValues(alpha: 0.3)),
            ),
            child: const Icon(Icons.phone_android_rounded,
                color: AppColors.primaryAccent, size: 24),
          ),
          const Spacer(),
          if (widget.project.isFeatured)
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Text(
                'Featured',
                style: GoogleFonts.inter(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildProjectContent() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.project.title,
            style: GoogleFonts.inter(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: AppColors.primaryText,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          Text(
            widget.project.description,
            style: GoogleFonts.inter(
              fontSize: 13,
              color: AppColors.secondaryText,
              height: 1.6,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 12),
          // Key features (first 3)
          ...widget.project.features.take(3).map((f) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  children: [
                    const Icon(Icons.check_circle_rounded,
                        size: 14, color: AppColors.accentGreen),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        f,
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: AppColors.secondaryText,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              )),
          const SizedBox(height: 12),
          // Tech tags
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: widget.project.technologies
                .take(4)
                .map((t) => Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppColors.primaryAccent.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                            color: AppColors.primaryAccent
                                .withValues(alpha: 0.2)),
                      ),
                      child: Text(
                        t,
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryAccent,
                        ),
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectFooter() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          if (widget.project.githubUrl != null)
            _iconButton(
              Icons.code_rounded,
              () => UrlService.launch(widget.project.githubUrl!),
              'GitHub',
            ),
          if (widget.project.liveUrl != null) ...[
            const SizedBox(width: 10),
            _iconButton(
              Icons.open_in_new_rounded,
              () => UrlService.launch(widget.project.liveUrl!),
              'Live Demo',
            ),
          ],
        ],
      ),
    );
  }

  Widget _iconButton(IconData icon, VoidCallback onTap, String tooltip) {
    return Tooltip(
      message: tooltip,
      child: GestureDetector(
        onTap: onTap,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.primaryAccent.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                  color: AppColors.primaryAccent.withValues(alpha: 0.2)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 15, color: AppColors.primaryAccent),
                const SizedBox(width: 6),
                Text(
                  tooltip,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryAccent,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
