// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes/addnote.dart';
import 'package:notes/color.dart';
import 'package:notes/repository/noteRepo.dart';
import 'package:notes/widgets/itemNote.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String searchTerm = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      backgroundColor: Color(0XFFF6F6F6),
      body: Column(
        children: [
          Container(
            child: SafeArea( 
              child: Column( 
                children: [
                  //Date and Button
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                Text(
                                  DateFormat.yMMMd().format(DateTime.now()),
                                  style: TextStyle(
                                      color: const Color.fromARGB(255, 47, 47, 47),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 25),
                                  child: const Text('Today',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24)),
                                ),
                                // add button
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 190, top: 5, bottom: 5),
                                  child: Column(
                                    children: [
                                      Padding(
                                          padding: const EdgeInsets.all(0),
                                          child: SizedBox(
                                              child: TextButton(
                                                  style: TextButton.styleFrom(
                                                    backgroundColor: blued,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              const addNote(),
                                                        ));
                                                  },
                                                  child: const Row(
                                                    children: [
                                                      Icon(
                                                        Icons.add,
                                                        color: Colors.white,
                                                        size: 30,
                                                      ),
                                                      Text(
                                                        'Notes',
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      )
                                                    ],
                                                  ))))
                                    ],
                                  ),
                                ),

                                //refresh button
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 305, top: 5, bottom: 5),
                                  child: Column(
                                    children: [
                                      Padding(
                                          padding: const EdgeInsets.all(0),
                                          child: SizedBox(
                                              child: TextButton(
                                                  style: TextButton.styleFrom(
                                                    backgroundColor: blued,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                  ),
                                                  onPressed: () => setState(() {}),
                                                  child: const Row(
                                                    children: [
                                                      Icon(
                                                        Icons.refresh,
                                                        color: Colors.white,
                                                        size: 30,
                                                      ),
                                                      
                                                    ],
                                                  ))))
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          searchTerm = value;
                        });
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(Icons.search, color: blued),
                        hintText: "Search Notes", 
                        hintStyle: TextStyle(color: blued), 
                      ),
                    ),
                  )
                  
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: FutureBuilder(
                future: noteRepo.getNotes(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.data == null || snapshot.data!.isEmpty) {
                      return const Center(child: Text("Empty"));
                    }
                    return ListView(
                      padding: const EdgeInsets.all(20),
                      children: [
                        for (var note in snapshot.data!)
                          if (note.title.contains(searchTerm))
                            ItemNote(
                              note: note,
                            )
                      ],
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

