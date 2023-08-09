import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ComingSoon extends StatefulWidget {
  const ComingSoon({Key? key}) : super(key: key);

  @override
  State<ComingSoon> createState() => _ComingSoonState();
}

class _ComingSoonState extends State<ComingSoon> {
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
        "https://api.themoviedb.org/3/movie/upcoming?api_key=2a163e38da4c03b3e703357c3ca9a99e"));

    Map convert = json.decode(response.body);

    topratedresult = convert["results"];

    return topratedresult;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
///////////////////////---- app bar -----///////////////////////////////////////
          SliverAppBar(
            floating: false,
            pinned: false,
            snap: false,
            backgroundColor: Colors.black,
            expandedHeight: 130,
            title: const Text(
              "Coming soon",
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
                          Icons.notifications_none,
                          size: 15,
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Text(
                          "Notifications",
                          style: TextStyle(fontSize: 12),
                        )
                      ],
                    ),
                    Icon(
                      Icons.arrow_forward_ios_sharp,
                      size: 15,
                    )
                  ],
                ),
              ),
            ),
          ),

/////////////////////////--- movies --- ////////////////////////////////////////
          SliverToBoxAdapter(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: FutureBuilder(
                      future: topratedmovies(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        return ListView.builder(
                            shrinkWrap: true,
                            // scrollDirection: Axis.vertical,
                            itemCount: topratedresult.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  children: [
                                    /// - -  stack - - ///
                                    Stack(
                                      children: [
                                        SizedBox(
                                          height: 200,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Image.network(
                                              img +
                                                  topratedresult[index]
                                                      ["backdrop_path"],
                                              fit: BoxFit.fill),
                                        ),
                                        Positioned(
                                          top: 12,
                                          left: 5,
                                          child: Image.asset(
                                            "assets/images/netflix.png",
                                            scale: 6.0,
                                          ),
                                        ),
                                        Positioned(
                                            top: 75,
                                            left: 165,
                                            child: IconButton(
                                                onPressed: () {},
                                                icon: const Icon(
                                                  Icons
                                                      .play_circle_filled_sharp,
                                                  size: 50,
                                                  color: Colors.white54,
                                                ))),
                                        // Positioned(child: GestureDetector()
                                        // )
                                      ],
                                    ),

                                    /// - - N film -- remind me -- info - - ///
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Image.asset(
                                                      "assets/images/netflix.png",
                                                      scale: 18.0,
                                                    ),
                                                    const Text(
                                                      " FILM",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          letterSpacing: 2),
                                                    )
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                Row(
                                                  children: [
                                                    const Text("Coming on"),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(topratedresult[index]
                                                        ["release_date"])
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          const Row(
                                            children: [
                                              Column(
                                                children: [
                                                  Icon(
                                                    Icons
                                                        .notifications_none_outlined,
                                                    size: 20,
                                                  ),
                                                  SizedBox(
                                                    height: 8,
                                                  ),
                                                  Text(
                                                    "Remind Me",
                                                    style:
                                                        TextStyle(fontSize: 12),
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                width: 15,
                                              ),
                                              Column(
                                                children: [
                                                  Icon(
                                                    Icons.info_outline,
                                                    size: 20,
                                                  ),
                                                  SizedBox(
                                                    height: 8,
                                                  ),
                                                  Text(
                                                    "Info",
                                                    style:
                                                        TextStyle(fontSize: 12),
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                width: 15,
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),

                                    /// - - title - - ///
                                    Row(
                                      children: [
                                        const SizedBox(width: 8),
                                        Text(
                                          topratedresult[index]
                                              ["original_title"],
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),

                                    /// - - overview -- ///
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        child: Text(
                                          topratedresult[index]["overview"],
                                        ),
                                      ),
                                    )
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
          )
        ],
      ),
    );
  }
}
