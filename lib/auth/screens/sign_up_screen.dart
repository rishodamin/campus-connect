import 'package:campus_connect/auth/screens/login_screen.dart';
import 'package:campus_connect/home/screens/home_screen.dart';
import 'package:campus_connect/resources/auth_methods.dart';
import 'package:campus_connect/utils/colors.dart';
import 'package:campus_connect/utils/global_variables.dart';
import 'package:campus_connect/utils/utils.dart';
import 'package:campus_connect/widgets/text_field_input.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:instagram_clone/resources/auth_methods.dart';
// import 'package:instagram_clone/responsive/mobile_screen_layout.dart';
// import 'package:instagram_clone/responsive/responsive_layout_screen.dart';
// import 'package:instagram_clone/responsive/web_screen_layout.dart';
// import 'package:instagram_clone/screens/login_screen.dart';
// import 'package:instagram_clone/utils/colors.dart';
// import 'package:instagram_clone/utils/global_variables.dart';
// import 'package:instagram_clone/utils/utils.dart';
// import 'package:instagram_clone/widgets/text_field_input.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _rollNoController = TextEditingController();
  bool _isLoading = false;

  List<String> departments = [
    'Select your Department',
    'AI & DS',
    'AI & ML',
    'Bio Tech',
    'Civil',
    'Computer Science',
    'Electronics and Communication',
    'Information Tech',
    'Mechanical',
  ];
  String department = 'Select your Department';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _rollNoController.dispose();
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signUpUser(
      email: _emailController.text,
      password: _passwordController.text,
      name: _nameController.text,
      department: department,
      rollNo: _rollNoController.text,
    );
    setState(() {
      _isLoading = false;
    });
    if (res != 'succes') {
      showSnackBar(res, context);
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
  }

  void navigateToLogin() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: width > webScreenWidth
              ? EdgeInsets.symmetric(horizontal: width / 3)
              : const EdgeInsets.symmetric(horizontal: 32),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //flex box 1
                  //Flexible(flex: 1, child: Container()),

                  //Logo
                  Image.asset('assets/logo.png'),
                  const SizedBox(height: 64),

                  // name
                  TextFieldInput(
                    hintText: 'Enter your name',
                    textInputType: TextInputType.text,
                    textEditingController: _nameController,
                  ),

                  const SizedBox(height: 24),

                  // email
                  TextFieldInput(
                    hintText: 'Enter your college email',
                    textInputType: TextInputType.emailAddress,
                    textEditingController: _emailController,
                  ),

                  const SizedBox(height: 24),

                  // password
                  TextFieldInput(
                    hintText: 'Enter a password',
                    textInputType: TextInputType.text,
                    textEditingController: _passwordController,
                    isPass: true,
                  ),

                  const SizedBox(height: 24),

                  // password
                  TextFieldInput(
                    hintText: 'Enter your Register No',
                    textInputType: TextInputType.text,
                    textEditingController: _rollNoController,
                  ),

                  const SizedBox(height: 24),
                  // department dropmenu
                  SizedBox(
                    //   padding: const EdgeInsets.only(left: 7),
                    width: double.infinity,
                    child: DropdownButton(
                      onChanged: (value) {
                        setState(() {
                          department = value!;
                        });
                      },
                      value: department,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: departments.map((i) {
                        return DropdownMenuItem(value: i, child: Text(i));
                      }).toList(),
                    ),
                  ),

                  const SizedBox(height: 24),

                  //button
                  InkWell(
                    onTap: signUpUser,
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
                              'Sign Up',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // flex box 2
                  // Flexible(flex: 1, child: Container()),

                  // Transitioning to sign up

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: const Text(
                          "Already have an account? ",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: navigateToLogin,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: const Text(
                            "Login.",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
