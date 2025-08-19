import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  final List<Map<String, String>> registros;
  const CustomDrawer({super.key, required this.registros});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.lightBlue,
            ),
            child: Text(
              'Registro das Metas atingidas',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
          ...registros.map((registro) => ListTile(
                leading: const Icon(Icons.check_circle_outline),
                title: Text('Data: ${registro['data']}'),
                subtitle: Text('Intervalo: ${registro['intervalo']}'),
              )),
          if (registros.isEmpty)
            const ListTile(
              title: Text('Nenhum registro ainda.'),
            ),
          const Divider(),
          const ListTile(
            leading: Icon(Icons.info),
            title: Text('Sobre'),
          ),
        ],
      ),
    );
  }
}