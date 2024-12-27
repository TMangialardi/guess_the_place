import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guess_the_place/providers.dart';
import 'package:guess_the_place/widgets/common_widgets.dart';
import 'package:guess_the_place/widgets/leaderboard_page_widgets.dart';
import 'package:moon_design/moon_design.dart';

class LeaderboardPage extends ConsumerWidget {
  const LeaderboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint("Building $this");
    final leaderboard = ref.watch(leaderboardProvider);
    return Scaffold(body: OrientationBuilder(builder: (context, orientation) {
      return Padding(
        padding: orientation == Orientation.portrait
            ? CommonParameters.portraitEdgeInsets
            : CommonParameters.landscapeEdgeInsets,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          orientation == Orientation.portrait
              ? const BackButtonPortrait()
              : const BackButtonLandscape(),
          const SizedBox(height: 10),
          const LeaderboardText(),
          leaderboard.when(
              skipLoadingOnRefresh: false,
              data: (data) => Expanded(
                    child: MoonTable(
                      columnsCount: 3,
                      width: orientation == Orientation.portrait
                          ? MediaQuery.of(context).size.width - 30
                          : MediaQuery.of(context).size.width - 100,
                      rowSize: MoonTableRowSize.xl,
                      rowGap: 5,
                      header: LeaderboardHelper.generateTableHeader(),
                      rows: LeaderboardHelper.generateTableRows(data),
                    ),
                  ),
              error: (error, stacktrace) => const Expanded(
                      child: Center(
                    child: Text(
                        "Uh oh! Something went wrong. Please go back and try again",
                        textAlign: TextAlign.center),
                  )),
              loading: () =>
                  const Expanded(child: Center(child: MoonCircularLoader())))
        ]),
      );
    }));
  }
}
