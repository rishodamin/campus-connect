import 'package:campus_connect/auth/screens/sign_up_screen.dart';
import 'package:campus_connect/home/screens/home_screen.dart';
import 'package:campus_connect/providers/user_provider.dart';
import 'package:campus_connect/resources/auth_methods.dart';
import 'package:campus_connect/utils/colors.dart';
import 'package:campus_connect/utils/global_variables.dart';
import 'package:campus_connect/utils/utils.dart';
import 'package:campus_connect/widgets/text_field_input.dart';
import 'package:flutter/material.dart';
//import 'package:instagram_clone/resources/auth_methods.dart';
// import 'package:instagram_clone/responsive/mobile_screen_layout.dart';
// import 'package:instagram_clone/responsive/responsive_layout_screen.dart';
// import 'package:instagram_clone/responsive/web_screen_layout.dart';
// import 'package:instagram_clone/screens/sign_up_screen.dart';
// import 'package:instagram_clone/utils/colors.dart';
// import 'package:instagram_clone/utils/global_variables.dart';
// import 'package:instagram_clone/utils/utils.dart';
//import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().logInUser(
      email: _emailController.text,
      password: _passwordController.text,
    );
    setState(() {
      _isLoading = false;
    });
    if (res != 'succes') {
      showSnackBar(res, context);
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    }
  }

  void navigateToSignUp() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SignUpScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: width > webScreenWidth
              ? EdgeInsets.symmetric(horizontal: width / 3)
              : const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //flex box 0
              Flexible(flex: 2, child: Container()),
              Image.asset('assets/logo.png'),
              //flex box 1
              Flexible(flex: 2, child: Container()),

              //Logo
              const Text(
                'Campus Connect',
                style: TextStyle(
                  fontSize: 32,
                  color: mainColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 64),

              // email
              TextFieldInput(
                hintText: 'Enter your College email',
                textInputType: TextInputType.emailAddress,
                textEditingController: _emailController,
              ),

              const SizedBox(height: 24),

              // password
              TextFieldInput(
                hintText: 'Enter your password',
                textInputType: TextInputType.text,
                textEditingController: _passwordController,
                isPass: true,
              ),

              const SizedBox(height: 24),

              //button
              InkWell(
                onTap: loginUser,
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(4),
                      ),
                    ),
                    color: mainColor,
                  ),
                  child: _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        )
                      : const Text(
                          'Log in',
                          style: TextStyle(color: Colors.white),
                        ),
                ),
              ),
              Flexible(flex: 1, child: Container()),
              // const Text('or'),
              // Flexible(flex: 1, child: Container()),
              // InkWell(
              //   onTap: () {
              //     Provider.of<UserProvider>(context, listen: false).guestMode();
              //     Navigator.of(context).pushReplacement(MaterialPageRoute(
              //         builder: (context) => const ResponsiveLayout(
              //               webScreenLayout: WebScreenLayout(),
              //               mobileScreenLayout: MobileScreenLayout(),
              //               isGuest: true,
              //             )));
              //   },
              //   child: Container(
              //     width: double.infinity,
              //     alignment: Alignment.center,
              //     padding: const EdgeInsets.symmetric(vertical: 12),
              //     decoration: const ShapeDecoration(
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.all(
              //           Radius.circular(4),
              //         ),
              //       ),
              //       color: Color.fromRGBO(40, 40, 40, 1),
              //     ),
              //     child: const Text('Enter as a Guest'),
              //   ),
              // ),
              // flex box 2
              Flexible(flex: 3, child: Container()),

              // Transitioning to sign up
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: const Text(
                      "Don't have an account?",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: navigateToSignUp,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: const Text(
                        "Sign up.",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Flexible(flex: 3, child: Container()),
            ],
          ),
        ),
      ),
    );
  }
}
