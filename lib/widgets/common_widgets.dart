import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guess_the_place/providers.dart';
import 'package:latlong2/latlong.dart';
import 'package:moon_design/moon_design.dart';

class CommonParameters {
  static const portraitEdgeInsets = EdgeInsets.fromLTRB(15, 55, 15, 25);
  static const landscapeEdgeInsets = EdgeInsets.fromLTRB(50, 30, 50, 15);
}

class BackButtonPortrait extends StatelessWidget {
  const BackButtonPortrait({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint("buildin $this");
    return Row(children: [
      MoonButton.icon(
        icon: const Icon(MoonIcons.controls_chevron_left_32_regular),
        onTap: () => Navigator.pop(context),
      )
    ]);
  }
}

class BackButtonLandscape extends StatelessWidget {
  const BackButtonLandscape({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint("buildin $this");
    return Row(children: [
      MoonButton.icon(
        icon: const Icon(MoonIcons.controls_chevron_left_small_16_regular),
        onTap: () => Navigator.pop(context),
      )
    ]);
  }
}

class CommonMapWidget extends ConsumerWidget {
  const CommonMapWidget(
      {super.key,
      this.center,
      required this.markers,
      this.polyline,
      this.updatePosition = false});

  final LatLng? center;
  final List<Marker> markers;
  final List<Polyline<Object>>? polyline;
  final bool updatePosition;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint("Building $this");
    return FlutterMap(
      options: MapOptions(
          initialCenter: center ?? ref.read(pickedCoordinatesProvider),
          initialZoom: 3.0,
          onTap: (tapLoc, position) {
            if (updatePosition) {
              debugPrint(
                  "Lat: ${position.latitude}|Lon: ${position.longitude}");
              ref.read(pickedCoordinatesProvider.notifier).state = position;
            }
          }),
      children: [
        TileLayer(
          urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
        ),
        MarkerLayer(markers: markers),
        PolylineLayer(polylines: polyline ?? <Polyline<Object>>[])
      ],
    );
  }

  static List<Marker> markerMaker({required LatLng guess, LatLng? actual}) {
    List<Marker> output = [];
    output.add(Marker(
      width: 80.0,
      height: 80.0,
      point: guess,
      child: const Icon(
        MoonIcons.maps_location_32_regular,
        color: Color.fromARGB(255, 255, 7, 7),
      ),
    ));
    if (actual != null) {
      output.add(Marker(
        width: 80.0,
        height: 80.0,
        point: actual,
        child: const Icon(
          MoonIcons.maps_location_32_regular,
          color: Color.fromARGB(255, 7, 155, 7),
        ),
      ));
    }
    return output;
  }

  static List<Polyline<Object>> polylineMaker(
      {required LatLng guess, required LatLng actual}) {
    final List<Polyline<Object>> output = [];
    output.add(Polyline(
        points: [guess, actual],
        color: const Color.fromARGB(255, 7, 105, 255)));
    return output;
  }
}
