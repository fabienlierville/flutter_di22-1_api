import 'package:api/models/movie.dart';
import 'package:api/services/api_movie_service.dart';

class MovieRepository{

  static Future<List<Movie>?> getPopular() async{
    ApiMovieService apiMovieService = ApiMovieService();
    Map<String,dynamic>? json = await apiMovieService.getPopular();

    if(json == null){
      return null;
    }

    if(json.isEmpty){
      return null;
    }

    List<dynamic> results = json["results"]; // Json liste de films
    List<Movie> movies = [];
    results.forEach((jsonMovie) {
      movies.add(Movie.fromJson(jsonMovie));
    });
    return movies;
  }

}