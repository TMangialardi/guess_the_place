import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guess_the_place/models/current_account.dart';
import 'package:guess_the_place/pages/match_page.dart';
import 'package:guess_the_place/providers.dart';
import 'package:guess_the_place/widgets/arcade_page_widgets.dart';
import 'package:guess_the_place/widgets/common_widgets.dart';
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
        padding: CommonParameters.portraitEdgeInsets,
        child: Center(
          child: Column(children: [
            const BackButtonPortrait(),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const ArcadeDescription(),
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
        ref.read(matchProvider.notifier).newMatch();
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const MatchPage(),
        ));
      }
    });
    return Scaffold(
      body: Padding(
        padding: CommonParameters.landscapeEdgeInsets,
        child: ConstrainedBox(
          constraints:
              BoxConstraints(minHeight: MediaQuery.of(context).size.height),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const BackButtonLandscape(),
              Expanded(child: LayoutBuilder(builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints:
                        BoxConstraints(minHeight: constraints.maxHeight),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const ArcadeDescription(),
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
