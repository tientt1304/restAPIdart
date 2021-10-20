import 'package:demo/model/api_response.dart';
import 'package:demo/model/note_for_listening.dart';
import 'package:demo/services/notes_service.dart';
import 'package:demo/views/note_delete.dart';
import 'package:demo/views/note_modify.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class NoteList extends StatefulWidget {
  // final service = NotesService();
  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  NotesService get service => GetIt.I<NotesService>();

  APIresponse<List<NoteForListening>>? _apiResponse;
  bool _isLoading = false;

  //List<NoteForListening> notes = [];

  @override
  void initState() {
    //notes = service.getNotesList();
    _fetchNotes();
    super.initState();
  } //will be call when opening stateful

  _fetchNotes() async {
    setState(() {
      _isLoading = true;
    });

    _apiResponse = await service.getNotesList();

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('List of notes'),
        ),
        // Icon +
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => NoteModify()));
          },
          child: Icon(Icons.add),
        ),
        body: Builder(builder: (_) {
          return _isLoading
              ? CircularProgressIndicator()
              : ListView.separated(
                  separatorBuilder: (_, __) => Divider(
                    height: 1,
                    color: Colors.green,
                  ),
                  itemBuilder: (_, index) {
                    return Dismissible(
                      key: ValueKey(_apiResponse!.data![index].noteID),
                      direction: DismissDirection.startToEnd,
                      // onDismissed: (direction) {},
                      confirmDismiss: (direction) async {
                        final result = await showDialog(
                            context: context, builder: (_) => NoteDelete());
                        print(result);
                        return result;
                      },
                      background: Container(
                        color: Colors.red,
                        child: Icon(Icons.delete, color: Colors.white),
                        alignment: Alignment.centerLeft,
                      ),
                      child: ListTile(
                        title: Text(
                          _apiResponse!.data![index].noteTitle!,
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        subtitle: Text(
                            'Last edited on ${_apiResponse!.data![index].lastestEditDateTime}'),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => NoteModify(
                                  noteID: _apiResponse!.data![index].noteID!)));
                        },
                      ),
                    );
                  },
                  itemCount: _apiResponse!.data!.length,
                );
        }));
  }
}
