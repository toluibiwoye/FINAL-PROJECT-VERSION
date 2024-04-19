import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:sport_analytics/screens/dashboard/dashboard_screen.dart';

import 'package:sport_analytics/utils/reg_response.dart';
import '../constants.dart';
import '../screens/screen.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import '../utils/user_preferences.dart';
import '../widgets/widget.dart';
import 'package:http/http.dart' as http;

import 'home/home_screen.dart';

// SignInPage is a StatefulWidget for the screen where users can sign in.
class SignInPage extends StatefulWidget {
  // Constructor for the SignInPage widget.
  const SignInPage({super.key});

  @override
  _SignInPageState createState() => _SignInPageState();
}
// _SignInPageState is the State class for the SignInPage widget.
class _SignInPageState extends State<SignInPage> {
  // Boolean to track whether the password is visible or hidden.
  bool isPasswordVisible = true;

  // Boolean to track the overall validity of the form.
  bool isValid = true;
  bool isLoading = false;
  late User user;
  // Nullable error messages for email and password fields.
  String? emailError, passwordError;

  // TextEditingController for managing user input in the email field.
  TextEditingController emailController = TextEditingController();

  // TextEditingController for managing user input in the password field.
  TextEditingController passwordController = TextEditingController();

  Future<void> login() async {
    final ProgressDialog pr = ProgressDialog(context);
    pr.show();
    setState(() {
      isLoading = true;
    });

    final String email = emailController.text;
    final String password = passwordController.text;

    // login API endpoint
    final Uri loginUri = Uri.parse("http://10.0.2.2:4000/api/v1/users/login");

    Map<String, String> data = {
      "email": email,
      "password": password,
    };
    try {
      final response = await http.post(
        loginUri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );

      // Check if the request was successful
      if (response.statusCode == 200) {
        // Decode the response into RegisterResponse object
        Map<String, dynamic> responseBody = json.decode(response.body);
        print(responseBody['message']);
        print(responseBody['user']);
          RegisterResponse registerResponse = RegisterResponse.fromJson(responseBody);


          // Assuming your UserPreferences class has these methods for storing user information
          if (!registerResponse.error) {
            await UserPreferences.setUserEmail(registerResponse.user.email);
            await UserPreferences.setUserFirstName(registerResponse.user.firstName);
            await UserPreferences.setUserLastName(registerResponse.user.lastName);
            await UserPreferences.setUserPhone(registerResponse.user.phoneNumber);
            await UserPreferences.setUserRole(registerResponse.user.role);
            // Assuming you have a method for storing token as well
            await UserPreferences.setUserToken(registerResponse.token!);
            await UserPreferences.setUserLoggedIn(true);

            Future.delayed(Duration.zero, () async {
              await Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const DashboardScreen()));
            });
          } else {
            // Handle registration error
            print("Login failed: ${registerResponse.message}");
          }
        } else {
          // Handle HTTP error (e.g., show an error message)
        print("Login failed: HTTP status code ${response.statusCode}");
      }
    } catch (e) {
      // Handle any errors that occur during the request
      print("An error occurred during login: $e");
    } finally {
      // Hide the loading indicator
      setState(() {
        isLoading = false;
      });
      pr.hide();
    }
  }
  @override
  Widget build(BuildContext context) {
    // Scaffold widget for providing a basic app structure.
    return Scaffold(
      backgroundColor: kBackgroundColor,   // Background color of the entire screen.
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        elevation: 0,
      ),
      // SafeArea widget to ensure content is displayed within safe areas on different devices.
      body: SafeArea(
        // CustomScrollView for a scrollable page.
        child: CustomScrollView(
          reverse: true,
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              // Padding widget for adding space around the main content.
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                // Column widget to organize content in a vertical layout.
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Flexible widget to allow the column to take available vertical space.
                    Flexible(
                      fit: FlexFit.loose,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Headline text welcoming users back.
                          const Text(
                            "Welcome back.",
                            style: kHeadline,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          // Body text providing additional information about the return.
                          const Text(
                            "Welcome back! A lot is waiting for you.",
                            style: kBodySmall,
                          ),
                          const SizedBox(
                            height: 60,
                          ),
                          // CustomTextField for entering the email address.
                          CustomTextField(
                            hintText: 'Email',
                            inputType: TextInputType.emailAddress,
                            controller: emailController,
                            errorText: emailError,
                          ),
                          // CustomPasswordField for entering the password.
                          CustomPasswordField(
                            isPasswordVisible: isPasswordVisible,
                            onTap: () {
                              setState(() {
                                isPasswordVisible = !isPasswordVisible;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    // Row widget for displaying text and a gesture to navigate to the registration page.
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account? ",
                          style: kBodyText,
                        ),
                        GestureDetector(
                          onTap: () {
                            // Navigate to the RegisterPage when the text is tapped.
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RegisterPage(),
                              ),
                            );
                          },
                          child: Text(
                            'Register',
                            style: kBodyText.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // MyTextButton for initiating the sign-in process.
                    MyTextButton(
                      buttonName: 'Sign In',
                      onTap: () async{
                        // Validate form fields before proceeding.
                        setState(() {
                          isValid = validateFields();
                        });
                        // If the form is valid, extract email and password for further processing.
                        if (!isValid) {
                          // Perform sign-in logic here.
                          debugPrint('Processing logging in');
                          await login();
                        }
                      },
                      bgColor: Colors.white,
                      textColor: Colors.black87,
                    ),
                    const SizedBox(height: 10)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Method to validate form fields.
  bool validateFields() {
    isValid = true;

    // Check if the email field is empty.
    if (emailController.text.isEmpty) {
      setState(() {
        emailError = "Email is required";
      });
      isValid = false;
    }
    // Check if the email is a valid format.
    else if (!isEmailValid(emailController.text)) {
      setState(() {
        emailError = "Please enter a valid email address";
      });
      isValid = false;
    }

    // Check if the password field is empty.
    if (passwordController.text.isEmpty) {
      setState(() {
        passwordError = "Password is required";
      });
      isValid = false;
    }

    return isValid;
  }

  // Method to check if the email is in a valid format.
  bool isEmailValid(String email) {
    // Using regular expression for email validation.
    String emailPattern = r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
    RegExp regExp = RegExp(emailPattern);
    return regExp.hasMatch(email);
  }
}