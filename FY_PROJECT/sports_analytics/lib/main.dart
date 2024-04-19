// Importing the Flutter material library which contains
// the core Flutter framework and material design widgets.


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sport_analytics/screens/dashboard/dashboard_screen.dart';
import 'package:sport_analytics/screens/home/home_screen.dart';
import 'package:sport_analytics/screens/home/provider/user_state.dart';


// Importing the custom screens from the 'screen.dart' file.
import 'package:sport_analytics/screens/screen.dart';
import 'package:sport_analytics/utils/user_preferences.dart';

// The entry point of the application.
void main() async {
  // Running the Flutter application by invoking the runApp function
  // and passing an instance of MyApp as the root widget.

  WidgetsFlutterBinding.ensureInitialized();
  final isLoggedIn = await UserPreferences.isLoggedIn();
  runApp(
      ChangeNotifierProvider(
        create: (context) => UserNotifier(),
        child: MyApp(isLoggedIn: isLoggedIn),)
     );
}

// MyApp is a StatelessWidget representing the root of the application.
class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  // Constructing a const MyApp instance.
  MyApp({required this.isLoggedIn});

  // The build method returns the main widget tree of the application.
  @override
  Widget build(BuildContext context) {
    // MaterialApp is a widget that configures the top-level Navigator,
    // the theme, and the home widget of the application.
    return MaterialApp(
      // The title of the application.
      title: 'Sport Analytics',

      // The theme data that defines the visual styling of the application.
      // In this case, it uses the default ThemeData.

      theme: ThemeData(),

      // The home property sets the default route for the application.
      // In this case, it is set to the WelcomePage widget.

      initialRoute: isLoggedIn ? '/home' : '/welcome',
      routes: {
        '/welcome': (context) => const WelcomePage(),
        '/home': (context) => const DashboardScreen(),
      },

      // Hides the "Debug" banner in the top-right corner of the screen.
      debugShowCheckedModeBanner: false,
    );
  }
}
