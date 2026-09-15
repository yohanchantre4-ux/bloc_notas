# BlocNotas

App de notas en Flutter que integra, de forma funcional (no como demos sueltas),
los 5 tipos de menú de Material Design.

## Cómo correrla

```bash
flutter pub get
flutter run
```

Requiere Flutter 3.x con Dart >= 3.0 (usa Material 3).

## Mapa de menús ↔ código

| Menú                     | Widget                                      | Dónde está en el código                                   |
|---------------------------|---------------------------------------------|-------------------------------------------------------------|
| Drawer                    | `Drawer`                                    | `lib/screens/home_screen.dart` — se abre con el ícono ☰ del AppBar |
| Navigation Drawer         | `NavigationDrawer`                          | `lib/screens/explore_screen.dart` — accesible desde el Drawer → "Explorar por categoría" |
| Bottom Navigation Bar     | `BottomNavigationBar`                       | `lib/screens/home_screen.dart` — 3 secciones: Notas, Favoritos, Ajustes |
| Popup Menu                | `PopupMenuButton`                           | `lib/widgets/note_card.dart` — ícono ⋮ en cada nota (Editar / Eliminar / Compartir / Favorito) |
| Dropdown (form)           | `DropdownButtonFormField`                   | `lib/widgets/add_edit_note_dialog.dart` — selección de categoría al crear/editar una nota |
| Dropdown (clásico)        | `DropdownButton`                            | `lib/screens/settings_tab.dart` — selector de tema (Claro/Oscuro/Sistema) |
| Dropdown (Material 3)     | `DropdownMenu`                              | `lib/screens/settings_tab.dart` — selector de idioma |

## Estructura del proyecto

```
lib/
├── main.dart                       # Entry point + control de tema
├── models/
│   └── note.dart                   # Modelo Note
├── data/
│   └── notes_repository.dart       # Estado global en memoria (ValueNotifier)
├── screens/
│   ├── home_screen.dart            # Drawer + BottomNavigationBar
│   ├── notes_tab.dart              # Lista de notas + FAB para crear
│   ├── favorites_tab.dart          # Notas marcadas como favoritas
│   ├── settings_tab.dart           # DropdownButton + DropdownMenu
│   └── explore_screen.dart         # NavigationDrawer (Material 3)
└── widgets/
    ├── note_card.dart              # Tarjeta de nota + PopupMenuButton
    └── add_edit_note_dialog.dart   # Formulario + DropdownButtonFormField
```

## Funcionalidad

- Crear, editar y eliminar notas.
- Marcar/desmarcar notas como favoritas.
- Filtrar notas por categoría desde el `NavigationDrawer`.
- Compartir (simulado con un diálogo de texto seleccionable, sin dependencias externas).
- Cambiar tema (claro/oscuro/sistema) e idioma (simulado) desde Ajustes.

No usa paquetes externos más allá de `cupertino_icons`, así que compila
directamente después de `flutter pub get`.
