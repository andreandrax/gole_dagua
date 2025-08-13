import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:gole_dagua/congratulations_page.dart';

class Increment200Page extends StatefulWidget {
  const Increment200Page({super.key});

  @override
  State<Increment200Page> createState() => _Increment200PageState();
}


class _Increment200PageState extends State<Increment200Page> {
  int _counter = 0;
  
  final AudioPlayer _audioPlayer = AudioPlayer();

 void _incrementBy200() async {
    setState(() {
      _counter += 200;
    });
    if (_counter >= 2000) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CongratulationsPage()),
      );
      await _audioPlayer.play(AssetSource('audio/toque.mp3')); // Caminho do áudio na pasta assets
    }
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gole Dágua'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
          icon: const Icon(Icons.refresh),
          tooltip: 'Zerar',
          onPressed: _resetCounter,
        )
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.lightBlue, Colors.blueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Total bebido no dia: $_counter ml', style: const TextStyle(fontSize: 24)),
              const SizedBox(height: 20),
              SizedBox(
                width: 70,
                height: 70,
                child: ElevatedButton(
                  onPressed: _incrementBy200,
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(0),
                  ),
                  child: const Text('Golei', style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}