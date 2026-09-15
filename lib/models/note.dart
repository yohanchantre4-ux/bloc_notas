class Note {
  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.category,
    this.isFavorite = false,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  final String id;
  String title;
  String content;
  String category;
  bool isFavorite;
  final DateTime createdAt;

  /// Categorías disponibles, usadas por los distintos widgets Dropdown.
  static const List<String> categories = [
    'Trabajo',
    'Personal',
    'Estudio',
    'Otros',
  ];
}
