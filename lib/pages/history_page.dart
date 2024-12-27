import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guess_the_place/providers.dart';
import 'package:guess_the_place/widgets/common_widgets.dart';
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
            ? CommonParameters.portraitEdgeInsets
            : CommonParameters.landscapeEdgeInsets,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          orientation == Orientation.portrait
              ? const BackButtonPortrait()
              : const BackButtonLandscape(),
          const HistoryText(),
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
                            child: HistoryAccordion(
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
