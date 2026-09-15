import 'package:flutter/material.dart';

import '../data/notes_repository.dart';
import '../models/note.dart';

/// Formulario para crear o editar una nota.
/// Contiene un [DropdownButtonFormField] para elegir la categoría.
class AddEditNoteDialog extends StatefulWidget {
  const AddEditNoteDialog({super.key, this.note});

  /// Si viene una nota, el diálogo funciona en modo edición.
  final Note? note;

  @override
  State<AddEditNoteDialog> createState() => _AddEditNoteDialogState();
}

class _AddEditNoteDialogState extends State<AddEditNoteDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _contentController;
  late String _category;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note?.title ?? '');
    _contentController =
        TextEditingController(text: widget.note?.content ?? '');
    _category = widget.note?.category ?? Note.categories.first;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    if (widget.note == null) {
      NotesRepository.instance.addNote(
        title: _titleController.text.trim(),
        content: _contentController.text.trim(),
        category: _category,
      );
    } else {
      NotesRepository.instance.updateNote(
        widget.note!.id,
        title: _titleController.text.trim(),
        content: _contentController.text.trim(),
        category: _category,
      );
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.note != null;
    return AlertDialog(
      title: Text(isEditing ? 'Editar nota' : 'Nueva nota'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Título'),
                textCapitalization: TextCapitalization.sentences,
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'El título es obligatorio' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _contentController,
                decoration: const InputDecoration(labelText: 'Contenido'),
                textCapitalization: TextCapitalization.sentences,
                maxLines: 3,
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Escribe el contenido' : null,
              ),
              const SizedBox(height: 12),
              // --- Dropdown Menu: DropdownButtonFormField ---
              DropdownButtonFormField<String>(
                value: _category,
                decoration: const InputDecoration(labelText: 'Categoría'),
                items: Note.categories
                    .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                    .toList(),
                onChanged: (value) {
                  if (value != null) setState(() => _category = value);
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        FilledButton(onPressed: _save, child: const Text('Guardar')),
      ],
    );
  }
}
