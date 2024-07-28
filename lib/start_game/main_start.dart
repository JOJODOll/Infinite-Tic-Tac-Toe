import 'dart:async';
import 'dart:ui';

import 'package:digio_xo_test/A_provider/game_detail.provider.dart';
import 'package:digio_xo_test/A_provider/his_game_provider.dart';
import 'package:digio_xo_test/A_provider/page_state_provider.dart';
import 'package:digio_xo_test/start_game/compli1.dart';
import 'package:digio_xo_test/start_game/compli2.dart';
import 'package:digio_xo_test/start_game/setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class main_start extends StatefulWidget {
  const main_start({super.key});

  @override
  State<main_start> createState() => _main_startState();
}

class _main_startState extends State<main_start> {
  bool drag_state = false;
  bool setting_state = false;

  double drag_x = 0;
  double drag_y = 0;
  double game_drag_x = 25;
  double game_drag_y = 0;
  int count_drag = 0;
  double scale = 1.0;
  Timer? timer;

  @override
  void initState() {
    super.initState();
  }

  void drag_buttom_start(double delx, double dely, double MAX) {
    if (!drag_state) {
      setState(() {
        drag_state = true;
      });
      timer = Timer.periodic(Duration(milliseconds: 10), (timer) {
        setState(() {
          game_drag_x += drag_x / 8;
          game_drag_y += drag_y / 8;
        });

        if (game_drag_x >= MAX * 3) {
          setState(() {
            game_drag_x = MAX * 3;
            // game_drag_y += drag_y;
          });
        }
        if (game_drag_x <= -MAX * 3) {
          setState(() {
            game_drag_x = -MAX * 3;
            // game_drag_y += drag_y;
          });
        }
        if (game_drag_y >= MAX * 3) {
          setState(() {
            game_drag_y = MAX * 3;
            // game_drag_y += drag_y;
          });
        }
        if (game_drag_y <= -MAX * 3) {
          setState(() {
            game_drag_y = -MAX * 3;
            // game_drag_y += drag_y;
          });
        }
      });
    } else {
      setState(() {
        drag_x += delx / 2;
        drag_y += dely / 2;
      });
    }
  }

  void drag_buttom_stop() {
    timer?.cancel();
    {
      setState(() {
        // game_drag_x = 0;
        // game_drag_y = 0;
        drag_state = false;

        drag_x = 0;
        drag_y = 0;
      });
    }
  }

  void add_scale() {
    // if (scale <= ) {
    setState(() {
      scale += 0.1;
    });
    //}
  }

  void min_scale() {
    if (scale >= 0.8) {
      setState(() {
        scale -= 0.1;
      });
    }
  }

