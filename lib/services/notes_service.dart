import 'dart:convert';

import 'package:demo/model/api_response.dart';
import 'package:demo/model/note_for_listening.dart';
import 'package:http/http.dart' as http;

class NotesService {
  static const API = 'https://tq-notes-api-jkrgrdggbq-el.a.run.app';
  static const headers = {'apiKey': '6165c0e2-a784-46c3-9497-dd9ffc3c84ba'};

  Future<APIresponse<List<NoteForListening>>> getNotesList() {
    return http.get(Uri.parse(API + '/notes'), headers: headers).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final notes = <NoteForListening>[];
        for (var item in jsonData) {
          final note = NoteForListening(
              noteID: item['noteID'],
              noteTitle: item['noteTitle'],
              createDateTime: DateTime.parse(item['createDateTime']),
              lastestEditDateTime: item['lastestEditDateTime'] != null
                  ? DateTime.parse(item['lastestEditDateTime'])
                  : null);
          notes.add(note);
        }
        return APIresponse<List<NoteForListening>>(
          data: notes,
        );
      }
      return APIresponse<List<NoteForListening>>(
          error: true, errorMessage: 'An error occured');
    }).catchError((_) => APIresponse<List<NoteForListening>>(
        error: true, errorMessage: 'An error occured'));
  }
}
