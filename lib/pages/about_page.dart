import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guess_the_place/providers.dart';
import 'package:guess_the_place/widgets/common_widgets.dart';

class AboutPage extends ConsumerWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint("Building $this");
    final about = ref.watch(aboutTextProvider);
    return Scaffold(body: OrientationBuilder(builder: (context, orientation) {
      return Padding(
        padding: orientation == Orientation.portrait
            ? CommonParameters.portraitEdgeInsets
            : CommonParameters.landscapeEdgeInsets,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          orientation == Orientation.portrait
              ? const BackButtonPortrait()
              : const BackButtonLandscape(),
          Expanded(
              child: Markdown(
                  shrinkWrap: true,
                  data: about.when(
                      data: (aboutText) => aboutText,
                      error: (error, stackTrace) =>
                          "Error reading the about text. Go back and try again.",
                      loading: () => "Loading...")))
        ]),
      );
    }));
  }
}