  void reset_position() {
    setState(() {
      game_drag_x = 25;
      game_drag_y = 0;
      scale = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screen_height = MediaQuery.of(context).size.height;
    final double screen_width = MediaQuery.of(context).size.width;

    final double container_height = screen_height * 1;
    final double container_width = screen_height * 0.8;

    final double settting_bottom_h = screen_height * 0.12;
    final double settting_bottom_w = screen_height * 0.12;
    final double control_bottom_h = screen_height * 0.2;
    //final double control_bottom = screen_height * 0.08;
    return Consumer2<game_detail_provider, page_state_provider>(
        builder: (context, game_details, page_states, child) {
      return Stack(children: [
        Container(
          color: Colors.black38,
          child: Row(children: [
            Expanded(
                child: Container(
              color: Colors.black,
              child: Column(
                children: [
                  Expanded(
                      child: Container(
                    child: Column(
                      children: [
                        Expanded(child: Container()),
                        Text(
                          "INFINITE",
                          style: GoogleFonts.sarabun(
                            textStyle: Theme.of(context).textTheme.displayLarge,
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(1),
                          child: Text(
                            "Tic Tac Toe",
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
                        Container(
                          margin: EdgeInsets.all(10),
                          child: Text(
                            game_details.get_data().play_scale.toString() +
                                "*" +
                                game_details.get_data().play_scale.toString(),
                            style: GoogleFonts.sarabun(
                              textStyle:
                                  Theme.of(context).textTheme.displayLarge,
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                        Expanded(flex: 2, child: Container()),
                      ],
                    ),
                  )),
                  Row(children: [
                    GestureDetector(
                      onTap: () {
                        page_states.update_state(1);
                      },
                      child: Container(
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                          ),
                          height: settting_bottom_h,
                          width: settting_bottom_w,
                          child: Center(
                            child: Icon(Icons.settings),
                          )),
                    ),
                    Expanded(child: Container()),
                  ])
                ],
              ),
            )),
            ClipRect(
              child: Container(
                color: Colors.white54,
                height: container_height + 20,
                width: container_width + 50,
                child: Center(
                  child: Container(
                    child: Transform.scale(
                      scale: scale,
                      child: Stack(children: [
                        Positioned(
                          top: game_drag_y,
                          left: game_drag_x,
                          child: Consumer<game_detail_provider>(
                              builder: (context, game_details, child) {
                            int game_scale = game_details.get_data().play_scale;
                            int game_scale_table = game_scale * game_scale;
                            return GestureDetector(
                              onPanUpdate: (details) {
                                drag_buttom_start(details.delta.dx,
                                    details.delta.dy, control_bottom_h);
                                // print(game_drag_x);
                              },
                              onPanEnd: (details) {
                                drag_buttom_stop();
                              },
                              child: Container(
                                height: container_height,
                                width: container_width,
                                child: GridView.count(
                                  crossAxisCount: game_scale, // จำนวนคอลัมน์
                                  children:
                                      List.generate(game_scale_table, (index) {
                                    return GestureDetector(
                                      onTap: () {
                                        game_details.update_data_play(
                                            index, context);
                                      },
                                      child: Container(
                                        // margin: EdgeInsets.all(5),
                                        color: Colors.black,
                                        padding: const EdgeInsets.all(
                                            1.0), // ขนาดขอบ
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(2),
                                          ),
                                          child: LayoutBuilder(
                                              builder: (context, constraints) {
                                            double iconSize =
                                                constraints.maxWidth * 0.8;

                                            return Stack(children: [
                                              Container(
                                                //  padding: EdgeInsets.all(10),
                                                child: Center(
                                                    child: game_details
                                                                    .get_data()
                                                                    .data_table_all[
                                                                index] ==
                                                            1
                                                        ? Text(
                                                            "X",
                                                            style: GoogleFonts
                                                                .sarabun(
                                                              textStyle: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .displayLarge,
                                                              fontSize:
                                                                  iconSize,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color:
                                                                  Colors.black,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .normal,
                                                            ),
                                                          )
                                                        : game_details
                                                                        .get_data()
                                                                        .data_table_all[
                                                                    index] ==
                                                                2
                                                            ? Text(
                                                                "O",
                                                                style:
                                                                    GoogleFonts
                                                                        .sarabun(
                                                                  textStyle: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .displayLarge,
                                                                  fontSize:
                                                                      iconSize,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: Colors
                                                                      .black,
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .normal,
                                                                ),
                                                              )
                                                            : Container()),
                                              ),
                                              Visibility(
                                                  visible: game_details
                                                              .get_winner_table()[
                                                          index] ==
                                                      1,
                                                  child: Container(
                                                    height: double.infinity,
                                                    width: double.infinity,
                                                    color: const Color.fromARGB(
                                                        150, 255, 193, 7),
                                                  )),
                                              Visibility(
                                                  visible: game_details
                                                              .get_winner_table()[
                                                          index] ==
                                                      2,
                                                  child: Container(
                                                    height: double.infinity,
                                                    width: double.infinity,
                                                    color: const Color.fromARGB(
                                                        150, 244, 67, 54),
                                                  )),
                                            ]);
                                          }),
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            );
                          }),
                        ),
                      ]),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Stack(children: [
                Container(
                  child: Column(
                    children: [
                      Expanded(
                          child: Container(
                        child: compli1(),
                      )),
                      Container(
                        child: Container(
                          color: Colors.black,
                          height: 50,
                          //  color: Colors.black38,
                          child: Row(
                            children: [
                              Expanded(child: Container()),
                              GestureDetector(
                                onTap: () {
                                  add_scale();
                                },
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.white,
                                  ),
                                  // margin: EdgeInsets.all(5),
                                  child: LayoutBuilder(
                                      builder: (context, constraints) {
                                    double iconSize = constraints
                                        .maxWidth; // ขนาดไอคอนให้เต็มพื้นที่ของคอนเทนเนอร์

                                    return Container(
                                        margin: EdgeInsets.all(5),
                                        child: Icon(Icons.zoom_in,
                                            size: iconSize));
                                  }),
                                ),
                              ),
                              Expanded(flex: 3, child: Container()),
                              GestureDetector(
                                onTap: () {
                                  reset_position();
                                },
                                child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.white,
                                    ),
                                    child: Center(
                                      child: Icon(Icons.refresh),
                                    )),
                              ),
                              Expanded(flex: 3, child: Container()),
                              GestureDetector(
                                onTap: () {
                                  min_scale();
                                },
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.white,
                                  ),
                                  margin: EdgeInsets.all(5),
                                  child: LayoutBuilder(
                                      builder: (context, constraints) {
                                    double iconSize = constraints
                                        .maxWidth; // ขนาดไอคอนให้เต็มพื้นที่ของคอนเทนเนอร์

                                    return Container(
                                        margin: EdgeInsets.all(5),
                                        child: Icon(Icons.zoom_out,
                                            size: iconSize));
                                  }),
                                ),
                              ),
                              Expanded(child: Container()),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                          child: Container(
                        child: compli2(),
                      )),
                    ],
                  ),
                ),
                Visibility(
                    visible: game_details.get_data().state_game == 2,
                    child: Column(
                      children: [
                        Expanded(flex: 14, child: Container()),
                        Expanded(
                            flex: 17,
                            child: Container(
                              color: Colors.white,
                              child: Column(
                                children: [
                                  Expanded(
                                      child: Container(
                                    margin: EdgeInsets.all(5),
                                    child: Center(
                                      child: Text(
                                        game_details.get_data().who_win ==
                                                "DRAW"
                                            ? "DRAW"
                                            : game_details.get_data().who_win +
                                                " Won",
                                        style: GoogleFonts.sarabun(
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .displayLarge,
                                          fontSize: 34,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                          fontStyle: FontStyle.normal,
                                        ),
                                      ),
                                    ),
                                  )),
                                  Expanded(
                                      child: GestureDetector(
                                    onTap: () async {
                                      final his_game_provider his_games =
                                          Provider.of<his_game_provider>(
                                              context,
                                              listen: false);

                                      await his_games
                                          .save_data(game_details.get_data());
                                      await game_details.refesh_game(context);

                                      await page_states.update_state(2);
                                    },
                                    child: Container(
                                      margin: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.green,
                                      ),
                                      child: Center(
                                          child: Text(
                                        "NEXT",
                                        style: GoogleFonts.sarabun(
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .displayLarge,
                                          fontSize: 28,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                          fontStyle: FontStyle.normal,
                                        ),
                                      )),
                                    ),
                                  ))
                                ],
                              ),
                            )),
                        Expanded(flex: 14, child: Container()),
                      ],
                    ))
              ]),
            ),
          ]),
        ),
        Consumer<game_detail_provider>(builder: (context, game_details, child) {
          return Visibility(
            visible: game_details.get_data().state_game == 0,
            child: BackdropFilter(
              filter: ImageFilter.blur(
                  sigmaX: 6.0,
                  sigmaY: 5.0), // ค่าของ sigmaX และ sigmaY กำหนดความแรงของ blur

              child: Container(
                height: double.infinity,
                width: double.infinity,
                color: Colors.black38,
              ),
            ),
          );
        }),
        Positioned(
            top: screen_height * 0.1,
            right: screen_width * 0.25,
            child: Consumer<game_detail_provider>(
                builder: (context, game_details, child) {
              return Visibility(
                  visible: game_details.get_data().state_game == 0,
                  child: main_Setting());
            }))
      ]);
    });
  }
}
