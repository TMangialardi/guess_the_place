import 'package:flutter/material.dart';
import 'package:guess_the_place/widgets/common_widgets.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';

class HistoryAccordion extends StatelessWidget {
  final String nickname;
  final String date;
  final String points;
  final LatLng actualPosition;
  final LatLng guessedPosition;
  const HistoryAccordion(
      {super.key,
      required this.nickname,
      required this.date,
      required this.points,
      required this.actualPosition,
      required this.guessedPosition});

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      return orientation == Orientation.portrait
          ? HistoryAccordionPortrait(
              nickname: nickname,
              date: date,
              points: points,
              actualPosition: actualPosition,
              guessedPosition: guessedPosition)
          : HistoryAccordionLandscape(
              nickname: nickname,
              date: date,
              points: points,
              actualPosition: actualPosition,
              guessedPosition: guessedPosition);
    });
  }
}

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
    final String formattedDate =
        formatter.format(DateTime.parse(date).toLocal());
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
                  child: CommonMapWidget(
                    center: guessedPosition,
                    markers: CommonMapWidget.markerMaker(
                        guess: guessedPosition, actual: actualPosition),
                    polyline: CommonMapWidget.polylineMaker(
                        guess: guessedPosition, actual: actualPosition),
                  )))
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
    final String formattedDate =
        formatter.format(DateTime.parse(date).toLocal());
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(children: [
        Expanded(
            flex: 3,
            child: ClipRRect(
                clipBehavior: Clip.antiAlias,
                borderRadius: BorderRadius.circular(10.0),
                child: CommonMapWidget(
                  center: guessedPosition,
                  markers: CommonMapWidget.markerMaker(
                      guess: guessedPosition, actual: actualPosition),
                  polyline: CommonMapWidget.polylineMaker(
                      guess: guessedPosition, actual: actualPosition),
                ))),
        const SizedBox(width: 10),
        Expanded(
          flex: 2,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Nickname:",
                    style: Theme.of(context).textTheme.headlineSmall),
                Text(nickname),
                const SizedBox(height: 20),
                Text("Date:", style: Theme.of(context).textTheme.headlineSmall),
                Text(formattedDate),
                const SizedBox(height: 20),
                Text("Points:",
                    style: Theme.of(context).textTheme.headlineSmall),
                Text(points),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}

class HistoryText extends StatelessWidget {
  const HistoryText({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint("Buildin $this");
    return Text(
      "Latest 100 matches",
      style: Theme.of(context).textTheme.headlineMedium,
      textAlign: TextAlign.center,
    );
  }
}
