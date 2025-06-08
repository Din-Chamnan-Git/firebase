class MovieModel {
  final String title;
  final String posterPath;
  final String releaseDate;
  final String overview;
  final double voteAverage;

  MovieModel({
    required this.title,
    required this.posterPath,
    required this.releaseDate,
    required this.overview,
    required this.voteAverage,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      title: json['title'] ?? '',
      posterPath: json['poster_path'] ?? '',
      releaseDate: json['release_date'] ?? '',
      overview: json['overview'] ?? '',
      voteAverage: (json['vote_average'] ?? 0).toDouble(),
    );
  }
}
