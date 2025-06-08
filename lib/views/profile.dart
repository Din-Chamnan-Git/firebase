import 'package:demologin/controllers/auth_controller.dart';
import 'package:demologin/views/edit_profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    var authController = Get.find<AuthController>();

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("Profile"),
        centerTitle: true,
        backgroundColor: Colors.amber[700],
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              authController.logout();
            },
          ),
        ],
      ),
      body: Obx(
        () => Column(
          children: [
            SizedBox(height: 20),
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage:
                        authController.userModel.value?.profilePictureUrl !=
                                null
                            ? NetworkImage(
                              authController
                                  .userModel
                                  .value!
                                  .profilePictureUrl!,
                            )
                            : AssetImage('assets/images/default_profile.png')
                                as ImageProvider,
                  ),

                  Positioned(
                    bottom: 0,
                    right: 0,
                    // left: -10,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: IconButton(
                        onPressed: () {
                          Get.to(
                            () => EditProfile(),
                            transition: Transition.rightToLeft,
                            duration: Duration(milliseconds: 300),
                          );
                        },
                        icon: Icon(Icons.edit, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),
            Text(
              authController.userModel.value!.username,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            Text(
              authController.userModel.value!.email,
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            SizedBox(height: 20),

            SizedBox(height: 20),

            //setting
            Divider(height: 0, thickness: 1, color: Colors.grey[400]),
            ListTile(
              leading: Icon(Icons.settings, color: Colors.amber),
              title: Text("Settings"),
              onTap: () {
                // Navigate to settings page
                Get.toNamed('/settings');
              },
            ),
            // About
            Divider(height: 0, thickness: 1, color: Colors.grey[400]),
            ListTile(
              leading: Icon(Icons.info, color: Colors.amber),
              title: Text("About"),
              onTap: () {
                // Navigate to about page
                Get.toNamed('/about');
              },
            ),
            // Help
            Divider(height: 0, thickness: 1, color: Colors.grey[400]),
            ListTile(
              leading: Icon(Icons.help, color: Colors.amber),
              title: Text("Help"),
              onTap: () {
                // Navigate to help page
                Get.toNamed('/help');
              },
            ),
            // Privacy Policy
            Divider(height: 0, thickness: 1, color: Colors.grey[400]),
            ListTile(
              leading: Icon(Icons.privacy_tip, color: Colors.amber),
              title: Text("Privacy Policy"),
              onTap: () {
                // Navigate to privacy policy page
                Get.toNamed('/privacy-policy');
              },
            ),
            Divider(height: 0, thickness: 1, color: Colors.grey[400]),
            // Terms of Service
            ListTile(
              leading: Icon(Icons.article, color: Colors.amber),
              title: Text("Terms of Service"),
              onTap: () {
                // Navigate to terms of service page
                Get.toNamed('/terms-of-service');
              },
            ),
            // Logout
            Divider(height: 0, thickness: 1, color: Colors.grey[400]),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.red),
              title: Text("Logout"),
              onTap: () {
                authController.logout();
              },
            ),
          ],
        ),
      ),
    );
  }
}
