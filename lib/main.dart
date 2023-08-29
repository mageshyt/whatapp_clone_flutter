import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:whatapp_clone/features/welcome/view/welcome_screen.dart';
import 'package:whatapp_clone/firebase_options.dart';
import 'package:whatapp_clone/theme/dark_theme.dart';
import 'package:whatapp_clone/theme/light_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
    
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme(),
        darkTheme: darkTheme(),
        themeMode: ThemeMode.system,
        title: 'Whatsapp me',
        home: const Welcome_screen());
  }
}
