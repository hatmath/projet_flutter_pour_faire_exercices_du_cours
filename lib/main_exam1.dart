// Projet:    Examen 1 (30%) Examen de Programmation Flutter : Création de Formulaires de base
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
          "Création d'utilisateur",
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _telephoneController = TextEditingController();

  int genreValue = 0;
  late Utilisateur _utilisateur;

  String? _validateNom(String? value) {
    String test = value ?? "";
    if (test.length < 3) {
      return 'Veuillez entrer un nom de plus de trois caractères.';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    String test = value ?? "";
    final emailRegExp =
        RegExp(r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,7}$');
    if (!emailRegExp.hasMatch(test)) {
      return 'Veuillez entrer une adresse e-mail valide.';
    }
    return null;
  }

  String? _validateTelephone(String? value) {
    String test = value ?? "";
    final emailRegExp = RegExp(r'^[0-9]{10}$');
    if (!emailRegExp.hasMatch(test)) {
      return 'Veuillez entrer une téléphone composé de 10 chiffres exactement.';
    }
    return null;
  }

  void sexe(int? e) {
    setState(() {
      if (e == 1) {
        genreValue = 1;
      } else if (e == 2) {
        genreValue = 2;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Nom'),
              style: const TextStyle(fontSize: 18),
              controller: _nomController,
              validator: _validateNom,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Courriel'),
              style: const TextStyle(fontSize: 18),
              controller: _emailController,
              keyboardType: TextInputType
                  .emailAddress, // Utiliser le clavier d'adresse e-mail
              validator: _validateEmail,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Téléphone'),
              style: const TextStyle(fontSize: 18),
              controller: _telephoneController,
              validator: _validateTelephone,
            ),
            const SizedBox(height: 36.0),
            RadioListTile(
                title: const Text('Masculin'),
                activeColor: Colors.blue,
                value: 1,
                groupValue: genreValue,
                onChanged: (e) => sexe(e)),
            RadioListTile(
                title: const Text('Féminin'),
                activeColor: Colors.green,
                value: 2,
                groupValue: genreValue,
                onChanged: (e) => sexe(e)),
            const SizedBox(height: 26.0),
            Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                    if (!_formKey.currentState!.validate()) {
                      return;
                    }

                    if (genreValue != 0) {
                      String strGenre =
                          genreValue == 1 ? "masculin" : "féminin";

                      _utilisateur = Utilisateur(
                          _nomController.text,
                          _emailController.text,
                          _telephoneController.text,
                          strGenre);
                      print(_utilisateur);

                      final snackBar = SnackBar(
                        content: Text(_utilisateur.toString()),
                        duration: const Duration(
                            seconds: 5), // Durée d'affichage du Snackbar
                        action: SnackBarAction(
                          label: 'Effacer le formulaire',
                          onPressed: () {
                            // Code à exécuter lorsque le bouton "Close" est pressé
                            _nomController.text = "";
                            _emailController.text = "";
                            _telephoneController.text = "";
                            setState(() {
                              genreValue = 0;
                            });
                          },
                        ),
                      );

                      // Afficher le Snackbar en utilisant ScaffoldMessenger
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  child: const Text('Enregistrer'),
                )),
          ],
        ));
  }
}

class Utilisateur {
  String nom = "";
  String courriel = "";
  String telephone = "";
  String genre = "";

  Utilisateur(this.nom, this.courriel, this.telephone, this.genre);

  @override
  String toString() {
    return "L'utilisateur du nom de $nom avec le courriel $courriel et le numéro de téléphone $telephone et de sexe $genre a été enregistré";
  }
}
