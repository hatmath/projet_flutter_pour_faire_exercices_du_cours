
// ajouter shared_preferences: ^2.0.12 dans pubspec.yaml
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SharedPreferences Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  final TextEditingController _textEditingController = TextEditingController();
  String _savedValue = '';

  @override
  void initState() {
    super.initState();
    _loadSavedValue();
  }

  void _saveValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('saved_value', _textEditingController.text);
    setState(() {
      _savedValue = _textEditingController.text;
    });
  }

  void _loadSavedValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String savedValue = prefs.getString('saved_value') ?? '';
    setState(() {
      _savedValue = savedValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SharedPreferences Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _textEditingController,
              decoration: const InputDecoration(labelText: 'Enter a value'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveValue,
              child: const Text('Save Value'),
            ),
            const SizedBox(height: 20),
            Text('Saved Value: $_savedValue'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _loadSavedValue,
              child: const Text('Load Saved Value'),
            ),
          ],
        ),
      ),
    );
  }
}
