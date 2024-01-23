import 'package:flutter/material.dart';

class StarsRating extends StatelessWidget {
  StarsRating({super.key, required this.rating});
  double rating = 0;

  @override
  Widget build(BuildContext context) {
    int totalStars = 5;
    double fullStars = (rating / 2).floorToDouble();
    int halfStars = ((rating / 2 - fullStars.floor()).roundToDouble()).toInt();
    int emptyStars = totalStars - fullStars.toInt() - halfStars;
    print("rating / 2: ${rating / 2} | fullStars: $fullStars | halfStars: $halfStars");

    return Row(
      children: List.generate(totalStars, (index) {
        if (index < fullStars) {
          // Étoile pleine
          return Icon(
            Icons.star,
            size: 30,
            color: Colors.yellow,
          );
        } else if (index < fullStars + 0.5) {
          // Moitié d'étoile (dans une row celle de gauche est pleine et celle de droite juste bordure)
          return Row(
            children: [
              ClipRect(
                child: Align(
                  alignment: Alignment.centerLeft,
                  widthFactor: 0.5,
                  child: Icon(
                    Icons.star,
                    size: 30,
                    color: Colors.yellow,
                  ),
                ),
              ),
              ClipRect(
                child: Align(
                  alignment: Alignment.centerRight,
                  widthFactor: 0.5,
                  child: Icon(
                    Icons.star_border,
                    size: 30,
                    color: Colors.yellow,
                  ),
                ),
              )
            ],
          );
        } else if (index < totalStars - emptyStars) {
          // Étoile vide
          return Icon(
            Icons.star_border,
            size: 30,
            color: Colors.yellow,
          );
        } else {
          // Étoile vide
          return Icon(
            Icons.star_border,
            size: 30,
            color: Colors.yellow,
          );
        }
      }),
    );
  }




}
