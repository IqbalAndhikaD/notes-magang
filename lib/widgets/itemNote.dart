// ignore_for_file: prefer_const_constructors, file_names

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes/addnote.dart';
import 'package:notes/color.dart';
import 'package:notes/models/note.dart';

class ItemNote extends StatelessWidget {
  final Note note;
  const ItemNote({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,MaterialPageRoute(builder: (_) => addNote(note: note,)),
        );
      },
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: blued,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  DateFormat(DateFormat.ABBR_MONTH).format(note.createAt),
                  style:
                      TextStyle(color: Colors.white),
                ),
                Text(
                  DateFormat(DateFormat.DAY).format(note.createAt),
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)),
                Text(
                  note.createAt.year.toString(),
                    style: TextStyle(
                        color: Colors.white)),
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0XFFF6F6F6),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          note.title,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        DateFormat(DateFormat.HOUR_MINUTE).format(note.createAt),
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                        ),
                      )
                    ],
                  ),
                  Text(
                    note.description,
                    style:
                        TextStyle(
                          fontSize: 14, 
                          fontWeight: FontWeight.normal
                        ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
