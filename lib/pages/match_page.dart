import 'package:flutter/material.dart';
import 'package:guess_the_place/widgets/common_widgets.dart';
import 'package:guess_the_place/widgets/match_page_widgets.dart';

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
    return const PopScope(
      canPop: false,
      child: Scaffold(
          body: Padding(
        padding: CommonParameters.portraitEdgeInsets,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          MatchBackButton(),
          Expanded(
            child: MapillaryWebView(),
          ),
          SizedBox(height: 20),
          Expanded(
            child: MapView(),
          ),
          SizedBox(height: 20),
          SizedBox(width: double.infinity, child: SubmitGuessButton())
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
    return const PopScope(
      canPop: false,
      child: Scaffold(
        body: Padding(
          padding: CommonParameters.landscapeEdgeInsets,
          child: Center(
            child: Column(children: [
              MatchBackButton(),
              Expanded(
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
