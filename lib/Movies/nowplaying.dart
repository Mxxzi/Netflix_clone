import 'dart:convert';
import 'dart:developer';
import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
// import 'package:bordered_text/bordered_text.dart';
import 'package:http/http.dart' as http;

class NowPlayingMovies extends StatefulWidget {
  const NowPlayingMovies({Key? key}) : super(key: key);

  @override
  _NowPlayingMoviesState createState() => _NowPlayingMoviesState();
}

class _NowPlayingMoviesState extends State<NowPlayingMovies> {
  @override
  // ignore: must_call_super
  void initState() {
    // ignore: todo
    // TODO: implement initState
    nowplaying();
  }

  List nowplayingresult = [];
  String img = "https://image.tmdb.org/t/p/w500/";

  nowplaying() async {
    var response;

    response = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/movie/now_playing?api_key=2a163e38da4c03b3e703357c3ca9a99e"));

    Map convert = json.decode(response.body);

    nowplayingresult = convert["results"];
    log('result$nowplayingresult ');

    return nowplayingresult;
  }

  int count = 0;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        height: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 6, top: 6, left: 6),
              child: Text(
                "Now Playing",
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: nowplaying(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: nowplayingresult.length,
                      itemBuilder: (context, index) {
                        var count = index + 1;
                        return Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Stack(
                            children: [
                              Container(
                                color: Colors.black,
                                width: 160,
                              ),
                              Positioned(
                                left: 49,
                                child: SizedBox(
                                  width: 120,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Image.network(
                                      img +
                                          nowplayingresult[index]
                                              ["poster_path"],
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                  top: 30,
                                  child: BorderedText(
                                    strokeWidth: 4.0,
                                    strokeColor: Colors.white54,
                                    child: Text(
                                      count.toString(),
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 130),
                                    ),
                                  ))
                            ],
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
