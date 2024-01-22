import 'package:api/models/movie.dart';
import 'package:flutter/material.dart';

class PageMovieDetails extends StatelessWidget {
  final Movie movie;
  PageMovieDetails({required this.movie});

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("Détail du film"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(movie.title, style: TextStyle(fontSize: 30)),
              Card(
                elevation: 8,
                child: Container(
                  width: _size.width / 1.5,
                  child: Image.network(movie.getImargeUrl(), fit: BoxFit.fill,),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //Score + Date
                children: [
                  Text("${movie.voteAverage.toString()} / 10"),
                  Text(movie.releaseDate.toString(),style: TextStyle(color: Colors.red),)
                ],
              ),
              Text(movie.overview)
            ],
          ),
        ),
      ),
    );
  }
}
