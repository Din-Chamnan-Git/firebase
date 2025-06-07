import 'package:demologin/controllers/auth_controller.dart';
import 'package:demologin/views/edit_profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});



  @override
  Widget build(BuildContext context) {
    var authController = Get.find<AuthController>();

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(),
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
      ),
    );
  }
}
