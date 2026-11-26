import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ContactController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final subjectController = TextEditingController();
  final messageController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final RxBool isSubmitting = false.obs;
  final RxString submitStatus = ''.obs; // '', 'success', 'error'

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    subjectController.dispose();
    messageController.dispose();
    super.onClose();
  }

  String? validateName(String? val) {
    if (val == null || val.trim().isEmpty) return 'Name is required';
    if (val.trim().length < 2) return 'Name must be at least 2 characters';
    return null;
  }

  String? validateEmail(String? val) {
    if (val == null || val.trim().isEmpty) return 'Email is required';
    if (!GetUtils.isEmail(val.trim())) return 'Please enter a valid email';
    return null;
  }

  String? validateSubject(String? val) {
    if (val == null || val.trim().isEmpty) return 'Subject is required';
    return null;
  }

  String? validateMessage(String? val) {
    if (val == null || val.trim().isEmpty) return 'Message is required';
    if (val.trim().length < 20) return 'Message must be at least 20 characters';
    return null;
  }

  Future<void> submitForm() async {
    if (!formKey.currentState!.validate()) return;

    isSubmitting.value = true;
    submitStatus.value = '';

    // Simulate form submission delay
    // ⚠️ NOTE: This form does NOT actually send emails.
    // To enable real email sending, integrate:
    // - EmailJS (https://www.emailjs.com/)
    // - A backend API endpoint
    // - Firebase Cloud Functions
    await Future.delayed(const Duration(seconds: 2));

    // Show info that backend integration is needed
    isSubmitting.value = false;
    submitStatus.value = 'info';
  }

  void resetStatus() {
    submitStatus.value = '';
  }

  void clearForm() {
    nameController.clear();
    emailController.clear();
    subjectController.clear();
    messageController.clear();
    submitStatus.value = '';
  }
}
