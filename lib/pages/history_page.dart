import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guess_the_place/providers.dart';
import 'package:guess_the_place/widgets/history_page_widgets.dart';
import 'package:latlong2/latlong.dart';
import 'package:moon_design/moon_design.dart';

class HistoryPage extends ConsumerWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint("Building $this");
    final history = ref.watch(matchHistoryProvider);
    return Scaffold(body: OrientationBuilder(builder: (context, orientation) {
      return Padding(
        padding: orientation == Orientation.portrait
            ? const EdgeInsets.fromLTRB(15, 55, 15, 25)
            : const EdgeInsets.fromLTRB(50, 30, 50, 15),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Row(
            children: [
              MoonButton.icon(
                icon: Icon(orientation == Orientation.portrait
                    ? MoonIcons.controls_chevron_left_32_regular
                    : MoonIcons.controls_chevron_left_small_16_regular),
                onTap: () => Navigator.pop(context),
              )
            ],
          ),
          Text(
            "Latest 100 matches",
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          history.when(
              skipLoadingOnRefresh: false,
              data: (list) {
                return Expanded(
                  child: OverflowBox(
                    maxWidth: MediaQuery.of(context).size.width,
                    child: MoonCarousel(
                        itemCount: list!.length,
                        itemExtent: MediaQuery.of(context).size.width - 32,
                        gap: 32,
                        itemBuilder: (context, index, _) {
                          debugPrint("building history item $index");
                          return Container(
                            decoration: ShapeDecoration(
                              color: context.moonColors!.heles,
                              shape: MoonSquircleBorder(
                                borderRadius: BorderRadius.circular(20)
                                    .squircleBorderRadius(context),
                              ),
                            ),
                            child: (orientation == Orientation.portrait)
                                ? HistoryAccordionPortrait(
                                    nickname: list[index].arcadeName!,
                                    date: list[index].dateTime!,
                                    points: list[index].points!,
                                    actualPosition: LatLng(
                                        double.parse(list[index].matchLat!),
                                        double.parse(list[index].matchLon!)),
                                    guessedPosition: LatLng(
                                        double.parse(list[index].guessedLat!),
                                        double.parse(list[index].guessedLon!)))
                                : HistoryAccordionLandscape(
                                    nickname: list[index].arcadeName!,
                                    date: list[index].dateTime!,
                                    points: list[index].points!,
                                    actualPosition: LatLng(
                                        double.parse(list[index].matchLat!),
                                        double.parse(list[index].matchLon!)),
                                    guessedPosition: LatLng(
                                        double.parse(list[index].guessedLat!),
                                        double.parse(list[index].guessedLon!))),
                          );
                        }),
                  ),
                );
              },
              error: (err, _) {
                return const Expanded(
                    child: Center(
                        child: Text(
                  "Uh oh! Something went wrong. Please go back and try again",
                  textAlign: TextAlign.center,
                )));
              },
              loading: () =>
                  const Expanded(child: Center(child: MoonCircularLoader()))),
        ]),
      );
    }));
  }
}
