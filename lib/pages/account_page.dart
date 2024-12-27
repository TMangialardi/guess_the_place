import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guess_the_place/providers.dart';
import 'package:guess_the_place/widgets/account_page_widgets.dart';
import 'package:guess_the_place/widgets/common_widgets.dart';

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
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Padding(
          padding: CommonParameters.portraitEdgeInsets,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              WelcomeColumn(nickname: nickname),
              const OptionsWidget()
            ],
          ),
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
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Padding(
          padding: CommonParameters.landscapeEdgeInsets,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(child: WelcomeColumn(nickname: nickname)),
              const SizedBox(width: 50),
              const Expanded(
                child: OptionsWidget(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
