import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'alert_reminder.dart';
import 'congrats_page.dart';

class Increment200Page extends StatefulWidget {
  const Increment200Page({super.key});

  @override
  State<Increment200Page> createState() => _Increment200PageState();
}


class _Increment200PageState extends State<Increment200Page> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); //controla a abertura da aba lateral
  int _counter = 0;

  final AudioPlayer _audioPlayer = AudioPlayer();

 void _incrementBy200() async {
    setState(() {
      _counter += 200;
    });
    if (_counter == 2000) {
      await _audioPlayer.play(AssetSource('audio/toque.mp3')); // Caminho do áudio na pasta assets
    }
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

  @override
  void dispose() {
    _metaController.dispose();
    AlertReminder.stopHourlyAlert();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(registros: _registros), //aciona a aba lateral no layout
      appBar: AppBar(
        title: const Text('Gole Dágua'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          tooltip: 'Abrir menu',
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh), //botão zerar
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
              // Meta centralizada com campo de edição ao lado
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Meta:',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(  //configuração do box onde a meta é inserida pelo usuário
                    width: 80,
                    child: TextField(
                      controller: _metaController,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 8),
                      ),
                      onSubmitted: (value) {
                        setState(() {
                          _meta = int.tryParse(value) ?? _meta;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 5),
                  const Text(
                    'ml',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              const SizedBox(height: 60),  
              Text('Bebi: $_counter ml de água', style: const TextStyle(fontSize: 24)),
              const SizedBox(height: 20),
              SizedBox(
                width: 70,
                height: 70,
                child: ElevatedButton(    //botão Golei
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