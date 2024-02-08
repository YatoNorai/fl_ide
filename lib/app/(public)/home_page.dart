import 'package:asp/asp.dart';
import 'package:fl_ide/app/interactor/actions/projects_action.dart';
import 'package:fl_ide/app/interactor/atoms/code_atoms.dart';
import 'package:fl_ide/routes.dart';
import 'package:flutter/material.dart';
import 'package:routefly/routefly.dart';

import '../../themes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fecthProjects();
  }

  @override
  Widget build(BuildContext context) {
    return RxBuilder(builder: (context) {
      final projects = projectsState.value;
      return Scaffold(
        backgroundColor: THEMES['androidstudio']!['root']?.backgroundColor,
        appBar: AppBar(
          backgroundColor: THEMES['androidstudio']!['root']?.backgroundColor,
          leading: const Center(
            child: Padding(
              padding: EdgeInsets.only(left: 0),
              child: Text(
                'FlutterIDE',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              ),
            ),
          ),
          leadingWidth: 130,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.settings_outlined,
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              const Text(
                'App em desenvolvimento',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 20),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border(
                      top: BorderSide(width: 1, color: Colors.grey.shade500),
                      right: BorderSide(width: 1, color: Colors.grey.shade500),
                      left: BorderSide(width: 1, color: Colors.grey.shade500),
                      bottom: BorderSide(width: 1, color: Colors.grey.shade500),
                    )),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 73, 60, 58),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Projetos',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: projects.length,
                  itemBuilder: (_, index) {
                    final project = projects[index];
                    return TextButton(
                      onLongPress: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Excluir'),
                                content: Text(
                                  "Você deseja deletar: ${project.path} [${project.title}] ",
                                  style: const TextStyle(fontSize: 12),
                                ),
                                actions: [
                                  TextButton(
                                    child: const Text("Deletar"),
                                    onPressed: () {
                                      //  print(project.path);
                                      deleteProjectsFolder(project.path);
                                      Routefly.pop(context);
                                    },
                                  ),
                                ],
                              );
                            });
                      },
                      onPressed: () {
                        print(project.path);
                      },
                      child: Row(
                        children: [
                          Container(
                              padding: const EdgeInsets.all(15),
                              // margin: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(Icons.code_off_outlined)),
                          const SizedBox(width: 10),
                          Text(projects.isEmpty
                              ? 'Voce não tem nenhum projeto existente!'
                              : project.title),
                        ],
                      ),
                    );
                  },
                ),
                /* ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: const [
                    Text(
                      '         Voce não tem nenhum projeto existente!',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ],
                ), */
              ),
            ],
          ),
        ),
        floatingActionButton: TextButton(
          style: TextButton.styleFrom(
              backgroundColor: Colors.deepPurpleAccent[400]),
          onPressed: () {
            Routefly.navigate(routePaths.code);
            /*   Navigator.push(
                  context, MaterialPageRoute(builder: (_) => const HomePage())); */
          },
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Criar um novo projeto',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              /* Icon(
                  Icons.add_outlined,
                  color: Colors.white,
                ), */
            ],
          ),
        ),
      );
    });
  }
}
