import 'package:flutter/material.dart';

import '../data/notes_repository.dart';
import '../models/note.dart';
import '../widgets/note_card.dart';

class FavoritesTab extends StatelessWidget {
  const FavoritesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<Note>>(
      valueListenable: NotesRepository.instance.notesNotifier,
      builder: (context, notes, _) {
        final favorites = notes.where((n) => n.isFavorite).toList();
        if (favorites.isEmpty) {
          return const Center(
            child: Text('Aún no marcas notas como favoritas ⭐'),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.only(top: 8, bottom: 24),
          itemCount: favorites.length,
          itemBuilder: (context, index) => NoteCard(note: favorites[index]),
        );
      },
    );
  }
}
