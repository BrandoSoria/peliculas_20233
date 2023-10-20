import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas_20233/models/models.dart';
import 'package:peliculas_20233/models/now_playing_response.dart';

class MoviesProvider extends ChangeNotifier {
  String _baseUrl = 'api.themoviedb.org';
  String _apiKey = '9dc27117b000e7e5acfb365fa957971a';
  String _language = 'es-MX';
//
  List<Movie> onDisplayMovies = [];
  //p
  List<Movie> popularMovies = [];

  MoviesProvider() {
    getOnDisplayMovies();
    //p
    getPopularMovies();
  }

  getOnDisplayMovies() async {
    var url = Uri.https(_baseUrl, '3/movie/now_playing',
        {'api_key': _apiKey, 'language': _language, 'page': '1'});

    final response = await http.get(url);
    final Map<String, dynamic> decodeData = json.decode(response.body);
    //print(decodeData);
    //print(response.body);
    final nowPLayingResponse = NowPlayingResponse.fromRawJson(response.body);
    //
    onDisplayMovies = nowPLayingResponse.results;
//le comunicamos a todos los widgets que se esta escuchando que se le cambio la la dara por lo tanto tienen que redibujar
//si no se pone nada funcionara
    notifyListeners();
    // print(nowPLayingResponse.results[0].title);
  }
//p
  getPopularMovies() async {
    var url = Uri.https(_baseUrl, '3/movie/popular',
        {'api_key': _apiKey, 'language': _language, 'page': '1'});

    final response = await http.get(url);
    final popularResponse = PopularResponse.fromRawJson(response.body);
    //detructuraciom de resultado para cmvbiar y mantener las actuales

    popularMovies = [...popularMovies, ...popularResponse.results];
    notifyListeners();
  }
}
