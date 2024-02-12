library dev_icons;

import "package:flutter/widgets.dart";

class DevIconData extends IconData {
  const DevIconData(super.codePoint)
      : super(
          fontFamily: "DevIcons",
        );
}
