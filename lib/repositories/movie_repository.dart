import 'package:api/models/movie.dart';
import 'package:api/models/movie_info.dart';
import 'package:api/services/api_movie_service.dart';

class MovieRepository{

  static Future<MovieInfo> getPopular() async{
    ApiMovieService apiMovieService = ApiMovieService();
    Map<String,dynamic>? json = await apiMovieService.getPopular();

    if(json == null){
      return MovieInfo(movies: [], message: "Le Json est nul", status: false);
    }

    if(json.isEmpty){
      return MovieInfo(movies: [], message: "Aucun film ne correspond à votre sélection", status: false);
    }

    List<dynamic> results = json["results"]; // Json liste de films
    List<Movie> movies = [];
    results.forEach((jsonMovie) {
      movies.add(Movie.fromJson(jsonMovie));
    });
    return MovieInfo(movies: movies, message: "Chargement ok", status: true);
  }

}