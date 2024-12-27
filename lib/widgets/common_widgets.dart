import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

class BackButtonPortrait extends StatelessWidget {
  const BackButtonPortrait({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint("buildin $this");
    return Row(children: [
      MoonButton.icon(
        icon: const Icon(MoonIcons.controls_chevron_left_32_regular),
        onTap: () => Navigator.pop(context),
      )
    ]);
  }
}

class BackButtonLandscape extends StatelessWidget {
  const BackButtonLandscape({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint("buildin $this");
    return Row(children: [
      MoonButton.icon(
        icon: const Icon(MoonIcons.controls_chevron_left_small_16_regular),
        onTap: () => Navigator.pop(context),
      )
    ]);
  }
}

class CommonParameters {
  static const portraitEdgeInsets = EdgeInsets.fromLTRB(15, 55, 15, 25);
  static const landscapeEdgeInsets = EdgeInsets.fromLTRB(50, 30, 50, 15);
}
