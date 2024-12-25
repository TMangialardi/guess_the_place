import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:moon_design/moon_design.dart';

class HistoryAccordionPortrait extends StatelessWidget {
  final String nickname;
  final String date;
  final String points;
  final LatLng actualPosition;
  final LatLng guessedPosition;
  const HistoryAccordionPortrait(
      {super.key,
      required this.nickname,
      required this.date,
      required this.points,
      required this.actualPosition,
      required this.guessedPosition});

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy HH:mm');
    final String formattedDate = formatter.format(DateTime.parse(date));
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Nickname:", style: Theme.of(context).textTheme.headlineSmall),
          Text(nickname),
          const SizedBox(height: 20),
          Text("Date:", style: Theme.of(context).textTheme.headlineSmall),
          Text(formattedDate),
          const SizedBox(height: 20),
          Text("Points:", style: Theme.of(context).textTheme.headlineSmall),
          Text(points),
          const SizedBox(height: 50),
          Expanded(
              child: ClipRRect(
                  clipBehavior: Clip.antiAlias,
                  borderRadius: BorderRadius.circular(10.0),
                  child: HistoryMap(
                      actualPosition: actualPosition,
                      guessedPosition: guessedPosition)))
        ],
      ),
    );
  }
}

class HistoryAccordionLandscape extends StatelessWidget {
  final String nickname;
  final String date;
  final String points;
  final LatLng actualPosition;
  final LatLng guessedPosition;
  const HistoryAccordionLandscape(
      {super.key,
      required this.nickname,
      required this.date,
      required this.points,
      required this.actualPosition,
      required this.guessedPosition});

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy HH:mm');
    final String formattedDate = formatter.format(DateTime.parse(date));
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(children: [
        Expanded(
            child: ClipRRect(
                clipBehavior: Clip.antiAlias,
                borderRadius: BorderRadius.circular(10.0),
                child: HistoryMap(
                    actualPosition: actualPosition,
                    guessedPosition: guessedPosition))),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Nickname:",
                  style: Theme.of(context).textTheme.headlineSmall),
              Text(nickname),
              const SizedBox(height: 10),
              Text("Date:", style: Theme.of(context).textTheme.headlineSmall),
              Text(formattedDate),
              const SizedBox(height: 10),
              Text("Points:", style: Theme.of(context).textTheme.headlineSmall),
              Text(points),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ]),
    );
  }
}

class HistoryMap extends StatelessWidget {
  final LatLng actualPosition;
  final LatLng guessedPosition;
  const HistoryMap(
      {super.key, required this.actualPosition, required this.guessedPosition});

  @override
  Widget build(BuildContext context) {
    debugPrint("building $this");
    return FlutterMap(
      options: MapOptions(
        initialCenter: guessedPosition,
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
            point: guessedPosition,
            child: const Icon(
              MoonIcons.maps_location_32_regular,
              color: Color.fromARGB(255, 255, 7, 7),
            ),
          ),
          Marker(
            width: 80.0,
            height: 80.0,
            point: actualPosition,
            child: const Icon(
              MoonIcons.maps_location_32_regular,
              color: Color.fromARGB(255, 7, 155, 7),
            ),
          ),
        ]),
        PolylineLayer(polylines: [
          Polyline(
              points: [guessedPosition, actualPosition],
              color: const Color.fromARGB(255, 7, 105, 255))
        ])
      ],
    );
  }
}
