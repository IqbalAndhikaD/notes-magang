//ignore_for_file: prefer_const_constructors, camel_case_types, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes/botnavbar.dart';
import 'package:notes/color.dart';
import 'package:notes/models/note.dart';
import 'package:notes/repository/noteRepo.dart';

class addNote extends StatefulWidget {
  final Note? note;
  const addNote({super.key, this.note});

  @override
  State<addNote> createState() => _addNoteState();
}

class _addNoteState extends State<addNote> {
  final _title = TextEditingController();
  final _description = TextEditingController();
  final _selectedDate = TextEditingController(
      text: DateFormat('yyyy-MM-dd').format(DateTime.now()));

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      _title.text = widget.note!.title;
      _description.text = widget.note!.description;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: blued,
            size: 30,
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BotNavBar(
                    index: 0,
                  ),
                ));
          },
        ),
        actions: [
          widget.note != null
              ? IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              backgroundColor: bgwhite,
                              content: const Text('Are you sure?',
                                  style: TextStyle(color: Colors.black)),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('No',
                                        style: TextStyle(color: Colors.red)),),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      _deleteFile();
                                    },
                                    child: const Text('Yes',
                                        style: TextStyle(color: Colors.green)))
                              ],
                            ));
                  },
                  icon: Icon(Icons.delete_outline,
                      color: Colors.red, size: 30))
              : SizedBox(),
          IconButton(
              onPressed: () async {
                if (widget.note == null) {
                  await _insertFile();
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BotNavBar(
                          index: 0,
                        ),
                      ));
                } else {
                  await _updateFile();
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BotNavBar(
                          index: 0,
                        ),
                      ));
                }
              },
              icon: Icon(Icons.done,
                  color: Colors.green,size: 30,)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text('Tanggal',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              GestureDetector(
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      _selectedDate.text =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                    });
                  }
                },
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: TextField(
                    enabled: false,
                    controller: _selectedDate,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'Date',
                      suffixIcon: Icon(Icons.calendar_today), 
                    ),
                  ),
                ),
              ),
              Text('Title',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              Container(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: TextField(
                  controller: _title,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    hintText: 'Title',
                  ),
                ),
              ),
              Text('Description',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              Container(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: TextField(
                  controller: _description,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    hintText: 'Description',
                  ),
                  maxLines: 10,
                ),
              ),
              widget.note == null
                  ? ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color.fromRGBO(21, 101, 192, 1)),
                      ),
                      child: Text(
                        'Save',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        if (_title.text.isEmpty) {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    content: Text('Title cannot be empty'),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text('Ok'))
                                    ],
                                  ));
                        } else {
                          _insertFile();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const BotNavBar(
                                  index: 0,
                                ),
                              ));
                        }
                      },
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  _insertFile() async {
    final note = Note(
        title: _title.text,
        description: _description.text,
        createAt: DateTime.parse(_selectedDate.text));
    await noteRepo.insert(note: note);
  }

  _updateFile() async {
    final note = Note(
        id: widget.note!.id!,
        title: _title.text,
        description: _description.text,
        createAt: widget.note!.createAt);
    await noteRepo.update(note: note);
  }

  _deleteFile() async {
    await noteRepo.delete(note: widget.note!).then((e) {
      Navigator.pop(context);
    });
  }
}
