import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guess_the_place/providers.dart';
import 'package:guess_the_place/widgets/common_widgets.dart';
import 'package:guess_the_place/widgets/home_page_widgets.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint("Building $this");
    final darkThemeEnabled = ref.watch(darkThemeProvider);
    return OrientationBuilder(builder: (context, orientation) {
      return orientation == Orientation.portrait
          ? HomePagePortrait(darkThemeEnabled)
          : HomePageLandscape(darkThemeEnabled);
    });
  }
}

class HomePagePortrait extends StatelessWidget {
  final bool darkThemeEnabled;

  const HomePagePortrait(this.darkThemeEnabled, {super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint("Building $this");
    return Scaffold(
      body: Padding(
        padding: CommonParameters.portraitEdgeInsets,
        child: Center(
          child: Column(children: [
            DarkModeSwitchWidget(darkThemeEnabled),
            const Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [LogoWidget(), GameModesWidget()],
            )),
            const BottomLineWidget(),
          ]),
        ),
      ),
    );
  }
}

class HomePageLandscape extends StatelessWidget {
  final bool darkThemeEnabled;

  const HomePageLandscape(this.darkThemeEnabled, {super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint("Building $this");
    return Scaffold(
      body: Padding(
        padding: CommonParameters.landscapeEdgeInsets,
        child: Center(
          child: Column(children: [
            DarkModeSwitchWidget(darkThemeEnabled),
            const Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(child: LogoWidget()),
                  SizedBox(width: 50),
                  Expanded(
                    child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(child: GameModesWidget()),
                          BottomLineWidget()
                        ]),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
