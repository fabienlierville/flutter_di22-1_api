import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiMovieService{
  final String baseURL = "https://api.themoviedb.org/3/movie";
  final String token = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmNWE4YTQ4NmZiMDY5ZmNiMTAzOTZhN2EzZTQ5Y2ViNCIsInN1YiI6IjVkMzAzZTI4Y2FhYjZkMTY0MGEwNjI5ZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.apVYXOzq2PTk-rBQ6Zj-HKNwwGWVpke9XIL0-KXq_zw";
  final String lang = "fr-FR";

  Future<Map<String,dynamic>?> getPopular() async{
    String completeURL = "${baseURL}/popular?language=${lang}&page=1";
    final response = await http.get(
      Uri.parse(completeURL),
      headers: {
        'Authorization': 'Bearer ${token}',
        'Content-Type': 'application/json', // Vous pouvez ajuster ceci en fonction de vos besoins
      },
    );
    if(response.statusCode == 200){

      return jsonDecode(response.body);
    }

    return null;

  }

}