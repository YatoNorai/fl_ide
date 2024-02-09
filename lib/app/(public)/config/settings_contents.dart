import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:routefly/routefly.dart';

import '../../../themes.dart';

class SettingsContents {
  Widget generalSettings(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 40),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Text('Aparência'),
        ),
        const SizedBox(height: 20),
        TextButton(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.all(0),
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor:
                      THEMES['tomorrow-night-blue']!['root']?.backgroundColor,
                  actions: [
                    TextButton(
                      onPressed: () {
                        Routefly.pop(context);
                      },
                      child: const Text('Cancelar'),
                    ),
                  ],
                  title: const Text('Tema'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CheckboxListTile.adaptive(
                        overlayColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            // Retorna Colors.transparent para todos os estados
                            return Colors.transparent;
                          },
                        ),
                        checkboxShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        title: const Text('Android studio'),
                        value: false,
                        onChanged: (val) {
                          Routefly.pop(context);
                        },
                      ),
                      CheckboxListTile.adaptive(
                        overlayColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            // Retorna Colors.transparent para todos os estados
                            return Colors.transparent;
                          },
                        ),
                        checkboxShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        title: const Text('Dracula'),
                        value: false,
                        onChanged: (val) {
                          Routefly.pop(context);
                        },
                      ),
                      CheckboxListTile.adaptive(
                        overlayColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            // Retorna Colors.transparent para todos os estados
                            return Colors.transparent;
                          },
                        ),
                        checkboxShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        title: const Text('Tomorrow night blue'),
                        value: false,
                        onChanged: (val) {
                          Routefly.pop(context);
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          },
          child: const ListTile(
            leading: Icon(CupertinoIcons.color_filter),
            title: Text('Tema'),
            subtitle: Text('Escolha o tema para o IDE'),
          ),
        ),
      ],
    );
  }

  Widget editorSettings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 40),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Text('Editor'),
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
    );
  }

  Widget fileSettings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 40),
        TextButton(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.all(0),
          ),
          onPressed: () {},
          child: ListTile(
            leading: const Icon(Icons.insert_drive_file_outlined),
            title: const Text('Mostrar arquivos ocultos'),
            trailing: Switch(value: false, onChanged: (val) {}),
            subtitle: const Text(
                'Arquivos e pastas que começam com um ponto aparecerão'),
          ),
        ),
      ],
    );
  }
}
