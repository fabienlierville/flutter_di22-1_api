import 'package:api/models/movie.dart';
import 'package:api/page/movie_details_page.dart';
import 'package:flutter/material.dart';


class MovieList extends StatelessWidget{

  List<Movie> movies;
  MovieList({Key? key, required this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;

    return ListView.builder(
        itemCount:movies.length,
        itemBuilder: (context, i){
          Movie movie = movies[i];
          return InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                return PageMovieDetails(movie: movie,);
              }));

            },
            child: Container(
              padding: EdgeInsets.all(10.0),
              child: Card(
                  elevation: 10.0,
                  // InkWell car on a besoin d'un onTap pour aller sur une autre vue
                  child: InkWell(
                    onTap: null,
                    child: Column(
                      children: <Widget>[
                        //Titre du film + date
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(width: _size.width / 2.5,child:Text(movie.title, style: TextStyle(color: Colors.blue),) ,),
                            Text(movie.releaseDate.toString(),  style: TextStyle(color: Colors.red),)
                          ],
                        ),
                        //Photo du film + résumé
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Card(
                              elevation: 7.5,
                              child: Container(width: _size.width / 2.5, height: _size.height / 4,child: Image.network(movie.getImargeUrl(),fit: BoxFit.fitWidth)),
                            ),
                            Container(width: _size.width / 2.5,height: _size.height / 4,child: Text(movie.overview,overflow: TextOverflow.clip,),)
                          ],
                        )
                      ],
                    ),
                  )
              ),
            ),
          );
        });
  }

}
