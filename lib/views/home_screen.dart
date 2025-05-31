import 'package:demologin/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              authController.logout();
            },
          ),
        ],
      ),
      body: Center(
        child: Text(
          "Welcome to the Home Screen!",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
