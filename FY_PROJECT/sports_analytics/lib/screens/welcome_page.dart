import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:sport_analytics/routers/routes.dart';
import '../constants.dart';
import '../screens/screen.dart';
import '../widgets/widget.dart';

// WelcomePage is a StatelessWidget for the welcome screen of your app.
class WelcomePage extends StatelessWidget {
  // Constructor for the WelcomePage widget.
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold widget for providing a basic app structure.
    return Scaffold(
      backgroundColor: kBackgroundColor,   // Background color of the entire screen.
      // SafeArea widget to ensure content is displayed within safe areas on different devices.
      body: SafeArea(
        // Padding widget for adding space around the main content.
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          // Column widget to organize content in a vertical layout.
          child: Column(
            children: [
              // Flexible widget to allow the column to take available vertical space.
              Flexible(
                child: Column(
                  children: [
                    // Centered container with an image for the team illustration.
                    Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: const Image(
                          image: AssetImage('assets/images/team_illustration.png'),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // Headline text welcoming users to the app.
                    const Text(
                      "Sports Insights and\n Analytics",
                      style: kHeadline,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    // Body text providing additional information about the app.
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: const Text(
                        "Welcome to the sport Insights Hub, where game-changing analytics meet seamless functionality. ",
                        style: kBodyText,
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
              // Container for the registration and sign-in buttons.
              Container(
                height: 60,
                // BoxDecoration for styling the container with a specific color and border radius.
                decoration: BoxDecoration(
                  color: Colors.grey[850],
                  borderRadius: BorderRadius.circular(18),
                ),
                // Row widget to organize buttons in a horizontal layout.
                child: Row(
                  children: [
                    // Expanded widget to make the Register button take equal horizontal space.
                    Expanded(
                      child: MyTextButton(
                        bgColor: Colors.white,
                        buttonName: 'Register',
                        onTap: () {
                          // Navigate to the RegisterPage when the Register button is tapped.
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterPage()));
                        },
                        textColor: kBackgroundColor,
                      ),
                    ),
                    // Expanded widget to make the Sign In button take equal horizontal space.
                    Expanded(
                      child: MyTextButton(
                        bgColor: Colors.transparent,
                        buttonName: 'Sign In',
                        onTap: () {
                          // Navigate to the SignInPage when the Sign In button is tapped.
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => SignInPage(),
                              ));
                        },
                        textColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}