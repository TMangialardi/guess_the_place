import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guess_the_place/providers.dart';
import 'package:latlong2/latlong.dart';
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
                                  child: _ResultModalMap()),
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
            var arcadeName = ref.read(currentAccountProvider).value!.username!;
            if (ref.watch(matchProvider).value == null) {
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
    return MoonOutlinedButton(
      onTap: () {
        ref.watch(matchProvider.notifier).newMatch();
        Navigator.of(context).pop();
      },
      label: const Text("Continue"),
    );
  }
}

class _ResultModalMap extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FlutterMap(
      options: MapOptions(
        initialCenter: ref.read(pickedCoordinatesProvider),
        initialZoom: 3.0,
      ),
      children: [
        TileLayer(
          urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
        ),
        MarkerLayer(markers: [
          Marker(
            width: 80.0,
            height: 80.0,
            point: ref.read(pickedCoordinatesProvider),
            child: const Icon(
              MoonIcons.maps_location_32_regular,
              color: Color.fromARGB(255, 255, 7, 7),
            ),
          ),
          Marker(
            width: 80.0,
            height: 80.0,
            point: ref.read(matchProvider).value!.coordinates,
            child: const Icon(
              MoonIcons.maps_location_32_regular,
              color: Color.fromARGB(255, 7, 155, 7),
            ),
          ),
        ]),
        PolylineLayer(polylines: [
          Polyline(points: [
            ref.read(pickedCoordinatesProvider),
            ref.read(matchProvider).value!.coordinates
          ], color: const Color.fromARGB(255, 7, 105, 255))
        ])
      ],
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
          error: (error, stacktrace) =>
              const Center(child: MoonCircularLoader()),
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
        child: FlutterMap(
          options: MapOptions(
              initialCenter: const LatLng(43.6841, 13.2433),
              initialZoom: 5.0,
              onTap: (tapLoc, position) {
                debugPrint(
                    "Lat: ${position.latitude}|Lon: ${position.longitude}");
                ref.read(pickedCoordinatesProvider.notifier).state = position;
              }),
          children: [
            TileLayer(
              urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
            ),
            MarkerLayer(markers: [
              Marker(
                width: 80.0,
                height: 80.0,
                point: ref.watch(pickedCoordinatesProvider),
                child: const Icon(
                  MoonIcons.maps_location_32_regular,
                  color: Color.fromARGB(255, 255, 7, 7),
                ),
              ),
            ])
          ],
        ));
  }
}
