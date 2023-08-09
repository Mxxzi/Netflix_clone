import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class HomeBanner extends StatefulWidget {
  const HomeBanner({Key? key}) : super(key: key);

  @override
  State<HomeBanner> createState() => _HomeBannerState();
}

class _HomeBannerState extends State<HomeBanner> {
  @override
  initState() {
    super.initState();
    bannermovies();
  }

  List bannerresult = [];

  String img = "https://image.tmdb.org/t/p/w500/";

  bannermovies() async {
    var response;
    response = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/movie/popular?api_key=2a163e38da4c03b3e703357c3ca9a99e"));

    Map convert = json.decode(response.body);

    bannerresult = convert["results"];

    return bannerresult;
  }

  // bannermovies() async {
  //   try {
  //     var response = await http.get(Uri.parse(
  //         "https://api.themoviedb.org/3/movie/popular?api_key=2a163e38da4c03b3e703357c3ca9a99e"));

  //     if (response.statusCode == 200) {
  //       Map<String, dynamic> convert = json.decode(response.body);
  //       List bannerresult = convert["results"];
  //       return bannerresult;
  //     } else {
  //       // Handle API response errors here
  //       log("API call failed with status code: ${response.statusCode}");
  //       return [];
  //     }
  //   } catch (e) {
  //     // Handle any other errors that might occur during the HTTP request
  //     log("Error: $e");
  //     return [];
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: FutureBuilder(
                future: bannermovies(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // Show a loading indicator while waiting for data
                    return const CircularProgressIndicator();
                  } else if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData &&
                      snapshot.data.isNotEmpty) {
                    // Check if the snapshot has data and the list is not empty
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Stack(
                        children: [
                          SizedBox(
                            height: 450,
                            width: MediaQuery.of(context).size.width,
                            child: Image.network(
                              img + bannerresult[2]["poster_path"],
                              fit: BoxFit.fill,
                            ),
                          ),
                          const Positioned(
                              bottom: 80,
                              left: 50,
                              child: Row(
                                children: [
                                  Text(" Goofy "),
                                  Icon(
                                    Icons.circle,
                                    size: 5,
                                  ),
                                  Text(" Inspiring "),
                                  Icon(
                                    Icons.circle,
                                    size: 5,
                                  ),
                                  Text(" Fantasy "),
                                  Icon(
                                    Icons.circle,
                                    size: 5,
                                  ),
                                  Text(" Action "),
                                  Icon(
                                    Icons.circle,
                                    size: 5,
                                  ),
                                  Text(" Exciting "),
                                ],
                              )),
                          Positioned(
                              bottom: 1,
                              left: 70,
                              child: Row(
                                children: [
                                  const Column(
                                    children: [
                                      Icon(
                                        Icons.add,
                                        size: 30,
                                      ),
                                      Text(
                                        " My List",
                                        style: TextStyle(fontSize: 10),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 50,
                                  ),
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.white),
                                      onPressed: () {},
                                      child: const Row(
                                        children: [
                                          Icon(
                                            Icons.play_arrow,
                                            color: Colors.black,
                                          ),
                                          Text(
                                            "Play",
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ],
                                      )),
                                  const SizedBox(
                                    width: 50,
                                  ),
                                  const Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.info_outline,
                                        size: 30,
                                      ),
                                      Text(
                                        " Info",
                                        style: TextStyle(fontSize: 10),
                                      )
                                    ],
                                  ),
                                ],
                              ))
                        ],
                      ),
                    );
                  } else {
                    // Handle API response errors here
                    log("Error fetching data: ${snapshot.error}");
                    return const Text("Error fetching data");
                  }

                  // return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
