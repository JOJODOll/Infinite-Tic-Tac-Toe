import 'package:digio_xo_test/A_provider/check_winner-provider.dart';
import 'package:digio_xo_test/A_provider/game_detail.provider.dart';
import 'package:digio_xo_test/A_provider/page_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class main_Setting extends StatefulWidget {
  const main_Setting({super.key});

  @override
  State<main_Setting> createState() => _main_SettingState();
}

class _main_SettingState extends State<main_Setting> {
  String _selectedGridSize = '3x3'; // ค่าเริ่มต้น

  String win_by = "3";

  @override
  Widget build(BuildContext context) {
    final check_winner_provider check_winners =
        Provider.of<check_winner_provider>(context, listen: false);
    final page_state_provider page_states =
        Provider.of<page_state_provider>(context, listen: false);
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Consumer<game_detail_provider>(
        builder: (context, game_details, child) {
      return Container(
        height: screenHeight * 0.8,
        width: screenWidth * 0.5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Row(children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.black12,
                  ),
                  child: DropdownButton<String>(
                    value: _selectedGridSize,
                    items: List.generate(50, (index) {
                      int size = index + 3;

                      // 2 * (index + 1) + 1;
                      return DropdownMenuItem<String>(
                        value: '${size}x$size',
                        child: Center(
                            child: Text(
                          "${size}x$size",
                          style: GoogleFonts.lato(
                              textStyle:
                                  Theme.of(context).textTheme.displayLarge,
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.italic,
                              color: Colors.black),
                        )),
                      );
                    }),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedGridSize = newValue!;
                        //(_selectedGridSize);
                      });
                    },
                    underline: SizedBox(), // Hide the underline
                    isExpanded: true,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.black12,
                  ),
                  child: DropdownButton<String>(
                    value: win_by,
                    items: List.generate(50, (index) {
                      int size = index + 3;

                      // 2 * (index + 1) + 1;
                      return DropdownMenuItem<String>(
                        value: '$size',
                        child: Center(
                          child: Text(
                            "$size" + " ตัว",
                            style: GoogleFonts.lato(
                                textStyle:
                                    Theme.of(context).textTheme.displayLarge,
                                fontSize: 30,
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.italic,
                                color: Colors.black),
                          ),
                        ),
                      );
                    }),
                    onChanged: (String? newValue) {
                      setState(() {
                        List<String> S = _selectedGridSize.split('x');
                        //print(win_by[0]);

                        int size_win_by = int.parse(S[0]);
                        if (int.parse(newValue!) <= size_win_by) {
                          win_by = newValue;
                        }

                        //if(win_by size_win_by){}
                        //(_selectedGridSize);
                      });
                    },
                    underline: SizedBox(), // Hide the underline
                    isExpanded: true,
                    hint: Container(
                      color: Colors.white,
                      height: 20,
                      child: Text(
                        'Select Grid Size',
                        style: GoogleFonts.sarabun(
                          textStyle: Theme.of(context).textTheme.displayLarge,
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ]),

            Expanded(
                child: Container(
              // color: Colors.black38,
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: game_details.get_data().enemy == "player2"
                          ? Colors.redAccent
                          : Colors.black12,
                    ),
                    child: Center(
                      child: LayoutBuilder(builder: (context, constraints) {
                        double iconSize = constraints.maxWidth;

                        return GestureDetector(
                          onTap: () {
                            game_details.update_enemy_player2();
                          },
                          child: Container(
                            margin: EdgeInsets.all(10),
                            child: Image.asset(
                              'assets/player2.png',
                              width: iconSize,
                            ),
                          ),
                        );
                      }),
                    ),
                  )),
                  Expanded(
                      child: Container(
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: game_details.get_data().enemy == "bot"
                          ? Colors.blueAccent
                          : Colors.black12,
                    ),
                    child: Center(
                      child: LayoutBuilder(builder: (context, constraints) {
                        double iconSize = constraints.maxWidth;

                        return GestureDetector(
                          onTap: () {
                            game_details.update_enemy_bot();
                          },
                          child: Container(
                            margin: EdgeInsets.all(10),
                            child: Image.asset(
                              'assets/bot.png',
                              width: iconSize,
                            ),
                          ),
                        );
                      }),
                    ),
                  )),
                ],
              ),
            )), // Expands to fill the available space
            Container(
              height: screenHeight * 0.2,
              color: Colors.black12,
              child: Row(
                children: [
                  Expanded(
                      child: GestureDetector(
                          onTap: () async {
                            page_states.update_state(1);
                          },
                          child: Container(
                            margin: EdgeInsets.fromLTRB(10, 10, 2.5, 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.black,
                            ),
                            child: Center(
                                child: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            )),
                          ))),
                  Expanded(
                    flex: 4,
                    child: GestureDetector(
                      onTap: () async {
                        await game_details.start_game(
                            context, _selectedGridSize, win_by);

                        await check_winners.start(context);

                        //print(_selectedGridSize);
                      },
                      child: Container(
                        margin: EdgeInsets.fromLTRB(2.5, 10, 10, 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black,
                        ),
                        child: Center(
                          child: Text(
                            "START",
                            style: GoogleFonts.sarabun(
                              textStyle:
                                  Theme.of(context).textTheme.displayLarge,
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
