import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guess_the_place/providers.dart';
import 'package:guess_the_place/widgets/account_page_widgets.dart';

class AccountPage extends ConsumerWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint("Building $this");

    var nickname = ref.read(currentAccountProvider).value!.username ?? "";
    return OrientationBuilder(builder: (context, orientation) {
      return orientation == Orientation.portrait
          ? AccountPagePortrait(nickname)
          : AccountPageLandscape(nickname);
    });
  }
}

class AccountPagePortrait extends StatelessWidget {
  final String nickname;

  const AccountPagePortrait(this.nickname, {super.key});

  @override
  Widget build(BuildContext context) {
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
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
                Text(
                  nickname,
                  style: Theme.of(context).textTheme.headlineLarge,
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

class AccountPageLandscape extends StatelessWidget {
  final String nickname;

  const AccountPageLandscape(this.nickname, {super.key});

  @override
  Widget build(BuildContext context) {
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
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
                Text(
                  nickname,
                  style: Theme.of(context).textTheme.headlineLarge,
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
