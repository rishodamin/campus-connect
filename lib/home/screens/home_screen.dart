import 'package:campus_connect/auth/screens/login_screen.dart';
import 'package:campus_connect/models/user.dart';
import 'package:campus_connect/providers/user_provider.dart';
import 'package:campus_connect/resources/auth_methods.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    addData();
  }

  addData() async {
    Provider.of<UserProvider>(context, listen: false).refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      body: Center(
        child: (user == null)
            ? const CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(user.rollNo),
                  const SizedBox(height: 100),
                  GestureDetector(
                    onTap: () {
                      AuthMethods().logOut();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'Log Out',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
