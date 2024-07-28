import 'package:digio_xo_test/A_provider/game_detail.provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class compli1 extends StatefulWidget {
  const compli1({super.key});

  @override
  State<compli1> createState() => _compli1State();
}

class _compli1State extends State<compli1> {
  @override
  Widget build(BuildContext context) {
    return Consumer<game_detail_provider>(
        builder: (context, game_details, child) {
      return Column(children: [
        Container(
            height: game_details.get_data().who_now == 2 ? 150 : 50,
            color: game_details.get_data().who_now == 2
                ? game_details.get_data().enemy == "player2"
                    ? Colors.redAccent
                    : Colors.blueAccent
                : Colors.black26,
            child: Center(
              child: Row(children: [
                Expanded(child: Container()),
                Text(
                  game_details.get_data().enemy == "player2"
                      ? "Player 2  O"
                      : "Bot  O",
                  style: GoogleFonts.sarabun(
                    textStyle: Theme.of(context).textTheme.displayLarge,
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                    fontStyle: FontStyle.normal,
                  ),
                ),

                /* Column(
                  children: [
                    Visibility(
                        visible: true,
                        child: LayoutBuilder(builder: (context, constraints) {
                          double iconSize = constraints.maxWidth;

                          return Container(
                            height: 100,
                            width: 100,
                            margin: EdgeInsets.all(10),
                            child: Image.asset(
                              'assets/bot.png',
                              width: 500,
                            ),
                          );
                        })),

                    //  Visibility(child: child),
                  ],
                ),*/
                Expanded(child: Container()),
              ]),
            )),
        Expanded(child: Container()),
      ]);
    });
  }
}
