import 'package:flutter/material.dart';
import 'package:mynotes/services/crud/notes_service.dart';

typedef DeleteNoteCallback = void Function(DatabaseNote note);

class NotesListView extends StatelessWidget {
  final List<DatabaseNote> notes;

  const NotesListView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

