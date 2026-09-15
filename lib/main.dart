import 'package:flutter/material.dart';

import 'screens/home_screen.dart';

/// Notifier global de tema, controlado desde el Dropdown en Ajustes.
final ValueNotifier<ThemeMode> themeModeNotifier =
    ValueNotifier(ThemeMode.system);

void main() {
  runApp(const BlocNotasApp());
}

class BlocNotasApp extends StatelessWidget {
  const BlocNotasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeModeNotifier,
      builder: (context, mode, _) {
        return MaterialApp(
          title: 'BlocNotas',
          debugShowCheckedModeBanner: false,
          themeMode: mode,
          theme: ThemeData(
            useMaterial3: true,
            colorSchemeSeed: Colors.indigo,
            brightness: Brightness.light,
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            colorSchemeSeed: Colors.indigo,
            brightness: Brightness.dark,
          ),
          home: const HomeScreen(),
        );
      },
    );
  }
}
