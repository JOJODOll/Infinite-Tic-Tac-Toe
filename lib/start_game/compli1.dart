import 'package:digio_xo_test/A_provider/game_detail.provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class compli2 extends StatefulWidget {
  const compli2({super.key});

  @override
  State<compli2> createState() => _compli2State();
}

class _compli2State extends State<compli2> {
  @override
  Widget build(BuildContext context) {
    // game_details
    return Consumer<game_detail_provider>(
        builder: (context, game_details, child) {
      return Column(children: [
        Expanded(child: Container()),
        GestureDetector(
          onTap: () {
            //   TEST();
          },
          child: Container(
              height: game_details.get_data().who_now == 1 ? 120 : 50,
              color: game_details.get_data().who_now == 1
                  ? Colors.amberAccent
                  : Colors.black26,
              child: Center(
                child: Text(
                  "Player 1  X",
                  style: GoogleFonts.sarabun(
                    textStyle: Theme.of(context).textTheme.displayLarge,
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              )),
        ),
      ]);
    });
  }
}
