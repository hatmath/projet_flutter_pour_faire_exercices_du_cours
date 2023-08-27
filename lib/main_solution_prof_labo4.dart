// Solution du prof au laboratoire 4

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Création d\'utilisateur'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              child: Text('Nom de l\'application'),
            ),
            ListTile(
              title: const Text('Accueil'),
              onTap: () {
                print('Accueil');
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Paramètres'),
              onTap: () {
                print('Paramètres');
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: const Formulaire(),
    );
  }
}

class Formulaire extends StatefulWidget{
  const Formulaire({super.key});

   @override
  MyHomePageState createState() => MyHomePageState();

}

class MyHomePageState extends State<Formulaire>{
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _motdepasseController = TextEditingController();


  bool _isOver18 = false;
  bool _acceptTerms = false;
  late Utilisateur _utilisateur;

  String? _validateEmail(String? value) {
    String test = value ?? "";
    final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,7}$');
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
      keyboardType: TextInputType.emailAddress, // Utiliser le clavier d'adresse e-mail
      validator: _validateEmail,
      
    ),
    TextField(
      decoration: const InputDecoration(labelText: 'Mot de passe'),
      controller: _motdepasseController,
      obscureText: true,
    ),
    RadioListTile(
      title: const Text('Plus de 18 ans'),
      value: true,
      groupValue: _isOver18,
      onChanged: (value) {
        setState(() {
          _isOver18 = value ?? false;
        });
      }
    ),
    
    CheckboxListTile(
      title: const Text('Accepter les conditions d\'utilisation'),
      value: _acceptTerms,
      onChanged: (value) {
        setState(() {
          _acceptTerms = value ?? false;
        }); 
      }
    ),
    ElevatedButton(
      onPressed: () {
        if (_acceptTerms) {
          
          _utilisateur = Utilisateur(_emailController.text,_motdepasseController.text, _isOver18, _acceptTerms);
          print(_utilisateur);

          final snackBar = SnackBar(
              content: Text(_utilisateur.toString()),
              duration: const Duration(seconds: 3), // Durée d'affichage du Snackbar
              action: SnackBarAction(
                label: 'Close',
                onPressed: () {
                  // Code à exécuter lorsque le bouton "Close" est pressé
                },
              ),
            );

            // Afficher le Snackbar en utilisant ScaffoldMessenger
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      child: const Text('Créer'),
    ),
  ],
);

  }

}

class Utilisateur{
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