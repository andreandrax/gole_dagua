import 'package:flutter/material.dart';
import 'congrats_page.dart';
import 'custom_drawer.dart'; // Importa a aba lateral (custom_drawer)
import 'alert_reminder.dart'; // Importa o lembrete de alerta

class Increment200Page extends StatefulWidget {
  const Increment200Page({super.key});

  @override
  State<Increment200Page> createState() => _Increment200PageState();
}


class _Increment200PageState extends State<Increment200Page> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); //controla a abertura da aba lateral
  int _counter = 0;
  int _meta = 2000; // Valor inicial da meta
  final TextEditingController _metaController = TextEditingController();
  List<Map<String, String>> _registros = []; //lista de registro onde terá data e intervalo
  DateTime? _ultimaMeta; // Para calcular o intervalo

  @override
  void initState() {
    super.initState();
    _metaController.text = _meta.toString();
    AlertReminder.startHourlyAlert(context);
  }

  void _incrementBy200() {
    setState(() {
      _counter += 200;
    });
    if (_counter >= _meta) { //condição acionada quando atingir a meta
      final agora = DateTime.now(); //adição dos resgistros na lista
    String intervalo = '';
    if (_ultimaMeta != null) {
      final diff = agora.difference(_ultimaMeta!);
      intervalo = '${diff.inHours}h ${diff.inMinutes % 60}min';
    } else {
      intervalo = '-';
    }
    _ultimaMeta = agora;
    _registros.insert(0, {
      'data': '${agora.day}/${agora.month}/${agora.year} ${agora.hour}:${agora.minute.toString().padLeft(2, '0')}',
      'intervalo': intervalo,
    });
    if (_registros.length > 7) {
      _registros = _registros.sublist(0, 7);
    }
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CongratsPage()), //chama a pág. de congrat após atingir a meta
      );
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