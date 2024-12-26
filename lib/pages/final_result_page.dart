import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guess_the_place/providers.dart';
import 'package:guess_the_place/widgets/final_result_page_widgets.dart';

class FinalResultPage extends ConsumerWidget {
  const FinalResultPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint("Building $this");
    final totalScore = ref.watch(currentScoreProvider).toString();
    return OrientationBuilder(builder: (context, orientation) {
      return orientation == Orientation.portrait
          ? FinalResultPagePortrait(totalScore)
          : AccountPageLandscape(totalScore);
    });
  }
}

class FinalResultPagePortrait extends StatelessWidget {
  final String totalScore;

  const FinalResultPagePortrait(this.totalScore, {super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint("Building $this");
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.fromLTRB(15, 55, 15, 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Your total score is",
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  Text(
                    totalScore,
                    style: Theme.of(context).textTheme.displayLarge,
                    textAlign: TextAlign.center,
                  )
                ],
              ),
              const GoBackWidget()
            ],
          ),
        ),
      ),
    );
  }
}

class AccountPageLandscape extends StatelessWidget {
  final String totalScore;

  const AccountPageLandscape(this.totalScore, {super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint("Building $this");
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.fromLTRB(50, 30, 50, 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Your total score is",
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  Text(
                    totalScore,
                    style: Theme.of(context).textTheme.displayLarge,
                    textAlign: TextAlign.center,
                  )
                ],
              )),
              const SizedBox(width: 50),
              const Expanded(
                child: GoBackWidget(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
