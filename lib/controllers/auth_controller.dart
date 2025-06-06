import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demologin/models/user_model.dart';
import 'package:demologin/views/home_screen.dart';
import 'package:demologin/views/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  final Rx<User?> user = Rx<User?>(null);
  final Rx<UserModel?> userModel = Rx<UserModel?>(null);
  User? get currentUser => user.value;
  UserModel? get currentUserModel => userModel.value;

  @override
  void onReady() {
    super.onReady();
    // Listen to auth state changes
    _auth.authStateChanges().listen((User? user) {
      _sigInedStatus(user);
    });
  }

  void _sigInedStatus(User? user) async {
    await Future.delayed(Duration(seconds: 2));
    if (user != null) {
      this.user.value = user;
      userModel.value = await loadData(user.uid); // <-- Add this
      Get.snackbar('Success', 'User is signed in!');
      Get.to(HomeScreen());
    } else {
      this.user.value = null;
      Get.snackbar('Info', 'No user is signed in.');
      Get.to(LoginScreen());
    }
  }

  Future<void> login(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user.value = userCredential.user;
      userModel.value = await loadData(userCredential.user!.uid);

      Get.snackbar('Success', 'Login successful!');

      Get.to(HomeScreen());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar('Error', 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Get.snackbar('Error', 'Wrong password provided for that user.');
      } else {
        Get.snackbar('Error', e.message ?? 'An unknown error occurred.');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    }
  }

  Future<void> signUp(String username, String email, String password) async {
    try {
      UserCredential myuser = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (myuser.user != null) {
        user.value = myuser.user;
      }

      UserModel userModel = UserModel(
        uid: myuser.user!.uid,
        username: username,
        email: email,
        profilePictureUrl: null, // Set default or null for now
      );

      await _firestore
          .collection('users')
          .doc(myuser.user!.uid)
          .set(userModel.toMap());

      Get.snackbar('Success', 'Sign up successful!');
      Get.to(HomeScreen());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar('Error', 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar('Error', 'The account already exists for that email.');
      } else {
        Get.snackbar('Error', e.message ?? 'An unknown error occurred.');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    }
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
      user.value = null;
      Get.snackbar('Success', 'Logout successful!');
      Get.to(
        LoginScreen(),
        transition: Transition.fadeIn,
        duration: Duration(milliseconds: 500),
      ); // Navigate to login screen
    } catch (e) {
      Get.snackbar('Error', 'An error occurred while logging out: $e');
    }
  }

  Future<UserModel> loadData(String uid) async {
    try {
      var doc = await _firestore.collection('users').doc(uid).get();

      if (doc.exists) {
        return UserModel.fromMap(doc.data()!);
      } else {
        Get.snackbar('Error', 'User data not found');
        return UserModel(
          uid: '',
          username: '',
          email: '',
          profilePictureUrl: null,
        );
      }
    } on FirebaseException catch (e) {
      Get.snackbar('Error', 'Failed to load user data: ${e.message}');
      return UserModel(
        uid: '',
        username: '',
        email: '',
        profilePictureUrl: null,
      );
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
      return UserModel(
        uid: '',
        username: '',
        email: '',
        profilePictureUrl: null,
      );
    }
  }

  Future<void> updateProfilePicture(String uid, String imageUrl) async {
    if (uid.isEmpty || imageUrl.isEmpty) {
      Get.snackbar('Error', 'UID or image URL cannot be empty.');
      return;
    }
    try {
      Get.dialog(
        Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );

      await _firestore.collection('users').doc(uid).update({
        'profilePictureUrl': imageUrl,
      });

      userModel.value = await loadData(uid);
      userModel.refresh(); // Refresh the userModel observable

      Get.back(); // Close loading dialog
      Get.snackbar('Success', 'Profile picture updated successfully!');
    } catch (e) {
      Get.back(); // Close loading dialog if open
      print('Error: $e');
      Get.snackbar('Error', 'Failed to update profile picture.');
    }
  }
}
