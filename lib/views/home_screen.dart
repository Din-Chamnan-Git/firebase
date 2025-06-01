import 'package:demologin/controllers/auth_controller.dart';
import 'package:demologin/views/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

      bottomNavigationBar: BottomAppBar(
        color: Colors.amber[700],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.home, color: Colors.white),
              onPressed: () {
                // Navigate to home
              },
            ),

            IconButton(
              icon: Icon(Icons.favorite, color: Colors.white),
              onPressed: () {
                // Navigate to profile
              },
            ),
            IconButton(
              icon: Icon(Icons.person, color: Colors.white),
              onPressed: () {
                Get.to(Profile());
              },
            ),

            IconButton(
              icon: Icon(Icons.settings, color: Colors.white),
              onPressed: () {
                // Navigate to settings
              },
            ),
          ],
        ),
      ),
    );
  }
}
