import 'package:flutter/material.dart';

import '../data/notes_repository.dart';
import '../models/note.dart';
import 'add_edit_note_dialog.dart';

/// Acciones disponibles en el menú emergente de cada nota.
enum NoteAction { editar, eliminar, compartir, favorito }

/// Tarjeta que representa una nota en las distintas listas de la app.
/// Incluye un [PopupMenuButton] (⋮) con acciones secundarias.
class NoteCard extends StatelessWidget {
  const NoteCard({super.key, required this.note});

  final Note note;

  Color _categoryColor() {
    switch (note.category) {
      case 'Trabajo':
        return Colors.blue;
      case 'Personal':
        return Colors.teal;
      case 'Estudio':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  Future<void> _confirmDelete(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar nota'),
        content: Text('¿Seguro que deseas eliminar "${note.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancelar'),
          ),
          FilledButton.tonal(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      NotesRepository.instance.deleteNote(note.id);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Nota "${note.title}" eliminada')),
        );
      }
    }
  }

  void _share(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Compartir nota'),
        content: SelectableText('${note.title}\n\n${note.content}'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _categoryColor(),
          child: Text(
            note.category.substring(0, 1),
            style: const TextStyle(color: Colors.white),
          ),
        ),
        title: Text(note.title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(note.content, maxLines: 2, overflow: TextOverflow.ellipsis),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              tooltip: note.isFavorite ? 'Quitar de favoritos' : 'Agregar a favoritos',
              icon: Icon(
                note.isFavorite ? Icons.star : Icons.star_border,
                color: Colors.amber,
              ),
              onPressed: () => NotesRepository.instance.toggleFavorite(note.id),
            ),
            // --- Popup Menu ---
            PopupMenuButton<NoteAction>(
              icon: const Icon(Icons.more_vert),
              onSelected: (action) {
                switch (action) {
                  case NoteAction.editar:
                    showDialog(
                      context: context,
                      builder: (_) => AddEditNoteDialog(note: note),
                    );
                    break;
                  case NoteAction.eliminar:
                    _confirmDelete(context);
                    break;
                  case NoteAction.compartir:
                    _share(context);
                    break;
                  case NoteAction.favorito:
                    NotesRepository.instance.toggleFavorite(note.id);
                    break;
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: NoteAction.editar,
                  child: ListTile(leading: Icon(Icons.edit), title: Text('Editar')),
                ),
                const PopupMenuItem(
                  value: NoteAction.eliminar,
                  child: ListTile(leading: Icon(Icons.delete), title: Text('Eliminar')),
                ),
                const PopupMenuItem(
                  value: NoteAction.compartir,
                  child: ListTile(leading: Icon(Icons.share), title: Text('Compartir')),
                ),
                PopupMenuItem(
                  value: NoteAction.favorito,
                  child: ListTile(
                    leading: Icon(note.isFavorite ? Icons.star_border : Icons.star),
                    title: Text(
                      note.isFavorite ? 'Quitar de favoritos' : 'Agregar a favoritos',
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
