import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class background extends StatefulWidget {
  const background({super.key});

  @override
  State<background> createState() => _backgroundState();
}

class _backgroundState extends State<background> {
  Timer? _timer;
  Timer? _timer2;

  double _currentTime = 0.0;
  final double _interval = 50;
  final double _duration = 10;
  double sinValue = 0.0;
  int scale = 3;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer2 = Timer.periodic(Duration(milliseconds: 2000), (Timer timer) {
      scale++;
      if (scale > 10) {
        scale = 3;
      }
    });

    _timer = Timer.periodic(Duration(milliseconds: _interval.toInt()),
        (Timer timer) {
      setState(() {
        _currentTime += _interval / 1000;

        sinValue = 1 + 0.2 * sin(2 * pi * _currentTime / _duration);
        /* print(
            'Time: ${_currentTime.toStringAsFixed(2)} seconds, Sin: ${sinValue.toStringAsFixed(2)}');
*/
        if (_currentTime >= _duration) {
          _currentTime = 0;
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _timer2?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screen_height = MediaQuery.of(context).size.height;
    final double screen_width = MediaQuery.of(context).size.width;

    return ClipRect(
      child: Container(
        child: Stack(
          children: [
            Transform.rotate(
              angle: 3.14 * sinValue,
              child: Transform.scale(
                scale: sinValue * 2,
                child: Center(
                    child: Container(
                  height: screen_height,
                  width: screen_width * 0.6,
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: scale,
                      crossAxisSpacing: 5.0,
                      mainAxisSpacing: 5.0,
                    ),
                    itemCount: scale * scale,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        color: Colors.teal[100 * (index % 9)],
                        child: Center(
                          child: Text(
                            "XO",
                            style: GoogleFonts.sarabun(
                              textStyle:
                                  Theme.of(context).textTheme.displayLarge,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )),
              ),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(),
            )
          ],
        ),
      ),
    );
  }
}
