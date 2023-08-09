import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Downloads extends StatefulWidget {
  const Downloads({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _DownloadsState createState() => _DownloadsState();
}

class _DownloadsState extends State<Downloads> {
  @override
  void initState() {
    // ignore: todo
    super.initState;
    downloads();
  }

  List downloadresult = [];

  downloads() async {
    var response;
    response = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/movie/upcoming?api_key=2a163e38da4c03b3e703357c3ca9a99e"));
    Map convert = json.decode(response.body);

    downloadresult = convert["results"];

    return downloadresult;
  }

  String img = "https://image.tmdb.org/t/p/w500/";

  final angle1 = -18 * pi / 360;
  final angle2 = 18 * pi / 360;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: NestedScrollView(
        headerSliverBuilder: (context, inheritedNotifier) => [
          //////////////// - -  app bar - -////////////////////////////////////////
          SliverAppBar(
            floating: false,
            pinned: false,
            snap: false,
            backgroundColor: Colors.black,
            expandedHeight: 130,
            title: const Text(
              "Downloads",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search),
                iconSize: 30,
              ),
              Image.asset(
                "assets/images/avatar.png",
                scale: 11,
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              background: Container(),
              title: const Padding(
                padding: EdgeInsets.all(9.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.settings_outlined,
                          size: 15,
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Text(
                          "Smart Downloads",
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w300),
                        )
                      ],
                    ),
                    Icon(
                      Icons.edit_outlined,
                      size: 15,
                    )
                  ],
                ),
              ),
            ),
          ),

///////////////////// -- body --///////////////////////////////////////
        ],
        body: FutureBuilder(
          future: downloads(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              List dload = snapshot.data as List;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      /// -- avatar -- ////
                      Row(
                        children: [
                          Image.asset(
                            "assets/images/avatar.png",
                            scale: 11,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text(
                            "Mohsin",
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      ////////// - - movies - - ////
                      movieslist(dload, 1),
                      movieslist(dload, 2),
                      movieslist(dload, 3),
                      movieslist(dload, 4),
                      movieslist(dload, 5),
                      movieslist(dload, 6),
                      movieslist(dload, 7),
                      movieslist(dload, 8),

                      const Divider(
                        color: Colors.grey,
                      ),

                      const Text(
                        "Introducing Downloads for you",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text(
                        "We'll download a personalised selection of movies and shows for you, so there's always something to watch on your phone.",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w300),
                      ),

                      /// -- stack -- ///////////
                      FutureBuilder(
                        future: downloads(),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            List dload = snapshot.data as List;
                            return Stack(
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 350,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[900],
                                      shape: BoxShape.circle),
                                ),
                                Positioned(
                                    top: 75,
                                    left: 20,
                                    child: Transform.rotate(
                                      angle: angle1,
                                      child: Image.network(
                                        img + dload[3]["poster_path"],
                                        scale: 3,
                                      ),
                                    )),
                                Positioned(
                                    top: 80,
                                    left: 210,
                                    child: Transform.rotate(
                                      angle: angle2,
                                      child: Image.network(
                                        img + dload[4]["poster_path"],
                                        scale: 3,
                                      ),
                                    )),
                                Positioned(
                                    top: 40,
                                    left: 105,
                                    child: Image.network(
                                      img + dload[1]["poster_path"],
                                      scale: 2.7,
                                    )),
                              ],
                            );
                          }
                          return const SizedBox();
                        },
                      ),

                      const SizedBox(
                        height: 10,
                      ),
                      TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.blue,
                          ),
                          child: const Text(
                            "SET UP",
                            style: TextStyle(color: Colors.white),
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.black,
                          ),
                          child: const Text(
                            "Find more to download",
                            style: TextStyle(color: Colors.white),
                          )),
                    ],
                  ),
                ),
              );
            }
            return const Center(
                child: Text("LOADING . . . !",
                    style: TextStyle(
                      color: Colors.grey,
                    )));
          },
        ),
      ),
    );
  }

//////////// list movie //////////////////////////////////////////
  movieslist(List<dynamic> dload, int index) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              fit: FlexFit.loose,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 100, // Set the desired width for the image
                    height: 100,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image.network(
                        img + dload[index]["backdrop_path"],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      width: 170, // Set the desired width for the text
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          dload[index]["title"],
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 15,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }
}
