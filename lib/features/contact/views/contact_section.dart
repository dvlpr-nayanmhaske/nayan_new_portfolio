import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/constants.dart';
import '../../../core/responsive/responsive_utils.dart';
import '../../../core/services/url_service.dart';
import '../../../core/widgets/widgets.dart';
import '../controllers/contact_controller.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ContactController>();
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
                  label: 'Contact',
                  title: "Let's Work\nTogether",
                  subtitle:
                      "Have a project in mind? I'd love to hear about it. Let's build something great together.",
                ),
              ),
              const SizedBox(height: 64),
              isMobile || isTablet
                  ? _buildMobileLayout(context, controller)
                  : _buildDesktopLayout(context, controller),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(
      BuildContext context, ContactController controller) {
    return AnimatedVisibility(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 40, child: _buildContactInfo(context)),
          const SizedBox(width: 60),
          Expanded(flex: 60, child: _buildContactForm(context, controller)),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(
      BuildContext context, ContactController controller) {
    return Column(
      children: [
        AnimatedVisibility(child: _buildContactInfo(context)),
        const SizedBox(height: 40),
        AnimatedVisibility(
          delay: const Duration(milliseconds: 200),
          child: _buildContactForm(context, controller),
        ),
      ],
    );
  }

  Widget _buildContactInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedCard(
          enableHover: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Let's Connect",
                style: GoogleFonts.inter(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryText,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                "I'm always open to discussing new opportunities, interesting projects, or just having a chat about Flutter development.",
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: AppColors.secondaryText,
                  height: 1.7,
                ),
              ),
              const SizedBox(height: 28),
              _contactItem(
                Icons.email_rounded,
                'Email',
                AppStrings.email,
                AppColors.primaryAccent,
                () => UrlService.launchEmail(AppStrings.email),
              ),
              const SizedBox(height: 16),
              _contactItem(
                Icons.business_center_rounded,
                'LinkedIn',
                'Connect with me',
                AppColors.secondaryAccent,
                () => UrlService.launch(AppStrings.linkedIn),
              ),
              const SizedBox(height: 16),
              _contactItem(
                Icons.code_rounded,
                'GitHub',
                'Check my repos',
                AppColors.accentGreen,
                () => UrlService.launch(AppStrings.github),
              ),
              const SizedBox(height: 16),
              _contactItem(
                Icons.chat_rounded,
                'WhatsApp',
                'Message me directly',
                AppColors.accentGreen,
                () => UrlService.launchWhatsApp(
                    AppStrings.whatsapp.replaceAll(RegExp(r'[^\d]'), ''),
                    message: "Hi Nayan, I'd like to discuss a project."),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        // Social icons row
        AnimatedCard(
          enableHover: false,
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _socialIcon(Icons.code_rounded, AppStrings.github, AppColors.primaryText),
              _socialIcon(Icons.business_center_rounded, AppStrings.linkedIn, AppColors.secondaryAccent),
              _socialIcon(Icons.chat_rounded, AppStrings.whatsapp, AppColors.accentGreen),
              _socialIcon(Icons.email_rounded, 'mailto:${AppStrings.email}', AppColors.primaryAccent),
            ],
          ),
        ),
      ],
    );
  }

  Widget _contactItem(
    IconData icon,
    String label,
    String value,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Icon(icon, size: 20, color: color),
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.tertiaryText,
                    letterSpacing: 0.5,
                  ),
                ),
                Text(
                  value,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryText,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _socialIcon(IconData icon, String url, Color color) {
    return GestureDetector(
      onTap: () => UrlService.launch(url),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: color.withValues(alpha: 0.2)),
          ),
          child: Center(
            child: Icon(icon, size: 20, color: color),
          ),
        ),
      ),
    );
  }

  Widget _buildContactForm(BuildContext context, ContactController controller) {
    return AnimatedCard(
      enableHover: false,
      child: Form(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Send a Message',
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppColors.primaryText,
              ),
            ),
            const SizedBox(height: 24),
            // Name + Email Row
            LayoutBuilder(builder: (context, constraints) {
              if (constraints.maxWidth < 500) {
                return Column(
                  children: [
                    _formField(
                        controller.nameController, 'Full Name', Icons.person_rounded,
                        validator: controller.validateName),
                    const SizedBox(height: 16),
                    _formField(
                        controller.emailController, 'Email Address', Icons.email_rounded,
                        validator: controller.validateEmail,
                        keyboardType: TextInputType.emailAddress),
                  ],
                );
              }
              return Row(
                children: [
                  Expanded(
                    child: _formField(
                        controller.nameController, 'Full Name', Icons.person_rounded,
                        validator: controller.validateName),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _formField(
                        controller.emailController, 'Email Address', Icons.email_rounded,
                        validator: controller.validateEmail,
                        keyboardType: TextInputType.emailAddress),
                  ),
                ],
              );
            }),
            const SizedBox(height: 16),
            _formField(
                controller.subjectController, 'Subject', Icons.subject_rounded,
                validator: controller.validateSubject),
            const SizedBox(height: 16),
            _formField(
              controller.messageController,
              'Your Message',
              Icons.message_rounded,
              validator: controller.validateMessage,
              maxLines: 5,
            ),
            const SizedBox(height: 24),
            // Submit button + status
            Obx(() => _buildSubmitArea(controller)),
            // Info note
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.secondaryAccent.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                    color: AppColors.secondaryAccent.withValues(alpha: 0.2)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.info_outline_rounded,
                      size: 16, color: AppColors.secondaryAccent),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'To activate email sending, integrate EmailJS or a backend API. See contact_controller.dart.',
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        color: AppColors.secondaryAccent,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _formField(
    TextEditingController ctrl,
    String hint,
    IconData icon, {
    String? Function(String?)? validator,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: ctrl,
      validator: validator,
      maxLines: maxLines,
      keyboardType: keyboardType,
      style: GoogleFonts.inter(
          fontSize: 14,
          color: AppColors.primaryText,
          fontWeight: FontWeight.w400),
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: maxLines == 1 ? Icon(icon, size: 18) : null,
        filled: true,
        fillColor: AppColors.primaryBackground,
        hintStyle:
            GoogleFonts.inter(fontSize: 14, color: AppColors.tertiaryText),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:
              const BorderSide(color: AppColors.primaryAccent, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        contentPadding:
            EdgeInsets.symmetric(horizontal: 16, vertical: maxLines > 1 ? 14 : 0),
      ),
    );
  }

  Widget _buildSubmitArea(ContactController controller) {
    if (controller.submitStatus.value == 'info') {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.accentGreen.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(10),
          border:
              Border.all(color: AppColors.accentGreen.withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            const Icon(Icons.info_rounded,
                color: AppColors.accentGreen, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                "Form validated! Backend integration needed to send actual emails. Connect EmailJS or your API.",
                style: GoogleFonts.inter(
                    fontSize: 13,
                    color: AppColors.accentGreen,
                    height: 1.5),
              ),
            ),
            GestureDetector(
              onTap: controller.clearForm,
              child: const Icon(Icons.close_rounded,
                  color: AppColors.accentGreen, size: 18),
            ),
          ],
        ),
      );
    }

    return SizedBox(
      width: double.infinity,
      child: AppButton(
        label: controller.isSubmitting.value ? 'Sending...' : 'Send Message',
        isLoading: controller.isSubmitting.value,
        trailingIcon: Icons.send_rounded,
        onTap: controller.submitForm,
      ),
    );
  }
}
