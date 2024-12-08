import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guess_the_place/widgets/login_page_widgets.dart';
import 'package:moon_design/moon_design.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return OrientationBuilder(builder: (context, orientation) {
      return orientation == Orientation.portrait
          ? const LoginPagePortrait()
          : const LoginPagePortrait();
    });
  }
}

class LoginPagePortrait extends ConsumerWidget {
  const LoginPagePortrait({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 55, 15, 25),
        child: Center(
          child: Column(children: [
            Row(children: [
              MoonButton.icon(
                icon: const Icon(MoonIcons.controls_chevron_left_32_regular),
                onTap: () => Navigator.pop(context),
              )
            ]),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Enter your credentials to login or create an account",
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                const LoginInput()
              ],
            )),
          ]),
        ),
      ),
    );
  }
}

class LoginPageLandscape extends ConsumerWidget {
  const LoginPageLandscape({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
