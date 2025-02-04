import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guess_the_place/providers.dart';
import 'package:moon_design/moon_design.dart';

class ArcadeLoginInput extends ConsumerWidget {
  const ArcadeLoginInput({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint("Building $this");
    final TextEditingController textController =
        TextEditingController(text: ref.read(loginUsernameProvider));

    return MoonTextInput(
        textInputSize: MoonTextInputSize.xl,
        controller: textController,
        hintText: "Nickname",
        leading: const Icon(
          MoonIcons.devices_joystick_32_regular,
        ),
        trailing: GestureDetector(
          onTap: () => textController.clear(),
          child: const Icon(MoonIcons.controls_close_small_24_light),
        ),
        onChanged: (value) {
          debugPrint("Current user value: ${textController.text}");
          ref.read(loginUsernameProvider.notifier).state = textController.text;
        });
  }
}

class ArcadeLoginButton extends ConsumerWidget {
  const ArcadeLoginButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint("Building $this");
    final accountprovider = ref.read(currentAccountProvider.notifier);

    return MoonFilledButton(
        label: const Text("Play"),
        onTap: () {
          FocusScope.of(context).unfocus();
          accountprovider.arcadeLogin(ref.watch(loginUsernameProvider));
        });
  }
}

class ArcadeDescription extends StatelessWidget {
  const ArcadeDescription({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint("Building $this");
    return Text(
      "Enter a nickname and play without creating an account",
      style: Theme.of(context).textTheme.headlineMedium,
      textAlign: TextAlign.center,
    );
  }
}
