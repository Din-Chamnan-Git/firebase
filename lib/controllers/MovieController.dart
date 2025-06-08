import 'package:demologin/models/moive_model.dart';
import 'package:demologin/services/ApiService.dart';
import 'package:get/get.dart';

class MovieController extends GetxController {
  var movies = <MovieModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchMovies();
  }

  void fetchMovies() async {
    try {
      var movieList = await ApiService().fetchData();
      movies.value = movieList;

      if (movieList.isNotEmpty) {
        Get.snackbar(
          'Success',
          'Movies loaded successfully!',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar('Error', '$e', snackPosition: SnackPosition.BOTTOM);
    }
  }
}
