import 'package:flutter/material.dart';

class NoteModify extends StatelessWidget {
  NoteModify({this.noteID});
  final String? noteID;
  bool get isEditing => noteID != null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(!isEditing ? 'Create note' : 'Edit note'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(hintText: 'Note title'),
              ),
              SizedBox(
                height: 25,
              ),
              TextField(
                decoration: InputDecoration(hintText: 'Note content'),
              ),
              SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () {
                  if (isEditing) {
                  } else {}
                  Navigator.of(context).pop();
                },
                child: Text('Submit'),
              )
            ],
          ),
        ));
  }
}
