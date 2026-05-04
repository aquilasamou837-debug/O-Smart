import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class WaterLevel extends StatefulWidget {
  const WaterLevel({super.key});

  @override
  State<WaterLevel> createState() => _WaterLevelState();
}

class _WaterLevelState extends State<WaterLevel> {
  
  final double _speed = 10; // valeur initiale
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 250, // largeur fixe
          height: 250, // hauteur fixe
          child: SfRadialGauge(
            axes: <RadialAxis>[
              RadialAxis(
                minimum: 0,
                maximum: 100,
                showTicks: false,
                showLabels: false,
                axisLineStyle: AxisLineStyle(
                  thickness: 20,
                  cornerStyle: CornerStyle.bothCurve,
                  color: Colors.grey.shade300,
                ),
                pointers: <GaugePointer>[
                  RangePointer(
                    value: _speed,
                    width: 20,
                    cornerStyle: CornerStyle.bothCurve,
                    gradient: SweepGradient(
                      colors: <Color>[Colors.pinkAccent, Colors.blue],
                      stops: <double>[0.0, 1.0],
                    ),
                  ),
                ],
                annotations: <GaugeAnnotation>[
                  GaugeAnnotation(
                    widget: Container(
                      height: 100,
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          SizedBox(height: 5),
                          Text(
                            '${_speed.toInt()}%',
                            style: TextStyle(
                              fontSize: 44,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Niveau d\'eau',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w300,
                            color: Colors.black,
                          ),
                        ),
                      ],
                      )
                    ),
                    positionFactor: 0.1,
                    angle: 90,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
