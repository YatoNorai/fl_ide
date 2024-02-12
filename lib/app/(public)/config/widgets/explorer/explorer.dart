import 'dart:io';

import 'package:fl_ide/app/(public)/config/widgets/dev_icons/src/dev_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_treeview/flutter_treeview.dart';

class Explorer extends StatefulWidget {
  const Explorer({super.key});

  @override
  State<Explorer> createState() => _ExplorerState();
}

class _ExplorerState extends State<Explorer> {
  final String _selectedNode = '';
  late TreeViewController _treeViewController;
  late List<Node> _nodes = [];
  bool _expanded = false;

  @override
  void initState() {
    super.initState();
    _treeViewController =
        TreeViewController(children: _nodes, selectedKey: _selectedNode);
    _updateTreeView(
        directory: Directory(
            '/data/user/0/com.example.fl_ide/files/home/FlutterProjects/yuno-main')); // call without param to load root or some default directory
  }

  @override
  Widget build(BuildContext context) {
    return TreeView(
      theme: const TreeViewTheme(
        colorScheme: ColorScheme.dark(),
        expanderTheme: ExpanderThemeData(type: ExpanderType.chevron),
      ),
      shrinkWrap: true,
      controller: _treeViewController,
      allowParentSelect: false,
      onExpansionChanged: (key, expanded) => _expandNode(key, expanded),
      onNodeTap: (key) {
        Node? node = _treeViewController.getNode(key);
        if (node != null && node.isParent) {
          _updateTreeView(node: node);
        }
      },
    );
  }

/*   void _openFilePicker() async {
    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
    if (selectedDirectory != null) {
      _updateTreeView(directory: Directory(selectedDirectory));
    }
  }
 */
  void _updateTreeView({Directory? directory, Node? node}) {
    if (directory == null && node == null) {
      setState(() {});
      return; // You should typically choose a default starting path
    }

    Directory dir = directory ?? Directory(node!.key);
    setState(() {
      _nodes = _createNode(dir);
      _treeViewController = _treeViewController.copyWith(children: _nodes);
    });
  }

  /*  List<Node> _createNode(Directory dir, {String? parentKey}) {
    List<Node> nodes = [];
    try {
      Stream<FileSystemEntity> dirContents = dir.list();
      dirContents.listen((entity) {
        bool isDir = entity is Directory;
        print(entity is File);
        String key = entity.path;
        // print(key);
        Node node = Node(
          iconColor: Colors.white,

          label: key.split(Platform.pathSeparator).last,
          key: key,
          expanded: _expanded,
          icon: isDir
              ? _expanded
                  ? Icons.folder_open
                  : Icons.folder
              : Icons.insert_drive_file,
          children: isDir
              ? _createNode(entity, parentKey: key)
              : [], // Note: Pass empty list if no children
        );
        nodes.add(node);
      });
    } catch (e) {
      // Log or handle exceptions as necessary
      // Even in the case of an exception, we return an empty list.
    }
    return nodes; // Always returns a non-nullable List<Node>
  } */

  List<Node> _createNode(Directory dir, {String? parentKey}) {
    List<Node> nodes = [];
    List<Node> directories = [];
    List<Node> files = [];

    try {
      var dirContents = dir.listSync();
      for (var entity in dirContents) {
        bool isDir = entity is Directory;
        String key = entity.path;
        String extension = entity.path.split('.').last;
        Node node = Node(
          iconColor: Colors.white,
          label: key.split(Platform.pathSeparator).last,
          key: key,
          expanded: _expanded,
          icon: isDir
              ? _expanded
                  ? Icons.folder_open
                  : Icons.folder
              : _getIconForExtension(extension),
          children: isDir ? _createNode(entity, parentKey: key) : [],
        );
        if (isDir) {
          directories.add(node);
        } else {
          files.add(node);
        }
      }

      directories.sort((a, b) => a.label.compareTo(b.label));
      files.sort((a, b) => a.label.compareTo(b.label));

      nodes.addAll(directories);
      nodes.addAll(files);
    } catch (e) {
      // Log or handle exceptions as necessary
    }
    return nodes;
  }

  IconData _getIconForExtension(String extension) {
    switch (extension) {
      case 'dart':
        return DevIcons.dartPlain;
      case 'yaml':
        return DevIcons.yamlPlain;
      case 'json':
        return DevIcons.jsonPlain;
      case 'xml':
        return DevIcons.xmlPlain;
      case 'kts':
        return DevIcons.kotlinPlain;
      case 'java':
        return DevIcons.javaPlain;
      case 'js':
        return DevIcons.javascriptPlain;
      case 'c':
        return DevIcons.cPlain;
      case 'cpp':
        return DevIcons.cplusplusPlain;
      case 'png':
        return Icons.image;
      case 'jpeg':
        return Icons.image;

      // Add more cases for other file types as needed
      default:
        return Icons.insert_drive_file;
    }
  }

  _expandNode(String key, bool expanded) {
    String msg = '${expanded ? "Expanded" : "Collapsed"}: $key';
    debugPrint(msg);
    Node? node = _treeViewController.getNode(key);
    if (node != null) {
      List<Node> updated;
      if (key == 'docs') {
        updated = _treeViewController.updateNode(
            key,
            node.copyWith(
              expanded: expanded,
              icon: expanded ? Icons.folder_open : Icons.folder,
            ));
      } else {
        updated = _treeViewController.updateNode(
            key, node.copyWith(expanded: expanded));
      }
      setState(() {
        if (key == 'docs') _expanded = expanded;
        _treeViewController = _treeViewController.copyWith(children: updated);
      });
    }
  }
}
