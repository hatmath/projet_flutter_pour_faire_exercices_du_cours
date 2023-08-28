// Projet:    Exercice sur les assets de type images
// Codeurs:   Mathieu Hatin (2296939)
// Cours:     Apps multi (420-324-AH)
// Date:      16 août 2023

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  void _onPressedIcon(String text) {
    print("Le bouton $text a été appuyé");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Images",
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
          actions: [
            IconButton(
                onPressed: () => {_onPressedIcon("Utilisateur")},
                icon: const Icon(Icons.person)),
          ],
          backgroundColor: Colors.red,
        ),
        drawer: Drawer(
            child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.red,
                ),
                child: Text(
                  'Examen 1',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                )),
            ListTile(
                leading: const Icon(Icons.home),
                title: const Text('Accueil'),
                onTap: () {
                  _onPressedIcon("Accueil");
                  Navigator.pop(context);
                }),
            ListTile(
                leading: const Icon(Icons.cancel_presentation_outlined),
                title: const Text('Quitter'),
                onTap: () {
                  _onPressedIcon("Quitter");
                  Navigator.pop(context);
                }),
          ],
        )),
        body: const Center(
            child: Column(children: [
          Image(image: AssetImage("assets/cours1.jpeg")),
          Image(
              image: NetworkImage(
                  "https://d1n7iqsz6ob2ad.cloudfront.net/document/landing/635x200/54cf8d191beca.jpeg")),
        ])));
  }
}