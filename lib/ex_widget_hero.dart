import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Hero Example',
      initialRoute: '/',
      routes: {
        '/': (context) => const ScreenA(),
        '/screenB': (context) => const ScreenB(),
      },
    );
  }
}

class ScreenA extends StatelessWidget {
  const ScreenA({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Screen A')),
      body: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/screenB');
        },
        child: const Hero(
          tag: 'imageTag',
          // child: Image.asset('images/sample_image.jpg'),
          child: Image(image: AssetImage("assets/cours1.jpeg"))
        ),
      ),
    );
  }
}

class ScreenB extends StatelessWidget {
  const ScreenB({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Screen B')),
      body: Center(
        child: Hero(
          tag: 'imageTag',
          child: Image.asset('assets/cours2.jpeg'),
          // child: Image(image: AssetImage("assets/cours2.jpeg"))
        ),
      ),
    );
  }
}
