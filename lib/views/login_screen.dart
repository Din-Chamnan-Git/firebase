import 'package:demologin/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final authController = Get.find<AuthController>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/Logomark_Full Color.png",
                width: 200,
                height: 200,
              ),
              SizedBox(height: 20),
              Text(
                "Login",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: TextField(
                  controller: email,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Email",
                    contentPadding: EdgeInsets.all(10),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: TextField(
                  controller: password,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Password",
                    contentPadding: EdgeInsets.all(10),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                width: double.infinity,

                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(vertical: 15),
                  ),
                  onPressed: () {
                    if (email.text.isEmpty || password.text.isEmpty) {
                      Get.snackbar("Error", "Please fill in all fields");
                    } else {
                      authController.login(
                        email.text.trim(),
                        password.text.trim(),
                      );
                    }
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Don't have an account? Sign Up",
                style: TextStyle(fontSize: 16, color: Colors.blue),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
