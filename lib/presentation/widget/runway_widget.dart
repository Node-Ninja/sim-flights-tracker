import 'package:flutter/material.dart';

import '../../core/config/i10n/generated/app_localizations.dart';
import '../../core/theme/colors.dart';
import '../../data/entity/_airport.dart';
import '../util/space_utils.dart';
import 'my_separator.dart';


class RunwayWidget extends StatefulWidget {
  final Runway runway;

  const RunwayWidget({super.key, required this.runway});

  @override
  RunwayWidgetState createState() => RunwayWidgetState();
}

class RunwayWidgetState extends State<RunwayWidget> {
  bool isMetric = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget> [
                Row(
                  children: [
                    Text(AppLocalizations.of(context)!.elevation, style: const TextStyle(color: Colors.grey),),
                  ],
                ),
                const SizedBox(height: 5,),
                Text((widget.runway.headElevationFeet != '') ? '${widget.runway.headElevationFeet} ft' : 'Unknown', style: const TextStyle(color: SftColors.customGrey),)
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget> [
                Row(
                  children: [
                    Text(AppLocalizations.of(context)!.elevation, style: const TextStyle(color: Colors.grey),),
                  ],
                ),
                const SizedBox(height: 5,),
                Text((widget.runway.legElevationFeet != '') ? '${widget.runway.legElevationFeet} ft' : 'Unknown', style: const TextStyle(color: SftColors.customGrey),)
              ],
            ),
          ],
        ),
        verticalSpace(10),
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 50,
              decoration: const BoxDecoration(
                color: Colors.transparent,
                border: Border.symmetric(
                  horizontal: BorderSide(color: SftColors.lightGreen),
                  vertical: BorderSide(color: SftColors.lightGreen, width: 3)
                )
              ),
            ),
            Positioned(
              left: 5,
              child: buildRunwayEndMarker()
            ),
            Positioned(
                right: 5,
                child: buildRunwayEndMarker()
            ),
            const Positioned(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: MySeparator(height: 2, color: SftColors.lightGreen,),
              ),
            ),
            Positioned(
              left: 0,
              child: RotatedBox(
                quarterTurns: 1,
                child: Container(
                  // color: Colors.black,
                  margin: const EdgeInsets.only(
                    bottom: 15,
                  ),
                  child: Text(
                    widget.runway.headIdent,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white.withValues(alpha: 0.7),
                      shadows: const <Shadow>[
                       Shadow(
                          offset: Offset(0,0),
                          blurRadius: 4.0,
                          color: Colors.black,
                        ),
                        Shadow(
                          offset: Offset(0,0),
                          blurRadius: 8.0,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              right: 0,
              child: RotatedBox(
                quarterTurns: 3,
                child: Container(
                  // color: Colors.black,
                  margin: const EdgeInsets.only(
                    bottom: 15,
                  ),
                  child: Text(
                    widget.runway.legIdent,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white.withValues(alpha: 0.7),
                      shadows: const <Shadow>[
                        Shadow(
                          offset: Offset(0,0),
                          blurRadius: 4.0,
                          color: Colors.black,
                        ),
                        Shadow(
                          offset: Offset(0,0),
                          blurRadius: 8.0,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        verticalSpace(5),
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10,),
              height: 1,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  isMetric = !isMetric;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 10,
                ),
                decoration: BoxDecoration(
                  color: SftColors.primaryDark,
                  borderRadius: BorderRadius.circular(
                    20,
                  ),
                ),
                child: Text(
                  (isMetric) ? '${(int.parse(widget.runway.lengthFeet) / 3.28084).round()} m' : '${widget.runway.lengthFeet} ft',
                  style: const TextStyle(
                    color: SftColors.customGrey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              child: Icon(
                Icons.chevron_left,
                color: Colors.white.withValues(alpha: 0.3),
              ),
            ),
            Positioned(
              right: 0,
              child: Icon(
                Icons.chevron_right,
                color: Colors.white.withValues(alpha: 0.3),
              ),
            ),
          ],
        ),
        verticalSpace(20),
      ],
    );
  }

  Widget buildRunwayEndMarker() {
    return Column(
      children: [
        Container(height: 3, width: 12, color: SftColors.lightGreen,),
        verticalSpace(3),
        Container(height: 3, width: 12, color: SftColors.lightGreen,),
        verticalSpace(3),
        Container(height: 3, width: 12, color: SftColors.lightGreen,),
        verticalSpace(3),
        Container(height: 3, width: 12, color: SftColors.lightGreen,),
        verticalSpace(3),
        Container(height: 3, width: 12, color: SftColors.lightGreen,),
        verticalSpace(3),
        Container(height: 3, width: 12, color: SftColors.lightGreen,),
        verticalSpace(3),
        Container(height: 3, width: 12, color: SftColors.lightGreen,),
      ],
    );
  }
}
