import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SideBar extends StatefulWidget {
  final Color? backgroundColor;
  final Widget child;
  final Widget body;
  const SideBar({
    super.key,
    this.backgroundColor = Colors.amber,
    required this.child,
    required this.body,
  });

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: expanded ? 300 : 0),
      color: widget.backgroundColor,
      width: expanded ? MediaQuery.of(context).size.width * .91 : 60,
      height: double.infinity,
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          //mainAxisSize: MainAxisSize.min,
          //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: expanded
              ? [
                  Container(
                    color: Colors.grey[800],
                    height: 1,
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        widget.child,
                        Container(
                          color: Colors.grey[800],
                          width: 1,
                        ),
                        widget.body,
                      ],
                    ),
                  ),
                  // const Spacer(),
                  Container(
                    color: Colors.grey[800],
                    height: 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            expanded = false;
                          });
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                        ),
                      ),
                    ],
                  ),
                  /*     Container(
                    color: Colors.grey[800],
                    height: 1,
                  ), */
                ]
              : [
                  Container(
                    color: Colors.grey[800],
                    height: 1,
                  ),
                  Expanded(child: widget.child),
                  //   const Spacer(),
                  Container(
                    color: Colors.grey[800],
                    height: 1,
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        expanded = true;
                      });
                    },
                    icon: Icon(
                      expanded
                          ? Icons.arrow_back_ios_new_rounded
                          : Icons.arrow_forward_ios_rounded,
                    ),
                  ),
                  /*     Container(
                    color: Colors.grey[800],
                    height: 1,
                  ), */
                ],
        ),
      ),
    );
  }
}
