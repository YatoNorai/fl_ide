import 'package:flutter/material.dart';

import '../../themes.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: THEMES['androidstudio']!['root']?.backgroundColor,
      appBar: AppBar(
        backgroundColor: THEMES['androidstudio']!['root']?.backgroundColor,
        leading: const Center(
          child: Padding(
            padding: EdgeInsets.only(left: 0),
            child: Text(
              'Configurações',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            ),
          ),
        ),
        leadingWidth: 150,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text('Configurar'),
          ),
          const SizedBox(height: 20),
          TextButton(
            style: TextButton.styleFrom(
              padding: const EdgeInsets.all(0),
            ),
            onPressed: () {},
            child: const ListTile(
              // contentPadding: EdgeInsets.all(0),
              title: Text('Geral'),
              subtitle: Text('Configurações geral do ide'),
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
              padding: const EdgeInsets.all(0),
            ),
            onPressed: () {},
            child: const ListTile(
              title: Text('Editor'),
              subtitle: Text('Configurações do editor'),
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
              padding: const EdgeInsets.all(0),
            ),
            onPressed: () {},
            child: const ListTile(
              title: Text('Arquivo'),
              subtitle: Text('Configurações  de como os arquivos são tratados'),
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
              padding: const EdgeInsets.all(0),
            ),
            onPressed: () {},
            child: const ListTile(
              title: Text('Git'),
              subtitle: Text('Configurações do git'),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            height: 1,
            color: Colors.grey[700],
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text('Sobre'),
          ),
          TextButton(
            style: TextButton.styleFrom(
              padding: const EdgeInsets.all(0),
            ),
            onPressed: () {},
            child: const ListTile(
              leading: Icon(Icons.abc),
              title: Text('GitHub'),
              subtitle: Text('FlutterIDE é de codigo aberto!'),
            ),
          ),
        ],
      ),
    );
  }
}
