import 'dart:io';

import 'package:demologin/controllers/auth_controller.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final authController = Get.find<AuthController>();
  var selectedImage = '';

  Future<void> selectImage() async {
    final imagePicker = ImagePicker();
    final XFile? file = await imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxHeight: 400,
    );

    if (file == null) {
      Get.snackbar('Error', 'No image selected');
      return;
    }
    try {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('profilePictures')
          .child('${authController.currentUser!.uid}.jpg');

      await storageRef.putFile(File(file.path));
      final imageUrl = await storageRef.getDownloadURL();

      await authController.updateProfilePicture(
        authController.currentUser!.uid,
        imageUrl,
      );

      setState(() {
        selectedImage = file.path;
      });

      // ✅ Dismiss the dialog
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }

      Get.snackbar('Success', 'Profile picture updated!');
    } catch (e) {
      // ✅ Ensure dialog is dismissed even on error
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }

      print('Image upload failed: $e');
      Get.snackbar('Error', 'Failed to update profile picture.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),

      body: Obx(
        () => Center(
          child: Column(
            children: [
              SizedBox(height: 20),
              InkWell(
                onTap: () {
                  selectImage();
                },

                child: CircleAvatar(
                  radius: 60,
                  backgroundImage:
                      authController.userModel.value?.profilePictureUrl != null
                          ? NetworkImage(
                            authController.userModel.value!.profilePictureUrl!,
                          )
                          : AssetImage('assets/images/default_profile.png'),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Edit Profile',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Add functionality to edit profile
                },
                child: Text('Edit Profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
