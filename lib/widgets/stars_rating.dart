import 'package:flutter/material.dart';

class StarsRating extends StatelessWidget {
  StarsRating({super.key, required this.rating});
  double rating = 0;

  @override
  Widget build(BuildContext context) {
    int totalStars = 5;
    double fullStars = rating / 2;
    int halfStars = (rating % 2).toInt();
    int emptyStars = totalStars - fullStars.toInt() - halfStars;

    return Row(
      children: List.generate(totalStars, (index) {
        if (index < fullStars) {
          // Étoile pleine
          return Icon(
            Icons.star,
            size: 30,
            color: Colors.yellow,
          );
        } else if (index == fullStars && halfStars > 0) {
          // Moitié d'étoile
          return ClipRect(
            child: Align(
              alignment: Alignment.centerLeft,
              widthFactor: 0.5,
              child: Icon(
                Icons.star,
                size: 30,
                color: Colors.yellow,
              ),
            ),
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
