import 'package:api/models/movie.dart';
import 'package:api/models/movie_info.dart';
import 'package:api/services/api_movie_service.dart';

class MovieRepository {
  late final ApiMovieService apiMovieService;
  MovieRepository({
    required this.apiMovieService,
  });

  Future<MovieInfo> getPopular() async {
    Map<String, dynamic>? json = await apiMovieService.getPopular();

    if (json == null) {
      return MovieInfo(
          movies: [],
          message: "Le Json est nul",
          status: false,
          pageActuelle: 1,
          pageTotale: 1);
    }

    if (json.isEmpty) {
      return MovieInfo(
          movies: [],
          message: "Aucun film ne correspond à votre sélection",
          status: false,
          pageActuelle: 1,
          pageTotale: 1);
    }

    List<dynamic> results = json["results"]; // Json liste de films
    List<Movie> movies = [];
    results.forEach((jsonMovie) {
      movies.add(Movie.fromJson(jsonMovie));
    });
    movies.shuffle();
    return MovieInfo(
        movies: movies,
        pageActuelle: json["page"],
        pageTotale: json["total_pages"],
        message: "Chargement ok",
        status: true
    );
  }
}
