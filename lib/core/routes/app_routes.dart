import 'package:get/get.dart';
import '../../features/home/bindings/home_binding.dart';
import '../../features/home/views/home_view.dart';

class AppRoutes {
  static const String home = '/';
}

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
  ];
}
