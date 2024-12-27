import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guess_the_place/pages/final_result_page.dart';
import 'package:guess_the_place/providers.dart';
import 'package:guess_the_place/widgets/common_widgets.dart';
import 'package:moon_design/moon_design.dart';

class SubmitGuessButton extends ConsumerWidget {
  const SubmitGuessButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint("Building $this");
    Future<void> modalBuilder(BuildContext context) {
      final scoredPoints = ref.watch(latestResultProvider);
      return showMoonModal<void>(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return PopScope(
            canPop: false,
            child: OrientationBuilder(builder: (context, orientation) {
              return MoonModal(
                child: SizedBox(
                  height: orientation == Orientation.portrait
                      ? MediaQuery.of(context).size.height - 500
                      : MediaQuery.of(context).size.height - 100,
                  width: orientation == Orientation.portrait
                      ? MediaQuery.of(context).size.width - 100
                      : MediaQuery.of(context).size.width - 500,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("you scored"),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            scoredPoints.toString(),
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          const SizedBox(height: 10),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: ClipRRect(
                                  clipBehavior: Clip.antiAlias,
                                  borderRadius: BorderRadius.circular(20.0),
                                  child: CommonMapWidget(
                                    center: ref.read(pickedCoordinatesProvider),
                                    markers: CommonMapWidget.markerMaker(
                                        guess:
                                            ref.read(pickedCoordinatesProvider),
                                        actual: ref
                                            .read(matchProvider)
                                            .value!
                                            .coordinates),
                                    polyline: CommonMapWidget.polylineMaker(
                                        guess:
                                            ref.read(pickedCoordinatesProvider),
                                        actual: ref
                                            .read(matchProvider)
                                            .value!
                                            .coordinates),
                                  )),
                            ),
                          ),
                          const SizedBox(height: 10),
                          _ResultModalContinueButton()
                        ]),
                  ),
                ),
              );
            }),
          );
        },
      );
    }

    return Builder(
      builder: (BuildContext context) {
        return MoonFilledButton(
          label: const Text("Submit guess"),
          onTap: () {
            var arcadeName = ref.watch(currentAccountProvider).value!.username!;
            if (ref.watch(matchProvider).value == null ||
                ref.watch(matchProvider).isLoading) {
              MoonToast.show(context,
                  variant: MoonToastVariant.inverted,
                  label: const Text('You must see a place before guessing!'));
            } else {
              ref
                  .read(matchProvider.notifier)
                  .saveMatch(arcadeName: arcadeName);
              modalBuilder(context);
            }
          },
        );
      },
    );
  }
}

class _ResultModalContinueButton extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentAccount = ref.watch(currentAccountProvider);
    return MoonOutlinedButton(
      onTap: () {
        if (currentAccount.value!.guidAccount != null &&
            ref.watch(remainingMatchesProvider) == 0) {
          ref.read(currentAccountProvider.notifier).updateHighScore();
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const FinalResultPage(),
          ));
        } else {
          ref.watch(matchProvider.notifier).newMatch();
          Navigator.of(context).pop();
        }
      },
      label: const Text("Continue"),
    );
  }
}

class MapillaryWebView extends ConsumerWidget {
  const MapillaryWebView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint("Building $this");
    var currentMatch = ref.watch(matchProvider);

    return ClipRRect(
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(20.0),
        child: currentMatch.when(
          data: (data) {
            final url =
                "https://www.mapillary.com/embed?image_key=${data!.mapillaryCode}&style=photo";
            return InAppWebView(
                initialUrlRequest: URLRequest(url: WebUri(url)),
                onWebViewCreated: (controller) {
                  // Store controller if needed for further interaction
                },
                shouldOverrideUrlLoading: (controller, navigationAction) async {
                  // Prevent navigation to other pages
                  final isSamePage =
                      navigationAction.request.url.toString() == url;
                  return isSamePage
                      ? NavigationActionPolicy.ALLOW
                      : NavigationActionPolicy.CANCEL;
                });
          },
          error: (error, stacktrace) => const Center(
              child: Text(
                  "Uh oh! Something went wrong, please bo back and try again")),
          loading: () => const Center(child: MoonCircularLoader()),
        ));
  }
}

class MapView extends ConsumerWidget {
  const MapView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint("Building $this");
    return ClipRRect(
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(20.0),
        child: CommonMapWidget(
          markers: CommonMapWidget.markerMaker(
              guess: ref.watch(pickedCoordinatesProvider)),
          updatePosition: true,
        ));
  }
}

class MatchBackButton extends ConsumerWidget {
  const MatchBackButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isCurrentUserRegistered =
        ref.watch(currentAccountProvider).value!.guidAccount != null;
    debugPrint("Building $this");
    final currentAccountNotifier = ref.read(currentAccountProvider.notifier);
    Future<void> backModalBuilder(BuildContext context) {
      return showMoonModal<void>(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return PopScope(
            canPop: false,
            child: OrientationBuilder(builder: (context, orientation) {
              return MoonModal(
                child: SizedBox(
                  height: orientation == Orientation.portrait
                      ? MediaQuery.of(context).size.height - 600
                      : MediaQuery.of(context).size.height - 100,
                  width: orientation == Orientation.portrait
                      ? MediaQuery.of(context).size.width - 100
                      : MediaQuery.of(context).size.width - 500,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Are you sure you want to stop playing?",
                            style: Theme.of(context).textTheme.headlineSmall,
                            textAlign: TextAlign.center,
                          ),
                          if (isCurrentUserRegistered)
                            Text(
                              "Your current progress will be lost",
                              style: Theme.of(context).textTheme.headlineSmall,
                              textAlign: TextAlign.center,
                            )
                          else
                            const SizedBox(height: 50),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: MoonOutlinedButton(
                                  label: const Text("Yes"),
                                  onTap: () {
                                    if (isCurrentUserRegistered) {
                                      Navigator.of(context)
                                          .pushNamedAndRemoveUntil(
                                              '/account', (route) => false);
                                    } else {
                                      currentAccountNotifier.logout();
                                      Navigator.of(context)
                                          .pushNamedAndRemoveUntil(
                                              '/', (route) => false);
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: MoonOutlinedButton(
                                    label: const Text("No"),
                                    onTap: () =>
                                        Navigator.of(context).pop(context)),
                              ),
                            ],
                          )
                        ]),
                  ),
                ),
              );
            }),
          );
        },
      );
    }

    return Builder(builder: (BuildContext context) {
      return Align(
        alignment: Alignment.topLeft,
        child: MoonButton.icon(
          icon: const Icon(MoonIcons.controls_chevron_left_32_regular),
          onTap: () => backModalBuilder(context),
        ),
      );
    });
  }
}
