import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PopularMovies extends StatefulWidget {
  const PopularMovies({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _PopularMoviesState createState() => _PopularMoviesState();
}

class _PopularMoviesState extends State<PopularMovies> {
  @override
  void initState() {
    // ignore: todo
    super.initState;

    popular();
  }

  List popularresult = [];

  popular() async {
    http.Response response;
    response = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/movie/popular?api_key=129e280f3159c3b249cddb0b346d74c4"));
    Map convert = json.decode(response.body);

    popularresult = convert["results"];

    return popularresult;
  }

  String img = "https://image.tmdb.org/t/p/w500/";

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
                "Popular On Netflix",
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: popular(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: popularresult.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20)),
                            width: 120,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Image.network(
                                img + popularresult[index]["poster_path"],
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
