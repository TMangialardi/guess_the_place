import 'package:flutter/material.dart';
import 'package:guess_the_place/widgets/match_page_widgets.dart';
import 'package:moon_design/moon_design.dart';

class MatchPage extends StatelessWidget {
  const MatchPage({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint("Building $this");
    return OrientationBuilder(builder: (context, orientation) {
      return orientation == Orientation.portrait
          ? const MatchPagePortrait()
          : const MatchPageLandscape();
    });
  }
}

class MatchPagePortrait extends StatelessWidget {
  const MatchPagePortrait({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint("Building $this");
    return PopScope(
      canPop: false,
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 55, 15, 25),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Align(
            alignment: Alignment.topLeft,
            child: MoonButton.icon(
              icon: const Icon(MoonIcons.controls_chevron_left_32_regular),
              onTap: () => Navigator.pop(context),
            ),
          ),
          const Expanded(
            child: MapillaryWebView(),
          ),
          const SizedBox(height: 20),
          const Expanded(
            child: MapView(),
          ),
          const SizedBox(height: 20),
          const SizedBox(width: double.infinity, child: SubmitGuessButton())
        ]),
      )),
    );
  }
}

class MatchPageLandscape extends StatelessWidget {
  const MatchPageLandscape({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint("Building $this");
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.fromLTRB(50, 30, 50, 15),
          child: Center(
            child: Column(children: [
              Align(
                alignment: Alignment.topLeft,
                child: MoonButton.icon(
                  icon: const Icon(MoonIcons.controls_chevron_left_32_regular),
                  onTap: () => Navigator.pop(context),
                ),
              ),
              const Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(child: MapillaryWebView()),
                    SizedBox(width: 20),
                    Expanded(
                      child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(child: MapView()),
                            SizedBox(
                              height: 20,
                            ),
                            SubmitGuessButton()
                          ]),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
