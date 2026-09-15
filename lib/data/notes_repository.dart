import 'package:flutter/foundation.dart';

import '../models/note.dart';

/// Repositorio simple en memoria (singleton) que expone un [ValueNotifier]
/// con la lista de notas. Evita dependencias externas (provider, riverpod,
/// etc.) para que el proyecto compile "out of the box".
class NotesRepository {
  NotesRepository._internal() {
    _seed();
  }

  static final NotesRepository instance = NotesRepository._internal();

  final ValueNotifier<List<Note>> notesNotifier = ValueNotifier<List<Note>>([]);

  int _nextId = 1;

  String _newId() => (_nextId++).toString();

  void _seed() {
    notesNotifier.value = [
      Note(
        id: _newId(),
        title: 'Bienvenido a BlocNotas',
        content:
            'Esta es tu primera nota. Toca el ícono de tres puntos (⋮) para editar, eliminar o compartir.',
        category: 'Personal',
        isFavorite: true,
      ),
      Note(
        id: _newId(),
        title: 'Reunión de equipo',
        content: 'Preparar el resumen del sprint antes del viernes.',
        category: 'Trabajo',
      ),
      Note(
        id: _newId(),
        title: 'Repasar Flutter',
        content:
            'Practicar Drawer, NavigationDrawer, BottomNavigationBar y los menús desplegables.',
        category: 'Estudio',
      ),
    ];
  }

  void addNote({
    required String title,
    required String content,
    required String category,
  }) {
    final list = List<Note>.from(notesNotifier.value);
    list.insert(
      0,
      Note(id: _newId(), title: title, content: content, category: category),
    );
    notesNotifier.value = list;
  }

  void updateNote(
    String id, {
    required String title,
    required String content,
    required String category,
  }) {
    final list = List<Note>.from(notesNotifier.value);
    final index = list.indexWhere((n) => n.id == id);
    if (index == -1) return;
    final old = list[index];
    list[index] = Note(
      id: old.id,
      title: title,
      content: content,
      category: category,
      isFavorite: old.isFavorite,
      createdAt: old.createdAt,
    );
    notesNotifier.value = list;
  }

  void deleteNote(String id) {
    final list = List<Note>.from(notesNotifier.value)
      ..removeWhere((n) => n.id == id);
    notesNotifier.value = list;
  }

  void toggleFavorite(String id) {
    final list = List<Note>.from(notesNotifier.value);
    final index = list.indexWhere((n) => n.id == id);
    if (index == -1) return;
    list[index].isFavorite = !list[index].isFavorite;
    notesNotifier.value = List<Note>.from(list);
  }
}
