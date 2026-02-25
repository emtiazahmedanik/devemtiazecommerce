import 'package:devemtiazecom/feature/auth/screen/login_screen.dart';
import 'package:devemtiazecom/feature/auth/screen/register_screen.dart';
import 'package:devemtiazecom/feature/home/screen/home_screen.dart';
import 'package:devemtiazecom/feature/splash/screen/splash_screen.dart';
import 'package:get/get.dart';

class Routes {
  static const String splashScreen = '/splash-screen';
  static const String homeScreen = '/home-screen';
  static const String loginScreen = '/login-screen';
  static const String registerScreen = '/register-screen';

  static List<GetPage> getPages = [
    GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(name: homeScreen, page: () => const HomeScreen()),
    GetPage(name: loginScreen, page: () => LoginScreen()),
    GetPage(name: registerScreen, page: () => RegisterScreen()),
  ];
}
