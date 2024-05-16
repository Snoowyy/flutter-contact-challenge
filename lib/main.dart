import 'package:contacts_app/pages/auth/sing_in.dart';
import 'package:contacts_app/pages/contacts/add.dart';
import 'package:contacts_app/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App',
      initialRoute: '/',
      routes: {
        // Definir las rutas de la aplicación
        '/': (context) => const HomePage(),
        '/login': (context) => const SingInPage(),
        '/add_contact': (context) => const AddContactPage()
      },
    );
  }
}
