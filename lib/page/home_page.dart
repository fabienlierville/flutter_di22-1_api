import 'package:api/models/movie.dart';
import 'package:api/models/movie_info.dart';
import 'package:api/repositories/movie_repository.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cinéma"),),
      body: Center(
        child: ElevatedButton(
          onPressed: () async{
            print("Interrogation de l'API");

            MovieInfo movieInfo = await MovieRepository.getPopular();
            if(movieInfo.status){
              movieInfo.movies.forEach((movie) {
                print(movie.title);
              });
            }else{
              print(movieInfo.message); //Traite le message d'erreur
            }
          },
          child: Text("Récupérer les films"),
        ),
      ),
    );
  }
}
