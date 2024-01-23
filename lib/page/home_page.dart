import 'package:api/models/movie.dart';
import 'package:api/models/movie_info.dart';
import 'package:api/repositories/movie_repository.dart';
import 'package:api/services/api_movie_service.dart';
import 'package:api/widgets/custom_text.dart';
import 'package:api/widgets/movie_grid.dart';
import 'package:api/widgets/movie_list.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  StatusApi? statusApi;
  List<Movie> movies = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPopularMovies();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cinéma"),
        actions: [
          IconButton(
              onPressed: getPopularMovies,
              icon: Icon(Icons.refresh)
          )
        ],
      ),
      body: FutureBuilder<List<Movie>>(
        future: getPopularMovies2(),
        builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot){
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText("Chargement en cours ...",
                    fontStyle: FontStyle.italic,
                    fontSize: 30.0,
                  ),
                  CircularProgressIndicator()
                ],
              );
            default:
              if (snapshot.hasError) {
                return Center(
                  child: CustomText("Erreur lors de l'appel API",
                    color: Colors.red,
                    fontSize: 30.0,
                  ),
                );
              }else{
                if(snapshot.data == null){
                  return Center(child: Text("No Movies"),);
                }
                List<Movie> movies = snapshot.data!;
                Orientation orientation = MediaQuery.of(context).orientation;
                if(orientation == Orientation.portrait){
                  return MovieList(movies: movies);
                }else{
                  return MovieGrid(movies: movies);
                }

              }
          }
        },
      ),

    );
  }

  Widget bodynamic(){
    if(statusApi == StatusApi.chargement){
      return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText("Chargement en cours ...",
                fontStyle: FontStyle.italic,
                fontSize: 30.0,
              ),
              CircularProgressIndicator()
            ],
          )
      );
    }else if(statusApi == StatusApi.error){
      return Center(
        child: CustomText("Erreur lors de l'appel API",
          color: Colors.red,
          fontSize: 30.0,
        ),
      );
    }else{
      //Todo ListView Films
      Orientation orientation = MediaQuery.of(context).orientation;
      if(orientation == Orientation.portrait){
        return MovieList(movies: movies);
      }else{
        return MovieGrid(movies: movies);
      }
    }
  }

  Future<void> getPopularMovies() async{
    setState(() {
      statusApi = StatusApi.chargement;
    });

    MovieInfo movieInfo = await MovieRepository(apiMovieService: ApiMovieService(page: 1)).getPopular();

    await Future.delayed(const Duration(seconds: 3));

    if(movieInfo.status){
      setState(() {
        statusApi = StatusApi.ok;
        movies = movieInfo.movies;
      });
    }else{
      setState(() {
        statusApi = StatusApi.error;
      });
    }
  }

  Future<List<Movie>> getPopularMovies2() async{
    List<Movie> movies = [];
    MovieInfo movieInfo = await MovieRepository(apiMovieService: ApiMovieService(page: 1)).getPopular();

    await Future.delayed(const Duration(seconds: 3));
    if(movieInfo.status){
      movies = movieInfo.movies;
    }
    return movies;
  }

}

enum StatusApi {
  chargement,
  error,
  ok
}
