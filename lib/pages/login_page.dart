import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guess_the_place/models/current_account.dart';
import 'package:guess_the_place/pages/about_page.dart';
import 'package:guess_the_place/providers.dart';
import 'package:guess_the_place/widgets/login_page_widgets.dart';
import 'package:moon_design/moon_design.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint("Building $this");
    return OrientationBuilder(builder: (context, orientation) {
      return orientation == Orientation.portrait
          ? const LoginPagePortrait()
          : const LoginPageLandscape();
    });
  }
}

class LoginPagePortrait extends ConsumerWidget {
  const LoginPagePortrait({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint("Building $this");
    ref.listen(currentAccountProvider, (prev, next) {
      if (next.value!.accountStatus == CurrentAccountStatus.error) {
        MoonToast.show(context, label: Text(next.value!.accountStatusError!));
      } else {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const AboutPage(),
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
                  "Enter your credentials to login or create an account",
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                const Column(
                  children: [
                    LoginInput(),
                    SizedBox(height: 50),
                    Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: LoginButton()),
                          SizedBox(
                            width: 50,
                          ),
                          Expanded(child: RegisterButton())
                        ])
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

class LoginPageLandscape extends ConsumerWidget {
  const LoginPageLandscape({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint("Building $this");
    ref.listen(currentAccountProvider, (prev, next) {
      if (next.value!.accountStatus == CurrentAccountStatus.error) {
        MoonToast.show(context, label: Text(next.value!.accountStatusError!));
      } else {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const AboutPage(),
        ));
      }
    });
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(50, 35, 50, 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(children: [
              MoonButton.icon(
                icon: const Icon(
                    MoonIcons.controls_chevron_left_small_24_regular),
                onTap: () => Navigator.pop(context),
              )
            ]),
            Expanded(child: LayoutBuilder(builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Enter your credentials to login or create an account",
                        style: Theme.of(context).textTheme.headlineMedium,
                        textAlign: TextAlign.center,
                      ),
                      const Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: LoginInput(),
                          ),
                          SizedBox(width: 50),
                          Expanded(
                            child: Column(
                              children: [
                                SizedBox(
                                    width: double.infinity,
                                    child: LoginButton()),
                                SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                    width: double.infinity,
                                    child: RegisterButton())
                              ],
                            ),
                          )
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
    );
  }
}
