// Projet:    Laboratoire_4, creation_utilisateur, projet flutter, fusion code prof + moi
// Codeurs:   Mathieu Hatin (2296939)
// Cours:     Apps multi (420-324-AH)
// Date:      16 août 2023

import 'package:flutter/material.dart';
import 'dart:math';

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

  void generateRandomNumber(int min, int max) {
    final random = Random();
    print(min + random.nextInt(max - min + 1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Création d'utilisateur",
          style: TextStyle(
              fontSize: 24, color: Color.fromARGB(255, 252, 250, 250)),
        ),
        actions: [
          IconButton(
              onPressed: () => {_onPressedIcon("Dice")},
              icon: const Icon(Icons.casino)),
          IconButton(
              onPressed: () => {_onPressedIcon("Person")},
              icon: const Icon(Icons.person)),
          IconButton(
              onPressed: () => {_onPressedIcon("Action")},
              icon: const Icon(Icons.list)),
        ],
        backgroundColor: Colors.black,
      ),
      drawer: Drawer(
          child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Nom de l\'application',
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
              leading: const Icon(Icons.settings_outlined),
              title: const Text('Paramètres'),
              onTap: () {
                _onPressedIcon("Paramètres");
                Navigator.pop(context);
              }),
        ],
      )),
      body: const Formulaire(),
    );
  }
}

class Formulaire extends StatefulWidget {
  const Formulaire({super.key});

  @override
  MonFormulaireState createState() => MonFormulaireState();
}

class MonFormulaireState extends State<Formulaire> {

 

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _motdepasseController = TextEditingController();

  bool _isOver18 = false;
  bool _acceptTerms = false;
  late Utilisateur _utilisateur;



  String? _validateEmail(String? value) {
    String test = value ?? "";
    final emailRegExp =
        RegExp(r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,7}$');
    if (!emailRegExp.hasMatch(test)) {
      return 'Veuillez entrer une adresse e-mail valide.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          decoration: const InputDecoration(labelText: 'Adresse e-mail'),
          controller: _emailController,
          keyboardType: TextInputType
              .emailAddress, // Utiliser le clavier d'adresse e-mail
          validator: _validateEmail,
        ),
        TextField(
          decoration: const InputDecoration(labelText: 'Mot de passe'),
          controller: _motdepasseController,
          obscureText: true,
        ),
        const SizedBox(height: 46.0),
        const Align(
            alignment: Alignment.centerLeft,
            child: Text('Est-ce que vous avez:')),
        RadioListTile(
            title: const Text('Plus de 18 ans'),
            value: true,
            groupValue: _isOver18,
            onChanged: (value) {
              setState(() {
                _isOver18 = value ?? false;
              });
            }),
        const SizedBox(height: 26.0),
        ListTile(
            title: const Text('Acceptez-vous les conditions d\'utilisation'),
            leading: Checkbox(
                value: _acceptTerms,
                onChanged: (value) {
                  setState(() {
                    _acceptTerms = value ?? false;
                  });
                })),
        Align(
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () {

                if (_acceptTerms) {
                  _utilisateur = Utilisateur(_emailController.text,
                      _motdepasseController.text, _isOver18, _acceptTerms);
                  print(_utilisateur);

                  final snackBar = SnackBar(
                    content: Text(_utilisateur.toString()),
                    duration:
                        const Duration(seconds: 3), // Durée d'affichage du Snackbar
                    action: SnackBarAction(
                      label: 'Close',
                      onPressed: () {
                        // Code à exécuter lorsque le bouton "Close" est pressé
                        _emailController.text = "";
                        _motdepasseController.text = "";
                        setState(() {
                          _isOver18 = false;
                          _acceptTerms = false;
                        });
                      },
                    ),
                  );

                  // Afficher le Snackbar en utilisant ScaffoldMessenger
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
              child: const Text('Créer'),
            )),
      ],
    );
  }
}

class Utilisateur {
  String courriel = "";
  String motdepasse = "";
  bool majeur = false;
  bool acceptTerms = false;

  Utilisateur(this.courriel, this.motdepasse, this.majeur, this.acceptTerms);

  @override
  String toString() {
    return "L'utilisateur $courriel avec le mot de passe $motdepasse a été créé";
  }
}
