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
  int pageActuelle = 1;
  int pageTotale = 2;

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPopularMovies();
    scrollController.addListener(infinityScroll);
  }

  infinityScroll(){
    print("Position = ${scrollController.position.pixels}| Taille Max = ${scrollController.position.maxScrollExtent}");
    if(scrollController.position.pixels >= scrollController.position.maxScrollExtent * 0.95){
      print("J'arrive à 95% de ma liste actuelle");
      pageActuelle = pageActuelle + 1;
      setState(() {

      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cinéma"),
        actions: [
          IconButton(
              onPressed: (){
                movies = []; // réinit
                pageActuelle = 1; // réinit
                getPopularMovies();
              },
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
                  return MovieList(movies: movies, scrollController: scrollController,);
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
        return MovieList(movies: movies, scrollController: scrollController,);
      }else{
        return MovieGrid(movies: movies);
      }
    }
  }

  Future<void> getPopularMovies() async{
    setState(() {
      statusApi = StatusApi.chargement;
    });

    MovieInfo movieInfo = await MovieRepository(apiMovieService: ApiMovieService(page: pageActuelle)).getPopular();

    await Future.delayed(const Duration(seconds: 3));

    if(movieInfo.status){
      setState(() {
        statusApi = StatusApi.ok;
        movies.addAll(movieInfo.movies); // On ajoute une liste à une liste déjà existante
        pageTotale = movieInfo.pageTotale;
      });
    }else{
      setState(() {
        statusApi = StatusApi.error;
      });
    }
  }

  Future<List<Movie>> getPopularMovies2() async{
    MovieInfo movieInfo = await MovieRepository(apiMovieService: ApiMovieService(page: 1)).getPopular();

    await Future.delayed(const Duration(seconds: 3));
    if(movieInfo.status){
      movies.addAll(movieInfo.movies); // On ajoute une liste à une liste déjà existante
      pageTotale = movieInfo.pageTotale;
    }
    return movies;
  }

}

enum StatusApi {
  chargement,
  error,
  ok
}
