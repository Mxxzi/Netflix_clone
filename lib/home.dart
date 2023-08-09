import 'package:flutter/material.dart';
import 'package:netflix_clone/screens/comingsoon.dart';
import 'package:netflix_clone/screens/downloads.dart';
import 'package:netflix_clone/screens/fastlaughs.dart';
import 'package:netflix_clone/screens/games.dart';
import 'package:netflix_clone/screens/homepage.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _pages = [
    const HomePage(),
    const Games(),
    const ComingSoon(),
    const FastLaughs(),
    const Downloads()
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.grey[600],
        selectedItemColor: Colors.white,
        selectedLabelStyle: const TextStyle(
          color: Colors.white,
        ),
        currentIndex: _selectedIndex,
        onTap: (newIndex) {
          setState(() {
            _selectedIndex = newIndex;
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.games),
            label: "Games",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.view_carousel_rounded),
            label: "Up Coming",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_emotions_outlined),
            label: "Fast Laughs",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.arrow_circle_down),
            label: "Downloads",
          ),
        ],
      ),
    );
  }
}
