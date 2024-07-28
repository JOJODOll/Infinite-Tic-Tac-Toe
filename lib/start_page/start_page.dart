import 'package:digio_xo_test/A_provider/game_detail.provider.dart';
import 'package:digio_xo_test/A_provider/page_state_provider.dart';
import 'package:digio_xo_test/BG/background.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class start_page extends StatefulWidget {
  const start_page({super.key});

  @override
  State<start_page> createState() => _start_pageState();
}

class _start_pageState extends State<start_page> {
  @override
  Widget build(BuildContext context) {
    final page_state_provider page_states =
        Provider.of<page_state_provider>(context, listen: false);
    final game_detail_provider game_details =
        Provider.of<game_detail_provider>(context, listen: false);
    return Stack(children: [
      background(),
      Container(
        //color: Colors.black12,
        child: Center(
          child: Container(
            /*  decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),*/
            child: Column(
              children: [
                Expanded(child: Container()),
                Visibility(
                  visible: game_details.get_data().state_game == 0,
                  child: GestureDetector(
                    onTap: () {
                      page_states.update_state(2);
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      width: 200,
                      height: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black),
                        child: Center(
                          child: Text(
                            'New-Game',
                            style: GoogleFonts.lato(
                                textStyle:
                                    Theme.of(context).textTheme.displayLarge,
                                fontSize: 30,
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.italic,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: game_details.get_data().state_game == 1 ||
                      game_details.get_data().state_game == 2,
                  child: GestureDetector(
                    onTap: () {
                      page_states.update_state(2);
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      width: 200,
                      height: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black),
                        child: Center(
                          child: Text(
                            'Continous',
                            style: GoogleFonts.lato(
                                textStyle:
                                    Theme.of(context).textTheme.displayLarge,
                                fontSize: 30,
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.italic,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: game_details.get_data().state_game == 1 ||
                      game_details.get_data().state_game == 2,
                  child: GestureDetector(
                    onTap: () async {
                      final game_detail_provider game_details =
                          Provider.of<game_detail_provider>(context,
                              listen: false);
                      game_details.refesh_game(context);
                      page_states.update_state(2);
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      width: 200,
                      height: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black),
                        child: Center(
                          child: Text(
                            'Restart',
                            style: GoogleFonts.lato(
                                textStyle:
                                    Theme.of(context).textTheme.displayLarge,
                                fontSize: 30,
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.italic,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    page_states.update_state(3);
                  },
                  child: Container(
                    width: 200,
                    height: 80,
                    margin: EdgeInsets.all(10),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black),
                      child: Center(
                        child: Text(
                          'History',
                          style: GoogleFonts.lato(
                              textStyle:
                                  Theme.of(context).textTheme.displayLarge,
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.italic,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(child: Container()),
              ],
            ),
          ),
        ),
      ),
      Positioned(
        bottom: 10,
        right: 10,
        child: Container(
            child: Text(
          "Infinite TIC TAC TOE",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w900,
            color: Colors.black,
            // เพิ่มขอบโดยการใช้ shadow
            shadows: [
              /* Shadow(
                offset: Offset(1.0, 1.0),
                color: Colors.white,
                // blurRadius: 2.0,
              ),*/
              Shadow(
                offset: Offset(-1.0, -1.0),
                color: Colors.white,
                //  blurRadius: 2.0,
              ),
            ],
          ),
        )),
      )
    ]);
  }
}
