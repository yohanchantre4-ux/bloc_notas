import 'package:flutter/material.dart';

import 'explore_screen.dart';
import 'favorites_tab.dart';
import 'notes_tab.dart';
import 'settings_tab.dart';

/// Pantalla principal de la app.
/// Combina un [Drawer] clásico (menú lateral) con un [BottomNavigationBar]
/// (navegación principal entre 3 secciones).
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static const List<String> _titles = ['Notas', 'Favoritos', 'Ajustes'];

  static const List<Widget> _tabs = [
    NotesTab(),
    FavoritesTab(),
    SettingsTab(),
  ];

  void _goToTab(int index) {
    setState(() => _selectedIndex = index);
    Navigator.of(context).pop(); // cierra el Drawer
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('BlocNotas · ${_titles[_selectedIndex]}')),
      // --- Drawer clásico (se abre con el ícono ☰) ---
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
              ),
              child: const Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'BlocNotas',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text('Inicio'),
              selected: _selectedIndex == 0,
              onTap: () => _goToTab(0),
            ),
            ListTile(
              leading: const Icon(Icons.star_outline),
              title: const Text('Favoritos'),
              selected: _selectedIndex == 1,
              onTap: () => _goToTab(1),
            ),
            ListTile(
              leading: const Icon(Icons.explore_outlined),
              title: const Text('Explorar por categoría'),
              subtitle: const Text('Navigation Drawer (Material 3)'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const ExploreScreen()),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.settings_outlined),
              title: const Text('Ajustes'),
              selected: _selectedIndex == 2,
              onTap: () => _goToTab(2),
            ),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('Acerca de'),
              onTap: () {
                Navigator.of(context).pop();
                showAboutDialog(
                  context: context,
                  applicationName: 'BlocNotas',
                  applicationVersion: '1.0.0',
                );
              },
            ),
          ],
        ),
      ),
      body: IndexedStack(index: _selectedIndex, children: _tabs),
      // --- Bottom Navigation Bar ---
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.note_outlined),
            activeIcon: Icon(Icons.note),
            label: 'Notas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star_outline),
            activeIcon: Icon(Icons.star),
            label: 'Favoritos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            activeIcon: Icon(Icons.settings),
            label: 'Ajustes',
          ),
        ],
      ),
    );
  }
}
