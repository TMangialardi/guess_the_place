import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guess_the_place/models/current_account.dart';
import 'package:guess_the_place/pages/match_page.dart';
import 'package:guess_the_place/providers.dart';
import 'package:guess_the_place/widgets/arcade_page_widgets.dart';
import 'package:moon_design/moon_design.dart';

class ArcadePage extends StatelessWidget {
  const ArcadePage({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint("Building $this");
    return OrientationBuilder(builder: (context, orientation) {
      return orientation == Orientation.portrait
          ? const ArcadePagePortrait()
          : const ArcadePageLandscape();
    });
  }
}

class ArcadePagePortrait extends ConsumerWidget {
  const ArcadePagePortrait({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint("Building $this");
    ref.listen(currentAccountProvider, (prev, next) {
      if (next.value!.accountStatus == CurrentAccountStatus.error) {
        MoonToast.show(context,
            label: Text(next.value!.accountStatusError!),
            variant: MoonToastVariant.inverted);
      } else {
        ref.read(matchProvider.notifier).newMatch();
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const MatchPage(),
        ));
      }
    });
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
                  "Enter a nickname and play without creating an account",
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                const Column(
                  children: [
                    ArcadeLoginInput(),
                    SizedBox(height: 50),
                    SizedBox(
                        width: double.infinity, child: ArcadeLoginButton()),
                  ],
                )
              ],
            )),
          ]),
        ),
      ),
    );
  }
}

class ArcadePageLandscape extends ConsumerWidget {
  const ArcadePageLandscape({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint("Building $this");
    ref.listen(currentAccountProvider, (prev, next) {
      if (next.value!.accountStatus == CurrentAccountStatus.error) {
        MoonToast.show(context,
            label: Text(next.value!.accountStatusError!),
            variant: MoonToastVariant.inverted);
      } else {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const MatchPage(),
        ));
      }
    });
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(50, 30, 50, 15),
        child: ConstrainedBox(
          constraints:
              BoxConstraints(minHeight: MediaQuery.of(context).size.height),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(children: [
                MoonButton.icon(
                  icon: const Icon(
                      MoonIcons.controls_chevron_left_small_16_regular),
                  onTap: () => Navigator.pop(context),
                )
              ]),
              Expanded(child: LayoutBuilder(builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints:
                        BoxConstraints(minHeight: constraints.maxHeight),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Enter a nickname and play without creating an account",
                          style: Theme.of(context).textTheme.headlineMedium,
                          textAlign: TextAlign.center,
                        ),
                        const Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: ArcadeLoginInput(),
                            ),
                            SizedBox(width: 50),
                            Expanded(child: ArcadeLoginButton())
                          ],
                        )
                      ],
                    ),
                  ),
                );
              })),
            ],
          ),
        ),
      ),
    );
  }
}
