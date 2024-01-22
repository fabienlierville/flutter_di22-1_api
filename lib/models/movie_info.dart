
import 'package:api/models/movie.dart';

class MovieInfo{
  List<Movie> movies;
  String message;
  bool status; //0 = ok, 1 = erreur/problème

  MovieInfo({
    required this.movies,
    required this.message,
    required this.status,
  });


}