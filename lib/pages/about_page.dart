import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guess_the_place/providers.dart';
import 'package:moon_design/moon_design.dart';

class AboutPage extends ConsumerWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final about = ref.watch(aboutTextProvider);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 55, 15, 25),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Row(
            children: [
              MoonButton.icon(
                icon: const Icon(MoonIcons.controls_chevron_left_32_regular),
                onTap: () => Navigator.pop(context),
              )
            ],
          ),
          Expanded(
              child: Markdown(
                  shrinkWrap: true,
                  data: about.when(
                      data: (aboutText) => aboutText,
                      error: (error, stackTrace) =>
                          "Error reading the about text. Go back and try again.",
                      loading: () => "Loading...")))
        ]),
      ),
    );
  }
}
