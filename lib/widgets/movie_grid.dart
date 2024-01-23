import 'package:api/models/movie.dart';
import 'package:api/widgets/stars_rating.dart';
import 'package:flutter/material.dart';

class MovieGrid extends StatelessWidget{

  List<Movie> movies;
  MovieGrid({Key? key, required this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;

    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
        itemCount:movies.length,
        itemBuilder: (context, i){
          Movie movie = movies[i];
          return InkWell(
            onTap: null,
            child: Card(
              elevation: 10.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(movie.title, overflow: TextOverflow.ellipsis,),
                  //Text("${movie.voteAverage.toString()} / 10"),
                  StarsRating(rating: movie.voteAverage),
                  Card(
                    elevation: 7.5,
                    child: Container(
                      height: _size.height / 5,
                      child: Image.network(movie.getImargeUrl(),fit: BoxFit.contain),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

}
