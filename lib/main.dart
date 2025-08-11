import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: Increment200Page(),
  ));
}

class Increment200Page extends StatefulWidget {
  const Increment200Page({super.key});

  @override
  State<Increment200Page> createState() => _Increment200PageState();
}

class _Increment200PageState extends State<Increment200Page> {
  int _counter = 0;

  void _incrementBy200() {
    setState(() {
      _counter += 200;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Incrementar 200')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Valor: $_counter', style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _incrementBy200,
              child: const Text('Incrementar 200'),
            ),
          ],
        ),
      ),
    );
  }
}