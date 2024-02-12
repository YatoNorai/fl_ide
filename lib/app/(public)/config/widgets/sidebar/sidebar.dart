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
    return Container(
      //duration: Duration(milliseconds: expanded ? 100 : 0),
      color: widget.backgroundColor,
      width: expanded ? MediaQuery.of(context).size.width * .80 : 60,
      height: double.infinity,
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          //mainAxisSize: MainAxisSize.min,
          //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              color: Colors.grey[800],
              height: 1,
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  widget.child,
                  Container(
                    color: Colors.grey[800],
                    width: expanded ? 1 : 0,
                  ),
                  expanded ? widget.body : Container(),
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
                    if (expanded == true) {
                      setState(() {
                        expanded = false;
                      });
                    } else {
                      setState(() {
                        expanded = true;
                      });
                    }
                  },
                  icon: Icon(
                    expanded
                        ? Icons.arrow_back_ios_new_rounded
                        : Icons.arrow_forward_ios_rounded,
                  ),
                ),
              ],
            ),
            /*     Container(
                    color: Colors.grey[800],
                    height: 1,
                  ), */

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
