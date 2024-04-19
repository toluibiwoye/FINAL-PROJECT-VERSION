import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:sport_analytics/screens/screen.dart';
import 'package:sport_analytics/utils/user_preferences.dart';
import 'package:sport_analytics/widgets/custom_progress_bar.dart';
import '../widgets/dropdown.dart';
import '../widgets/widget.dart';
import '../constants.dart';
import 'package:http/http.dart' as http;

// RegisterPage is a StatefulWidget for the screen where users can register a new account.
class RegisterPage extends StatefulWidget {
  // Constructor for the RegisterPage widget.
  const RegisterPage({super.key});
  @override
  _RegisterPageState createState() => _RegisterPageState();
}
// _RegisterPageState is the State class for the RegisterPage widget.
class _RegisterPageState extends State<RegisterPage> {

  bool isLoading = false;
  // Boolean to track whether the password is visible or hidden.
  bool passwordVisibility = true;

  // Boolean to track the overall validity of the form.
  bool isValid = true;
  bool isReg = false;

  // Nullable error messages for different fields.
  String? nameError, emailError, phoneError, passwordError;
  String selectedRole = 'Athlete';

  // TextEditingController for managing user input in the name field.
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  // TextEditingController for managing user input in the email field.
  TextEditingController emailController = TextEditingController();

  // TextEditingController for managing user input in the phone field.
  TextEditingController phoneController = TextEditingController();

  // TextEditingController for managing user input in the password field.
  TextEditingController passwordController = TextEditingController();


  Future<void> registerUser() async {
    final ProgressDialog pr = ProgressDialog(context);
    pr.show();
    try {
      setState(() {
        isLoading = true;
      });
      String firstName = firstNameController.text;
      String lastName = lastNameController.text;
      String email = emailController.text;
      String phone = phoneController.text;
      String password = passwordController.text;
      String role = selectedRole.toLowerCase();
      // Prepare the registration data
      Map<String, String> data = {
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "phoneNumber" : phone,
        "role": role, // Ensure lowercase for consistency
        "password": password,
      };
      final response = await http.post(
          Uri.parse("http://10.0.2.2:4000/api/v1/users/register"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );
      // Check if the request was successful (status code 2xx)
      if (response.statusCode >= 200 && response.statusCode < 300) {
        // Parse the response body (assuming it's in JSON format)
        Map<String, dynamic> responseBody = json.decode(response.body);

        // Check if the registration was successful
        if (responseBody['error'] == false) {
          // Registration successful, you can handle the response accordingly
          print(responseBody['message']);
          print(responseBody['user']);
          Future.delayed(Duration.zero, () async{
            await Navigator.push(context, MaterialPageRoute(builder: (context) => const SignInPage()));
          });
          setState(() {
            isReg = true;
          });
        } else {
          // Registration failed, handle the error message
          print(responseBody['message']);
        }
      } else {
        // Request failed, handle the error
        print("Request failed with status code ${response.statusCode}");
      }
    } catch (e) {
      // Handle any unexpected errors
      print("An error occurred: $e");
    } finally {
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
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              // Padding widget for adding space around the main content.
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                // Column widget to organize content in a vertical layout.
                child: Column(
                  children: [
                    // Flexible widget to allow the column to take available vertical space.
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Headline text for the registration page.
                          const Text(
                            "Register",
                            style: kHeadline,
                          ),
                          const SizedBox(height: 10.0),
                          // Body text providing additional information about registration.
                          const Text(
                            "Create new account to get started.",
                            style: kBodySmall,
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          // CustomTextField for entering the full name.
                          CustomTextField(
                            hintText: 'First Name',
                            inputType: TextInputType.name,
                            controller: firstNameController,
                            errorText: nameError,
                          ),
                          CustomTextField(
                            hintText: 'Last Name',
                            inputType: TextInputType.name,
                            controller: lastNameController,
                            errorText: nameError,
                          ),
                          // CustomTextField for entering the email address.
                          CustomTextField(
                            hintText: 'Email address',
                            inputType: TextInputType.emailAddress,
                            controller: emailController,
                            errorText: emailError,
                          ),
                          // CustomTextField for entering the phone number.
                          CustomTextField(
                            hintText: 'Phone',
                            inputType: TextInputType.phone,
                            controller: phoneController,
                            errorText: phoneError,
                          ),
                          // CustomPasswordField for entering the password.
                          CustomPasswordField(
                            isPasswordVisible: passwordVisibility,
                            onTap: () {
                              setState(() {
                                passwordVisibility = !passwordVisibility;
                              });
                            },
                          ),
                          DropdownWidget(
                            selectedRole: selectedRole,
                            onChanged: (newValue) {
                              setState(() {
                                selectedRole = newValue;
                              });
                            },
                          )
                        ],
                      ),
                    ),
                    // Row widget for displaying text and a button to navigate to the sign-in page.
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account? ",
                          style: kBodyText,
                        ),
                        TextButton(
                          onPressed: () {
                            // Navigate to the SignInPage when the button is pressed.
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const SignInPage()));
                          },
                          child: Text(
                            "Sign In",
                            style: kBodyText.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // MyTextButton for initiating the registration process.
                    MyTextButton(
                      buttonName: 'Register',
                      onTap: () async {
                        setState(() {
                          isValid = validateFields();
                        });
                        if(!isValid) {
                          debugPrint('Processing registration');
                          await registerUser(); // Wait for registration to complete
                          // Remove the progress dialog here
                        }
                      },
                      bgColor: Colors.white,
                      textColor: Colors.black87,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    const SizedBox(
                      height: 10.0,
                    )
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
    isValid = true; // Set to true by default

    // Check if the name field is empty.
    if (firstNameController.text.isEmpty && lastNameController.text.isEmpty) {
      setState(() {
        nameError = "Name is required";
      });
      isValid = false;
    } else {
      nameError = null;
    }

    // Check if the email field is empty.
    if (emailController.text.isEmpty) {
      setState(() {
        emailError = "Email is required";
      });
      isValid = false;
    } else if (!isEmailValid(emailController.text)) {
      setState(() {
        emailError = "Please enter a valid email address";
      });
      isValid = false;
    } else {
      emailError = null;
    }

    // Check if the phone field is empty.
    if (phoneController.text.isEmpty) {
      setState(() {
        phoneError = "Phone number is required";
      });
      isValid = false;
    } else {
      phoneError = null;
    }

    // Check if the password field is empty or not strong enough.
    if (passwordController.text.isEmpty) {
      setState(() {
        passwordError = "Password is required";
      });
      isValid = false;
    } else if (!isPasswordStrong(passwordController.text)) {
      setState(() {
        passwordError = "Please enter a strong password (at least 8 characters)";
      });
      isValid = false;
    } else {
      passwordError = null;
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

// Method to check if the password is strong enough.
  bool isPasswordStrong(String password) {
// Check if the length of the password is long enough.
    return password.length >= 5;
  }
}