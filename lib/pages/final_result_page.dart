import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guess_the_place/providers.dart';
import 'package:guess_the_place/widgets/common_widgets.dart';
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
          padding: CommonParameters.portraitEdgeInsets,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [ScoreColumn(score: totalScore), const GoBackWidget()],
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
          padding: CommonParameters.landscapeEdgeInsets,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(child: ScoreColumn(score: totalScore)),
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
