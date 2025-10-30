import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movie_app/features/home/data/models/home_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  Future<void> addToFav(Movie movie) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> Movie = prefs.getStringList("fav_movie") ?? [];

    String MovieJson = jsonEncode(movie.toJson());

    if (!Movie.contains(MovieJson)) {
      Movie.add(MovieJson);
      await prefs.setStringList("fav_movie", Movie);
    }
    Fluttertoast.showToast(
        msg: "Added to Favorites Successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: const Color.fromARGB(255, 101, 27, 22),
        textColor: Colors.white,
        fontSize: 16.0);
  }

  //function to get data from sharedpref
  Future<List<Movie>> getFav() async {
    final pref = await SharedPreferences.getInstance();

    List<String> movies = pref.getStringList("fav_movie") ?? [];

    List<Movie> decodedMovies = movies.map((movieJson) {
      return Movie.fromJson(jsonDecode(movieJson));
    }).toList();

    return decodedMovies;
  }

  Future<List<Movie>> removeFromFav(Movie movie) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> Movie = prefs.getStringList("fav_movie") ?? [];

    String MovieJson = jsonEncode(movie.toJson());
    if (Movie.contains(MovieJson)) {
      Movie.remove(MovieJson);
      await prefs.setStringList("fav_movie", Movie);
    }
    Fluttertoast.showToast(
        msg: "Removed from Favorites is Successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: const Color.fromARGB(255, 101, 27, 22),
        textColor: Colors.white,
        fontSize: 16.0);
    return getFav();
  }
}
