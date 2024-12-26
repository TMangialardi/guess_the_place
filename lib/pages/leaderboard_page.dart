import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guess_the_place/models/leaderboard_data.dart';
import 'package:guess_the_place/providers.dart';
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
            ? const EdgeInsets.fromLTRB(15, 55, 15, 25)
            : const EdgeInsets.fromLTRB(50, 30, 50, 15),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Row(
            children: [
              MoonButton.icon(
                icon: Icon(orientation == Orientation.portrait
                    ? MoonIcons.controls_chevron_left_32_regular
                    : MoonIcons.controls_chevron_left_small_16_regular),
                onTap: () => Navigator.pop(context),
              )
            ],
          ),
          const SizedBox(height: 10),
          Text(
            "Top 100 players",
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
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
                      header: _generateTableHeader(),
                      rows: _generateTableRows(data),
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

  List<MoonTableRow> _generateTableRows(List<LeaderboardResults>? data) {
    return List.generate(data!.length, (int index) {
      if (index == 0) {
        return MoonTableRow(
          cells: [
            const Text("🥇"),
            Text(
              data[index].username!,
              style: const TextStyle(color: Color.fromARGB(255, 212, 175, 55)),
            ),
            Text(data[index].personalRecord!,
                style:
                    const TextStyle(color: Color.fromARGB(255, 212, 175, 55))),
          ],
        );
      }
      if (index == 1) {
        return MoonTableRow(
          cells: [
            const Text("🥈"),
            Text(data[index].username!,
                style:
                    const TextStyle(color: Color.fromARGB(255, 192, 192, 192))),
            Text(data[index].personalRecord!,
                style:
                    const TextStyle(color: Color.fromARGB(255, 192, 192, 192))),
          ],
        );
      }
      if (index == 2) {
        return MoonTableRow(
          cells: [
            const Text("🥉"),
            Text(data[index].username!,
                style:
                    const TextStyle(color: Color.fromARGB(255, 205, 127, 50))),
            Text(data[index].personalRecord!,
                style:
                    const TextStyle(color: Color.fromARGB(255, 205, 127, 50))),
          ],
        );
      }
      return MoonTableRow(
        cells: [
          Text((index + 1).toString()),
          Text(data[index].username!),
          Text(data[index].personalRecord!),
        ],
      );
    });
  }

  MoonTableHeader _generateTableHeader() {
    final List<String> columnNames = ['Position', 'Nickname', 'Highscore'];
    return MoonTableHeader(
      columns: List.generate(
        3,
        (int index) => MoonTableColumn(
          showSortingIcon: false,
          cell: Text(columnNames[index]),
        ),
      ),
    );
  }
}
