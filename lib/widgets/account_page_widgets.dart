import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guess_the_place/pages/history_page.dart';
import 'package:guess_the_place/pages/leaderboard_page.dart';
import 'package:guess_the_place/pages/match_page.dart';
import 'package:guess_the_place/providers.dart';
import 'package:moon_design/moon_design.dart';

class OptionsWidget extends ConsumerWidget {
  const OptionsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint("Building $this");
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        MoonMenuItem(
          leading: const Icon(MoonIcons.generic_log_out_32_regular),
          content: const Text("End your game session"),
          label: const Text("Log out"),
          trailing: const Icon(MoonIcons.controls_chevron_left_small_32_light),
          onTap: () {
            ref.read(loginUsernameProvider.notifier).state = "";
            ref.read(loginPasswordProvider.notifier).state = "";
            ref.read(currentAccountProvider.notifier).logout();
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/', (route) => false);
          },
        ),
        MoonMenuItem(
            leading: const Icon(MoonIcons.media_play_32_regular),
            content:
                const Text("Play a game of 5 matches and beat the high score"),
            label: const Text("New game"),
            trailing:
                const Icon(MoonIcons.controls_chevron_right_small_32_light),
            onTap: () {
              ref.read(currentScoreProvider.notifier).state = 0;
              ref.read(remainingMatchesProvider.notifier).state = 5;
              ref.read(matchProvider.notifier).newMatch();
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const MatchPage(),
              ));
            }),
        MoonMenuItem(
            leading: const Icon(MoonIcons.text_numbers_list_32_regular),
            content: const Text("See the scores of the other players"),
            label: const Text("Leaderboard"),
            trailing:
                const Icon(MoonIcons.controls_chevron_right_small_32_light),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const LeaderboardPage(),
              ));
            }),
        MoonMenuItem(
            leading: const Icon(MoonIcons.time_time_32_regular),
            content: const Text("See the latest matches played"),
            label: const Text("History"),
            trailing:
                const Icon(MoonIcons.controls_chevron_right_small_32_light),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const HistoryPage(),
              ));
            }),
      ],
    );
  }
}

class WelcomeColumn extends StatelessWidget {
  const WelcomeColumn({super.key, required this.nickname});
  final String nickname;

  @override
  Widget build(BuildContext context) {
    debugPrint("Building $this");
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Welcome,",
          style: Theme.of(context).textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 30),
        Text(
          nickname,
          style: Theme.of(context).textTheme.displayLarge,
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
