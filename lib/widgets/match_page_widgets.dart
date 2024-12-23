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
          return MoonModal(
            child: SizedBox(
              height: 150,
              width: MediaQuery.of(context).size.width - 64,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("you scored"),
                    Text(
                      scoredPoints.toString(),
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    MoonFilledButton(
                      onTap: () {
                        ref.read(matchProvider.notifier).newMatch();
                        Navigator.of(context).pop();
                      },
                      label: const Text("Continue"),
                    )
                  ]),
            ),
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
            ref.read(matchProvider.notifier).saveMatch(arcadeName: arcadeName);
            modalBuilder(context);
          },
        );
      },
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
