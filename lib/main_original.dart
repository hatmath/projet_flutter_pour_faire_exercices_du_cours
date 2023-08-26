// Projet:  Laboratoire_4, creation_utilisateur, projet flutter
// Codeurs: Mathieu Hatin
// Cours : Apps multi (420-324-AH)

import 'package:flutter/material.dart';

void main() {
  runApp(Labo4());
}

class Labo4 extends StatelessWidget {
  Labo4({super.key});

  void _onDrawerItemPressed(String text) {
    print("Le 'drawer item pressed' est $text");
  }

  final TextEditingController _courrielController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _submitForm() {
    String courriel = _courrielController.text;
    String password = _passwordController.text;

    print('Courriel: $courriel');
    print('Password: $password');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Labo 4, création d'utilisateur",
        home: Scaffold(
            appBar: AppBar(
              title: const Text(
                "Application de création d'utilisateur",
                style: TextStyle(fontSize: 24, color: Colors.black),
              ),
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
                      'Labo4',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    )),
                ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text('Accueil'),
                  onTap: () => _onDrawerItemPressed('Accueil'),
                ),
                ListTile(
                  leading: const Icon(Icons.settings_outlined),
                  title: const Text('Paramètres'),
                  onTap: () => _onDrawerItemPressed('Paramètres'),
                ),
              ],
            )),
            body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextField(
                        controller: _courrielController,
                        decoration: const InputDecoration(
                          labelText: 'Courriel',
                        )),
                    const SizedBox(height: 16.0),
                    TextField(
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 46.0),
                    const MyRadioListTile(),
                    const SizedBox(height: 26.0),
                    const MyCheckboxWidget(),
                    const SizedBox(height: 26.0),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Builder(
                            builder: (contexteReturnByBuildMethod) =>
                                ElevatedButton(
                                  onPressed: () {
                                    _submitForm();
                                    final snackBar = SnackBar(
                                        content: const Text(
                                            "L'utilisateur a été créé"),
                                        action: SnackBarAction(
                                            label: 'Annuler',
                                            onPressed: () {
                                              //Some code to undo the change
                                            }));
                                    ScaffoldMessenger.of(
                                            contexteReturnByBuildMethod)
                                        .showSnackBar(snackBar);
                                  },
                                  child: const Text('Créer'),
                                ))),
                  ],
                ))));
  }
}

// MyRadioListTile

enum MyRadioListTileStatus { oui, non }

class MyRadioListTile extends StatefulWidget {
  const MyRadioListTile({super.key});

  @override
  State<MyRadioListTile> createState() => _MyRadioListTileState();
}

class _MyRadioListTileState extends State<MyRadioListTile> {
  MyRadioListTileStatus? _statusUtilisateur = MyRadioListTileStatus.oui;

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      const Align(
          alignment: Alignment.centerLeft,
          child: Text('Est-ce que vous avez:')),
      RadioListTile<MyRadioListTileStatus>(
        title: const Text(
          'plus de 18 ans',
          style: TextStyle(
            fontSize: 14,
          ),
        ),
        value: MyRadioListTileStatus.oui,
        groupValue: _statusUtilisateur,
        onChanged: (MyRadioListTileStatus? value) {
          setState(() {
            _statusUtilisateur = value;
          });
        },
      ),
      RadioListTile<MyRadioListTileStatus>(
        title: const Text(
          'moins de 18 ans',
          style: TextStyle(
            color: Color.fromARGB(255, 219, 14, 14),
            fontSize: 14,
          ),
        ),
        value: MyRadioListTileStatus.non,
        groupValue: _statusUtilisateur,
        onChanged: (MyRadioListTileStatus? value) {
          setState(() {
            _statusUtilisateur = value;
          });
        },
      )
    ]);
  }
}

// MyCheckboxWidget

class MyCheckboxWidget extends StatefulWidget {
  const MyCheckboxWidget({Key? key}) : super(key: key);
  @override
  State<MyCheckboxWidget> createState() => _MyCheckboxWidgetState();
}

class _MyCheckboxWidgetState extends State<MyCheckboxWidget> {
  bool isChecked =
      false; // This holds the state of the checkbox, we call setState and update this whenever a user taps the checkbox
  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: const Text(
            "Est-ce que vous accepter les conditions d’utilisations"),
        leading: Checkbox(
          value: isChecked,
          onChanged: (bool? value) {
            // This is where we update the state when the checkbox is tapped
            setState(() {
              isChecked = value!;
            });
          },
        ));
  }
}

// SnackBarPage: Ne sert pas mais je l'ai conserver comme exemplaire

class SnackBarPage extends StatelessWidget {
  const SnackBarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ElevatedButton(
      onPressed: () {
        final snackBar = SnackBar(
            content: const Text("L'utilisateur a été créé"),
            action: SnackBarAction(
                label: 'Annuler',
                onPressed: () {
                  //Some code to undo the change
                }));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
      child: const Text('Créer'),
    ));
  }
}