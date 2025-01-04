import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guess_the_place/providers.dart';
import 'package:guess_the_place/widgets/common_widgets.dart';
import 'package:markdown_widget/markdown_widget.dart';

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
              child: SingleChildScrollView(
            child: MarkdownBlock(
                data: about.when(
                    data: (aboutText) => aboutText,
                    error: (error, stackTrace) =>
                        "Error reading the about text. Go back and try again.",
                    loading: () => "Loading..."),
                config: MarkdownConfig(configs: [
                  LinkConfig(
                      style: TextStyle(
                    color: ref.watch(darkThemeProvider)
                        ? Color.fromARGB(255, 255, 255, 255)
                        : Color.fromARGB(255, 0, 0, 0),
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ))
                ])),
          ))
        ]),
      );
    }));
  }
}
