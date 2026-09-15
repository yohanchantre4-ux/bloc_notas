import 'package:flutter/material.dart';

import '../data/notes_repository.dart';
import '../models/note.dart';
import '../widgets/add_edit_note_dialog.dart';
import '../widgets/note_card.dart';

class NotesTab extends StatelessWidget {
  const NotesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder<List<Note>>(
        valueListenable: NotesRepository.instance.notesNotifier,
        builder: (context, notes, _) {
          if (notes.isEmpty) {
            return const Center(child: Text('No hay notas todavía'));
          }
          return ListView.builder(
            padding: const EdgeInsets.only(top: 8, bottom: 88),
            itemCount: notes.length,
            itemBuilder: (context, index) => NoteCard(note: notes[index]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Nueva nota',
        onPressed: () => showDialog(
          context: context,
          builder: (_) => const AddEditNoteDialog(),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
