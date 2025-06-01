import 'package:demologin/controllers/auth_controller.dart';
import 'package:demologin/views/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(AuthController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            children: [
              SizedBox(height: 100),
              Image.asset(
                "assets/images/Logomark_Full Color.png",
                width: 200,
                height: 200,
              ),
              SizedBox(height: 20),
              Text(
                "Welcome to Demo Login",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 50),

              CircularProgressIndicator(color: Colors.amber[700]),
            ],
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
