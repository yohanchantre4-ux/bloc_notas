import 'package:flutter/material.dart';

import '../data/notes_repository.dart';
import '../models/note.dart';
import '../widgets/note_card.dart';

/// Pantalla que demuestra el NavigationDrawer moderno de Material 3,
/// usado aquí para filtrar notas por categoría.
class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  int _selectedIndex = 0;

  static const List<String> _destinations = ['Todas', ...Note.categories];

  @override
  Widget build(BuildContext context) {
    final selectedCategory = _destinations[_selectedIndex];

    return Scaffold(
      appBar: AppBar(title: const Text('Explorar por categoría')),
      // --- Navigation Drawer (Material 3) ---
      drawer: NavigationDrawer(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() => _selectedIndex = index);
          Navigator.of(context).pop();
        },
        children: const [
          Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              'Categorías',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          NavigationDrawerDestination(
            icon: Icon(Icons.all_inbox_outlined),
            selectedIcon: Icon(Icons.all_inbox),
            label: Text('Todas'),
          ),
          NavigationDrawerDestination(
            icon: Icon(Icons.work_outline),
            selectedIcon: Icon(Icons.work),
            label: Text('Trabajo'),
          ),
          NavigationDrawerDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: Text('Personal'),
          ),
          NavigationDrawerDestination(
            icon: Icon(Icons.school_outlined),
            selectedIcon: Icon(Icons.school),
            label: Text('Estudio'),
          ),
          NavigationDrawerDestination(
            icon: Icon(Icons.folder_outlined),
            selectedIcon: Icon(Icons.folder),
            label: Text('Otros'),
          ),
        ],
      ),
      body: ValueListenableBuilder<List<Note>>(
        valueListenable: NotesRepository.instance.notesNotifier,
        builder: (context, notes, _) {
          final filtered = selectedCategory == 'Todas'
              ? notes
              : notes.where((n) => n.category == selectedCategory).toList();

          if (filtered.isEmpty) {
            return Center(child: Text('No hay notas en "$selectedCategory"'));
          }
          return ListView.builder(
            padding: const EdgeInsets.only(top: 8, bottom: 24),
            itemCount: filtered.length,
            itemBuilder: (context, index) => NoteCard(note: filtered[index]),
          );
        },
      ),
    );
  }
}
