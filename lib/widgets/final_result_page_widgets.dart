import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moon_design/moon_design.dart';

class GoBackWidget extends ConsumerWidget {
  const GoBackWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint("Building $this");
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        MoonMenuItem(
          leading: const Icon(MoonIcons.generic_user_32_regular),
          content: const Text("Return to your account's main menu"),
          label: const Text("Go back"),
          trailing: const Icon(MoonIcons.controls_chevron_left_small_32_light),
          onTap: () {
            Navigator.of(context).popUntil(ModalRoute.withName("/account"));
          },
        ),
      ],
    );
  }
}
