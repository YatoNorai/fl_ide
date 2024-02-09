import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomMagnifier extends StatelessWidget {
  const CustomMagnifier({super.key, required this.magnifierInfo});

  static const Size magnifierSize = Size(200, 200);

  // This magnifier will consume some text data and position itself
  // based on the info in the magnifier.
  final ValueNotifier<MagnifierInfo> magnifierInfo;

  @override
  Widget build(BuildContext context) {
    // Use a value listenable builder because we want to rebuild
    // every time the text selection info changes.
    // `CustomMagnifier` could also be a `StatefulWidget` and call `setState`
    // when `magnifierInfo` updates. This would be useful for more complex
    // positioning cases.
    return ValueListenableBuilder<MagnifierInfo>(
        valueListenable: magnifierInfo,
        builder: (BuildContext context, MagnifierInfo currentMagnifierInfo, _) {
          // We want to position the magnifier at the global position of the gesture.
          Offset magnifierPosition = currentMagnifierInfo.globalGesturePosition;

          // You may use the `MagnifierInfo` however you'd like:
          // In this case, we make sure the magnifier never goes out of the current line bounds.
          magnifierPosition = Offset(
            clampDouble(
              magnifierPosition.dx,
              currentMagnifierInfo.currentLineBoundaries.left,
              currentMagnifierInfo.currentLineBoundaries.right,
            ),
            clampDouble(
              magnifierPosition.dy,
              currentMagnifierInfo.currentLineBoundaries.top,
              currentMagnifierInfo.currentLineBoundaries.bottom,
            ),
          );

          // Finally, align the magnifier to the bottom center. The initial anchor is
          // the top left, so subtract bottom center alignment.
          magnifierPosition -= Alignment.center.alongSize(magnifierSize);

          print(magnifierPosition);

          return Positioned(
            left: magnifierPosition.dx,
            top: magnifierPosition.dy,
            child: RawMagnifier(
              magnificationScale: 1.5,
              // The focal point starts at the center of the magnifier.
              // We probably want to point below the magnifier, so
              // offset the focal point by half the magnifier height.
              // focalPointOffset: Offset.zero,
              //focalPointOffset: Offset(0, magnifierSize.height / 1),
              focalPointOffset: const Offset(0, 55),
              /*  :
                  Offset(50, 150), */ // Offset(0, magnifierSize.height / 2),
              // Decorate it however we'd like!
              decoration: MagnifierDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                    color: Colors.grey[700]!,
                    width: 0.5,
                  ),
                ),
              ),
              size: const Size(180, 70),
              // size: magnifierSize,
            ),
          );
        });
  }
}
