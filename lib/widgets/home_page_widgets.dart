import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guess_the_place/pages/about_page.dart';
import 'package:guess_the_place/pages/arcade_page.dart';
import 'package:guess_the_place/pages/login_page.dart';
import 'package:guess_the_place/providers.dart';
import 'package:moon_design/moon_design.dart';

class GameModesWidget extends StatelessWidget {
  const GameModesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint("Building $this");

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        MoonMenuItem(
          leading: const Icon(MoonIcons.generic_user_32_regular),
          content:
              const Text("Create an account or log in to save your high score"),
          label: const Text("Log in and play"),
          trailing: const Icon(MoonIcons.controls_chevron_right_small_32_light),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const LoginPage(),
            ));
          },
        ),
        MoonMenuItem(
            leading: const Icon(MoonIcons.devices_joystick_32_regular),
            content: const Text("Train your skills with unlimited matches"),
            label: const Text("Arcade mode"),
            trailing:
                const Icon(MoonIcons.controls_chevron_right_small_32_light),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const ArcadePage(),
              ));
            }),
      ],
    );
  }
}

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint("Building $this");

    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
        child: Image.asset(
          'assets/logo/guesstheplace.jpg',
          fit: BoxFit.cover,
        ),
      ),
    ]);
  }
}

class DarkModeSwitchWidget extends ConsumerWidget {
  final bool darkThemeEnabled;

  const DarkModeSwitchWidget(this.darkThemeEnabled, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint("Building $this");

    return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      MoonSwitch(
        value: darkThemeEnabled,
        inactiveTrackWidget: const Icon(MoonIcons.other_sun_16_regular),
        activeTrackWidget: const Icon(MoonIcons.other_moon_16_regular),
        onChanged: (dark) => ref.read(darkThemeProvider.notifier).state = dark,
      ),
    ]);
  }
}

class BottomLineWidget extends StatelessWidget {
  const BottomLineWidget({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint("Building $this");

    return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MoonOutlinedButton(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const AboutPage(),
                ));
              },
              label: const Text("About")),
          MoonOutlinedButton(
              onTap: () {
                debugPrint("Leaderboard pressed");
              },
              label: const Text("Leaderboard")),
        ]);
  }
}
