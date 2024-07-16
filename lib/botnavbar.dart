import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
//import 'package:notes/addnote.dart';
import 'package:notes/color.dart';
import 'package:notes/homepage.dart';

class BotNavBar extends StatefulWidget {
  final int index;
  const BotNavBar({super.key, required this.index});

  @override
  State<BotNavBar> createState() => _BotNavBarState();
}

class _BotNavBarState extends State<BotNavBar> {
  int _currentIndex = 0;

  final List<Widget> _navigationItem = [
    const Icon(Icons.home, size: 40, color: Colors.white,),
    //const Icon(Icons.add, size: 40, color: Colors.white,),
  ];

  final List<Widget> _screens = [
    const HomePage(), // index 0
    //const addNote(), // index 1
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        height: 60,
        backgroundColor: Colors.white,
        color: blued,
        items: _navigationItem,
        animationDuration: const Duration(microseconds: 300),
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        index: _currentIndex,
      ),
    );
  }
}




