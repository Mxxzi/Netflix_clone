import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class UpcomingMovies extends StatefulWidget {
  const UpcomingMovies({Key? key}) : super(key: key);

  @override
  _UpcomingMoviesState createState() => _UpcomingMoviesState();
}

class _UpcomingMoviesState extends State<UpcomingMovies> {
  @override
  void initState() {
    // ignore: todo
    super.initState;

    upcoming();
  }

  List upcomingresult = [];

  upcoming() async {
    var response;
    response = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/movie/upcoming?api_key=2a163e38da4c03b3e703357c3ca9a99e"));
    Map convert = json.decode(response.body);

    upcomingresult = convert["results"];

    return upcomingresult;
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
                "Upcoming",
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: upcoming(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: upcomingresult.length,
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
                                img + upcomingresult[index]["poster_path"],
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
