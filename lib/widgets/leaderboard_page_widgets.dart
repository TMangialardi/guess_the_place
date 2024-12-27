import 'package:flutter/material.dart';
import 'package:guess_the_place/models/leaderboard_data.dart';
import 'package:moon_design/moon_design.dart';

class LeaderboardText extends StatelessWidget {
  const LeaderboardText({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint("Building $this");
    return Text(
      "Top 100 players",
      style: Theme.of(context).textTheme.headlineMedium,
      textAlign: TextAlign.center,
    );
  }
}

class LeaderboardHelper {
  static List<MoonTableRow> generateTableRows(List<LeaderboardResults>? data) {
    return List.generate(data!.length, (int index) {
      switch (index) {
        case 0:
          return MoonTableRow(
            cells: [
              const Text("🥇"),
              Text(
                data[index].username!,
                style:
                    const TextStyle(color: Color.fromARGB(255, 212, 175, 55)),
              ),
              Text(data[index].personalRecord!,
                  style: const TextStyle(
                      color: Color.fromARGB(255, 212, 175, 55))),
            ],
          );
        case 1:
          return MoonTableRow(
            cells: [
              const Text("🥈"),
              Text(data[index].username!,
                  style: const TextStyle(
                      color: Color.fromARGB(255, 192, 192, 192))),
              Text(data[index].personalRecord!,
                  style: const TextStyle(
                      color: Color.fromARGB(255, 192, 192, 192))),
            ],
          );
        case 2:
          return MoonTableRow(
            cells: [
              const Text("🥉"),
              Text(data[index].username!,
                  style: const TextStyle(
                      color: Color.fromARGB(255, 205, 127, 50))),
              Text(data[index].personalRecord!,
                  style: const TextStyle(
                      color: Color.fromARGB(255, 205, 127, 50))),
            ],
          );
        default:
          return MoonTableRow(
            cells: [
              Text((index + 1).toString()),
              Text(data[index].username!),
              Text(data[index].personalRecord!),
            ],
          );
      }
    });
  }

  static MoonTableHeader generateTableHeader() {
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
