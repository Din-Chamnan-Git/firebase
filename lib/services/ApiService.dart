import 'dart:convert';
import 'package:demologin/models/moive_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static final String _baseUrl = 'https://api.themoviedb.org/3';
  static final String _API_KEY = dotenv.env['TMDB_API_KEY'] ?? '';

  Future<List<MovieModel>> fetchData() async {
    if (_API_KEY.isEmpty) {
      throw Exception('TMDB API key is not set. Please check your .env file.');
    }

    try {
      final url = Uri.parse(
        '$_baseUrl/movie/popular?api_key=$_API_KEY&language=en-US&page=1',
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body)['results'] as List;
        return data.map((json) => MovieModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load movies: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('An error occurred while fetching movies: $e');
    }
  }
}
