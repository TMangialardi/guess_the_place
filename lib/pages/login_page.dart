import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guess_the_place/models/current_account.dart';
import 'package:guess_the_place/pages/account_page.dart';
import 'package:guess_the_place/providers.dart';
import 'package:guess_the_place/widgets/common_widgets.dart';
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
        MoonToast.show(context,
            label: Text(next.value!.accountStatusError!),
            variant: MoonToastVariant.inverted);
      } else {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const AccountPage(),
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
                child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const LoginText(),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.2),
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
                ),
              ),
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
        MoonToast.show(context,
            label: Text(next.value!.accountStatusError!),
            variant: MoonToastVariant.inverted);
      } else {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const AccountPage(),
        ));
      }
    });
    return Scaffold(
      body: Padding(
        padding: CommonParameters.landscapeEdgeInsets,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const BackButtonLandscape(),
            Expanded(child: LayoutBuilder(builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const LoginText(),
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
