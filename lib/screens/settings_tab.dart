import 'package:flutter/material.dart';

import '../main.dart';

/// Pantalla de ajustes.
/// Contiene un [DropdownButton] clásico y un [DropdownMenu] (Material 3).
class SettingsTab extends StatefulWidget {
  const SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  String _themeLabel = 'Sistema';
  String _language = 'Español';

  static const Map<String, ThemeMode> _themeOptions = {
    'Claro': ThemeMode.light,
    'Oscuro': ThemeMode.dark,
    'Sistema': ThemeMode.system,
  };

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('Apariencia', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        // --- Dropdown Menu: DropdownButton clásico ---
        Row(
          children: [
            const Text('Tema:'),
            const SizedBox(width: 12),
            DropdownButton<String>(
              value: _themeLabel,
              items: _themeOptions.keys
                  .map((label) => DropdownMenuItem(value: label, child: Text(label)))
                  .toList(),
              onChanged: (value) {
                if (value == null) return;
                setState(() => _themeLabel = value);
                themeModeNotifier.value = _themeOptions[value]!;
              },
            ),
          ],
        ),
        const SizedBox(height: 24),
        Text('Idioma', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        // --- Dropdown Menu: DropdownMenu (Material 3) ---
        DropdownMenu<String>(
          initialSelection: _language,
          label: const Text('Selecciona el idioma'),
          onSelected: (value) {
            if (value == null) return;
            setState(() => _language = value);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Idioma cambiado a $value')),
            );
          },
          dropdownMenuEntries: const [
            DropdownMenuEntry(value: 'Español', label: 'Español'),
            DropdownMenuEntry(value: 'Inglés', label: 'Inglés'),
            DropdownMenuEntry(value: 'Francés', label: 'Francés'),
          ],
        ),
        const SizedBox(height: 24),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.info_outline),
          title: const Text('Acerca de BlocNotas'),
          subtitle: const Text('App de ejemplo con los principales menús de Flutter'),
          onTap: () {
            showAboutDialog(
              context: context,
              applicationName: 'BlocNotas',
              applicationVersion: '1.0.0',
              children: const [
                Text(
                  'Aplicación de ejemplo que demuestra Drawer, NavigationDrawer, '
                  'BottomNavigationBar, PopupMenuButton y menús desplegables (Dropdown).',
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
