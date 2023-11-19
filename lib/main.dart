import 'package:campus_connect/auth/screens/login_screen.dart';
import 'package:campus_connect/auth/screens/sign_up_screen.dart';
import 'package:campus_connect/firebase_options.dart';
import 'package:campus_connect/providers/user_provider.dart';
import 'package:campus_connect/utils/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        title: 'Campus Connect',
        theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: const Color.fromRGBO(254, 240, 227, 1),
        ),
        debugShowCheckedModeBanner: false,
        home: const LoginScreen(),
      ),
    );
  }
}
