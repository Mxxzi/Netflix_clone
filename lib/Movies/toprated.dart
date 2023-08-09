import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TopRatedMovies extends StatefulWidget {
  const TopRatedMovies({Key? key}) : super(key: key);

  @override
  _TopRatedMoviesState createState() => _TopRatedMoviesState();
}

class _TopRatedMoviesState extends State<TopRatedMovies> {
  @override
  initState() {
    super.initState();
    topratedmovies();
  }

  List topratedresult = [];

  String img = "https://image.tmdb.org/t/p/w500/";

  topratedmovies() async {
    var response;
    response = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/movie/top_rated?api_key=129e280f3159c3b249cddb0b346d74c4"));

    Map convert = json.decode(response.body);

    topratedresult = convert["results"];

    return topratedresult;
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 6, top: 6, left: 6),
              child: Text(
                "Top Rated",
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: topratedmovies(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: topratedresult.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: SizedBox(
                            width: 120,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Image.network(
                                img + topratedresult[index]["poster_path"],
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        );
                      });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
