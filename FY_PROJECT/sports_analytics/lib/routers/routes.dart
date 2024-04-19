import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:sport_analytics/screens/screen.dart';

// Utility class to manage route names and configurations using the GetX library.
class RouteHelper {
  // Define route names as constants for clarity and avoid magic strings.
  static const String welcomeScreen = "/welcome_screen";
  static const String registerScreen = "/register_screen";
  static const String signInScreen = "/signin_screen";

  // List of GetPage configurations for each route, facilitating navigation.
  static List<GetPage> routes = [
    // Configuration for navigating to the WelcomePage.
    GetPage(name: welcomeScreen, page: () => const WelcomePage()),

    // Configuration for navigating to the RegisterPage.
    GetPage(name: registerScreen, page: () => RegisterPage()),

    // Configuration for navigating to the SignInPage.
    GetPage(name: signInScreen, page: () => SignInPage()),
  ];
}