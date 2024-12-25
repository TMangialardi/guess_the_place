import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guess_the_place/providers.dart';
import 'package:guess_the_place/widgets/account_page_widgets.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint("Building $this");

    return OrientationBuilder(builder: (context, orientation) {
      return orientation == Orientation.portrait
          ? const AccountPagePortrait()
          : const AccountPageLandscape();
    });
  }
}

class AccountPagePortrait extends ConsumerWidget {
  const AccountPagePortrait({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var nickname = ref.watch(currentAccountProvider).value!.username ?? "";
    debugPrint("Building $this");
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 55, 15, 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
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
            ),
            const OptionsWidget()
          ],
        ),
      ),
    );
  }
}

class AccountPageLandscape extends ConsumerWidget {
  const AccountPageLandscape({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var nickname = ref.watch(currentAccountProvider).value!.username ?? "";
    debugPrint("Building $this");
    return Scaffold(
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
            )),
            const SizedBox(width: 50),
            const Expanded(
              child: OptionsWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
