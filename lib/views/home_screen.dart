import 'package:demologin/controllers/MovieController.dart';
import 'package:demologin/controllers/auth_controller.dart';
import 'package:demologin/views/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final authController = Get.find<AuthController>();
  final movieCtrl = Get.find<MovieController>();

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
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 250,
            child: Obx(() {
              if (movieCtrl.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              } else if (movieCtrl.upmovie.isEmpty) {
                return Center(child: Text("No upcoming movies found."));
              } else {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: movieCtrl.upmovie.length,
                  itemBuilder: (context, index) {
                    final movie = movieCtrl.upmovie[index];
                    final MyImageUrl =
                        "https://image.tmdb.org/t/p/w500${movie.posterPath}";

                    return Container(
                      width: 350,
                      margin: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              MyImageUrl,
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
            }),
          ),

          SizedBox(
            width: double.infinity,
            height: 250,
            child: Obx(() {
              if (movieCtrl.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              } else if (movieCtrl.movies.isEmpty) {
                return Center(child: Text("No upcoming movies found."));
              } else {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: movieCtrl.movies.length,
                  itemBuilder: (context, index) {
                    final movie = movieCtrl.movies[index];
                    final MyImageUrl =
                        "https://image.tmdb.org/t/p/w500${movie.posterPath}";

                    return Container(
                      width: 130,
                      margin: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              MyImageUrl,
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
            }),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.amber[700],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.home, color: Colors.white),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.favorite, color: Colors.white),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.person, color: Colors.white),
              onPressed: () {
                Get.to(() => Profile());
              },
            ),
            IconButton(
              icon: Icon(Icons.settings, color: Colors.white),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
