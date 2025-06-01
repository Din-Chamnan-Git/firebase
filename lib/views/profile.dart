import 'package:demologin/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    var authController = Get.find<AuthController>();

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          SizedBox(height: 20),
          Center(
            child: CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                authController.userModel.value!.profilePictureUrl ??
                    'https://via.placeholder.com/150',
              ),
            ),
          ),
          SizedBox(height: 20),
          Text(
            "Username: ${authController.userModel.value!.username ?? 'No Name'}",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            "Email: ${authController.user.value!.email ?? 'No Email'}",
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              authController.logout();
            },
            child: Text("Logout"),
          ),
        ],
      ),
    );
  }
}
