
import 'package:api/models/movie.dart';

class MovieInfo{
  List<Movie> movies;
  int pageActuelle;
  int pageTotale;
  String message;
  bool status; //0 = erreur/problème, 1 = ok

  MovieInfo({
    required this.movies,
    required this.pageActuelle,
    required this.pageTotale,
    required this.message,
    required this.status,
  });




}