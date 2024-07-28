import 'package:digio_xo_test/A_provider/his_game_provider.dart';
import 'package:digio_xo_test/A_provider/page_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class main_history extends StatefulWidget {
  const main_history({super.key});

  @override
  State<main_history> createState() => _main_historyState();
}

class _main_historyState extends State<main_history> {
  @override
  void initState() {
    super.initState();

    // เรียกใช้ Future.delayed เพื่อหน่วงเวลา 0 วินาที
    Future.delayed(Duration.zero, () async {
      final his_game_provider his_games =
          Provider.of<his_game_provider>(context, listen: false);

      await his_games.reset_date();
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screen_height = MediaQuery.of(context).size.height;
    // final double screen_width = MediaQuery.of(context).size.width;

    final double container_height = screen_height * 1;
    final double container_width = screen_height * 0.8;
    final page_state_provider page_states =
        Provider.of<page_state_provider>(context, listen: false);
    return Consumer<his_game_provider>(builder: (context, game_details, child) {
      return Stack(children: [
        Container(
          color: Colors.black,
          child: Row(
            children: [
              Expanded(
                  child: Container(
                child: Column(
                  children: [
                    Container(
                      height: 20,
                    ),
                    Container(
                      height: 70,
                      color: Colors.white,
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              page_states.update_state(1);
                            },
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.black,
                              ),
                              margin: EdgeInsets.all(5),
                              child: Center(
                                  child: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              )),
                            ),
                          ),
                          Expanded(
                              child: Container(
                            child: Center(
                                child: Text(
                              "HISTORY",
                              style: GoogleFonts.sarabun(
                                textStyle:
                                    Theme.of(context).textTheme.displayLarge,
                                fontSize: 34,
                                fontWeight: FontWeight.w800,
                                color: Colors.black,
                                fontStyle: FontStyle.normal,
                              ),
                            )),
                          ))
                        ],
                      ),
                    ),
                    Expanded(
                        child: Container(
                      child: ListView.builder(
                        itemCount: game_details
                            .get_data()
                            .length, // Number of items in the list
                        itemBuilder: (context, index) {
                          DateTime dateTime =
                              DateTime.fromMillisecondsSinceEpoch(
                                  game_details.get_data()[index].end_time_unix *
                                      1000);

                          // กำหนดรูปแบบวันที่
                          String formattedDate =
                              " " + DateFormat('dd/MM/yyyy').format(dateTime);
                          String Times =
                              " " + DateFormat('HH/mm/ss').format(dateTime);
                          String SCALE = game_details
                                  .get_data()[index]
                                  .play_scale
                                  .toString() +
                              "*" +
                              game_details
                                  .get_data()[index]
                                  .play_scale
                                  .toString();

                          String Who_win =
                              game_details.get_data()[index].who_win;
                          String win_by =
                              (game_details.get_data()[index].win_by + 1)
                                      .toString() +
                                  " ตัว";

                          return GestureDetector(
                            onTap: () {
                              game_details.update_his_game_monitor(index);
                            },
                            child: Container(
                              color: Colors.white,
                              margin: EdgeInsets.all(2),
                              child: Container(
                                height: 50,
                                color: game_details.INDEX_MONITOR() == index
                                    ? const Color.fromARGB(120, 0, 255, 132)
                                    : Colors.white,
                                margin: EdgeInsets.all(2),
                                child: Row(children: [
                                  Expanded(
                                      flex: 16,
                                      child: Column(children: [
                                        Expanded(child: Container()),
                                        Text(
                                          formattedDate,
                                          style: GoogleFonts.sarabun(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .displayLarge,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black,
                                            fontStyle: FontStyle.normal,
                                          ),
                                        ),
                                        Text(
                                          Times,
                                          style: GoogleFonts.sarabun(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .displayLarge,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black,
                                            fontStyle: FontStyle.normal,
                                          ),
                                        ),
                                        Expanded(child: Container()),
                                      ])),
                                  Expanded(
                                      flex: 10,
                                      child: Center(
                                          child: Text(
                                        SCALE,
                                        style: GoogleFonts.sarabun(
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .displayLarge,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                          fontStyle: FontStyle.normal,
                                        ),
                                      ))),
                                  Expanded(
                                      flex: 10,
                                      child: Center(
                                          child: Text(
                                        win_by,
                                        style: GoogleFonts.sarabun(
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .displayLarge,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                          fontStyle: FontStyle.normal,
                                        ),
                                      ))),
                                  Expanded(
                                      flex: 12,
                                      child: Text(
                                        Who_win,
                                        style: GoogleFonts.sarabun(
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .displayLarge,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                          fontStyle: FontStyle.normal,
                                        ),
                                      )),
                                ]),
                              ),
                            ),
                          );
                        },
                      ),
                    )),
                  ],
                ),
              )),
              Container(
                margin: EdgeInsets.all(20),
                // color: Colors.black38,
                child: Container(
                  height: container_height * 1,
                  width: container_width * 0.9,
                  child: GridView.count(
                    crossAxisCount: game_details
                        .get_data_monitor()
                        .play_scale, // จำนวนคอลัมน์
                    children: List.generate(
                        game_details.get_data_monitor().data_table_all.length,
                        (index) {
                      return GestureDetector(
                        onTap: () {
                          //game_details.update_data_play(index, context);
                        },
                        child: Container(
                          // margin: EdgeInsets.all(5),
                          color: Colors.black,
                          padding: const EdgeInsets.all(1.0), // ขนาดขอบ
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(2),
                            ),
                            child:
                                LayoutBuilder(builder: (context, constraints) {
                              double iconSize = constraints.maxWidth * 0.8;

                              return Stack(children: [
                                Container(
                                  //  padding: EdgeInsets.all(10),
                                  child: Center(
                                      child: game_details
                                                      .get_data_monitor()
                                                      .data_table_all[index]
                                                  ['data_table_all'] ==
                                              1
                                          ? Text(
                                              "X",
                                              style: GoogleFonts.sarabun(
                                                textStyle: Theme.of(context)
                                                    .textTheme
                                                    .displayLarge,
                                                fontSize: iconSize,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black,
                                                fontStyle: FontStyle.normal,
                                              ),
                                            )
                                          : game_details
                                                          .get_data_monitor()
                                                          .data_table_all[index]
                                                      ['data_table_all'] ==
                                                  2
                                              ? Text(
                                                  "O",
                                                  style: GoogleFonts.sarabun(
                                                    textStyle: Theme.of(context)
                                                        .textTheme
                                                        .displayLarge,
                                                    fontSize: iconSize,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black,
                                                    fontStyle: FontStyle.normal,
                                                  ),
                                                )
                                              : Container()),
                                ),
                                Visibility(
                                    visible: game_details
                                                .get_data_monitor()
                                                .winner_table[index]
                                            ['winner_table'] ==
                                        1,
                                    child: Container(
                                        height: double.infinity,
                                        width: double.infinity,
                                        color: const Color.fromARGB(
                                            120, 105, 240, 175))),
                                Visibility(
                                    visible: game_details
                                                .get_data_monitor()
                                                .winner_table[index]
                                            ['winner_table'] ==
                                        2,
                                    child: Container(
                                      height: double.infinity,
                                      width: double.infinity,
                                      color: const Color.fromARGB(
                                          120, 105, 240, 175),

                                      // game_details
                                      //            .get_data_monitor()
                                      //            .who_win[index] ==
                                      //       "bot"
                                      //   ? Colors.blueAccent
                                      //  :
                                    )),
                                Visibility(
                                  visible:
                                      game_details.get_data_monitor().who_win ==
                                          "DRAW",
                                  child: Container(
                                    height: double.infinity,
                                    width: double.infinity,
                                    color:
                                        const Color.fromARGB(120, 255, 193, 7),

                                    // game_details
                                    //            .get_data_monitor()
                                    //            .who_win[index] ==
                                    //       "bot"
                                    //   ? Colors.blueAccent
                                    //  :
                                  ),
                                )
                              ]);
                            }),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              )
            ],
          ),
        ),
        Positioned(
            right: 20,
            bottom: 10,
            child: GestureDetector(
              onTap: () {
                game_details.Delect_all(context);
              },
              child: Container(
                height: 50,
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.red,
                ),
                child: Center(
                  child: Text(
                    "Delect His",
                    style: GoogleFonts.sarabun(
                      textStyle: Theme.of(context).textTheme.displayLarge,
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
              ),
            ))
      ]);
    });
  }
}
