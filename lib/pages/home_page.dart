import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guess_the_place/widgets/home_page_widgets.dart';

class HomePage extends ConsumerWidget {
  final bool darkThemeEnabled;

  const HomePage({super.key, required this.darkThemeEnabled});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
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
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 55, 15, 25),
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
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(50, 40, 50, 15),
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
