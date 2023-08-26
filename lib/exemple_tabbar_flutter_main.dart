import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'TabBar Example',
      home: TabBarExample(),
    );
  }
}

class TabBarExample extends StatelessWidget {
  const TabBarExample({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Nombre d'onglets
      child: Scaffold(
        appBar: AppBar(
          title: const Text('TabBar Example'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Onglet 1'),
              Tab(text: 'Onglet 2'),
              Tab(text: 'Onglet 3'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Center(child: Text('Contenu de l\'onglet 1')),
            Center(child: Text('Contenu de l\'onglet 2')),
            Center(child: Text('Contenu de l\'onglet 3')),
          ],
        ),
      ),
    );
  }
}
