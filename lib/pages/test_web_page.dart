import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guess_the_place/providers.dart';
import 'package:latlong2/latlong.dart';
import 'package:moon_design/moon_design.dart';

class TestWebPage extends ConsumerWidget {
  const TestWebPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var currentMatch = ref.watch(matchProvider);
    debugPrint("Building $this");
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.fromLTRB(15, 55, 15, 25),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Align(
          alignment: Alignment.topLeft,
          child: MoonButton.icon(
            icon: const Icon(MoonIcons.controls_chevron_left_32_regular),
            onTap: () => Navigator.pop(context),
          ),
        ),
        Expanded(
          child: ClipRRect(
              clipBehavior: Clip.antiAlias,
              borderRadius: BorderRadius.circular(20.0),
              child: currentMatch.when(
                data: (data) => InAppWebView(
                    initialUrlRequest: URLRequest(
                        url: WebUri(
                            "https://www.mapillary.com/embed?image_key=${data!.mapillaryCode}&style=photo")),
                    onWebViewCreated: (controller) {
                      // Store controller if needed for further interaction
                    },
                    shouldOverrideUrlLoading:
                        (controller, navigationAction) async {
                      // Prevent navigation to other pages
                      final isSamePage = navigationAction.request.url
                              .toString() ==
                          "https://www.mapillary.com/embed?image_key=${data.mapillaryCode}&style=photo";
                      return isSamePage
                          ? NavigationActionPolicy.ALLOW
                          : NavigationActionPolicy.CANCEL;
                    }),
                error: (error, stacktrace) =>
                    const Center(child: MoonCircularLoader()),
                loading: () => const Center(child: MoonCircularLoader()),
              )),
        ),
        const SizedBox(height: 50),
        Expanded(
          child: ClipRRect(
              clipBehavior: Clip.antiAlias,
              borderRadius: BorderRadius.circular(20.0),
              child: FlutterMap(
                options: MapOptions(onTap: (tapLoc, position) {
                  debugPrint(
                      "Lat: ${position.latitude}|Lon: ${position.longitude}");
                }),
                children: [
                  TileLayer(
                    urlTemplate:
                        "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                  ),
                  const MarkerLayer(markers: [
                    Marker(
                      width: 80.0,
                      height: 80.0,
                      point: LatLng(20, 20),
                      child: Icon(
                        MoonIcons.maps_pin_location_32_regular,
                        color: Color.fromARGB(255, 255, 7, 7),
                      ),
                    ),
                  ])
                ],
              )),
        ),
      ]),
    ));
  }
}
