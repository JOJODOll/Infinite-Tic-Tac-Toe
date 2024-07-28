import 'dart:async';
import 'dart:convert';

import 'package:digio_xo_test/A_SQL/sqlite.dart';
import 'package:digio_xo_test/A_model/state_game.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class his_game_provider with ChangeNotifier {
  game_detail monitor = game_detail(
      state_game: 0,
      Start_time_unix: 0,
      end_time_unix: 0,
      play_scale: 3,
      win_by: 2, //+1
      enemy: "bot",
      who_start: "player1",
      who_now: 1,
      data_table_all: [
        {"data_table_all": 0},
        {"data_table_all": 0},
        {"data_table_all": 0},
        {"data_table_all": 0},
        {"data_table_all": 0},
        {"data_table_all": 0},
        {"data_table_all": 0},
        {"data_table_all": 0},
        {"data_table_all": 0},
        {"data_table_all": 0},
      ],
      Who1: [], // หาร2 ลง
      Who2: [],
      who_win: "",
      now_turn: 0,
      end_turn: 0,
      winner_table: [
        {"winner_table": 0},
        {"winner_table": 0},
        {"winner_table": 0},
        {"winner_table": 0},
        {"winner_table": 0},
        {"winner_table": 0},
        {"winner_table": 0},
        {"winner_table": 0},
        {"winner_table": 0},
        {"winner_table": 0},
      ]);

  List<game_detail> data_his = [];
  int monitor_index = -1;

  int INDEX_MONITOR() {
    return monitor_index;
  }

  void update_index_monitor(int data) {
    monitor_index = data;
    notifyListeners();
  }

  Future<void> clear_monitor() async {
    monitor = game_detail(
        state_game: 0,
        Start_time_unix: 0,
        end_time_unix: 0,
        play_scale: 3,
        win_by: 2, //+1
        enemy: "bot",
        who_start: "player1",
        who_now: 1,
        data_table_all: [
          {"data_table_all": 0},
          {"data_table_all": 0},
          {"data_table_all": 0},
          {"data_table_all": 0},
          {"data_table_all": 0},
          {"data_table_all": 0},
          {"data_table_all": 0},
          {"data_table_all": 0},
          {"data_table_all": 0},
        ],
        Who1: [], // หาร2 ลง
        Who2: [],
        who_win: "",
        now_turn: 0,
        end_turn: 0,
        winner_table: [
          {"winner_table": 0},
          {"winner_table": 0},
          {"winner_table": 0},
          {"winner_table": 0},
          {"winner_table": 0},
          {"winner_table": 0},
          {"winner_table": 0},
          {"winner_table": 0},
          {"winner_table": 0},
        ]);
    notifyListeners();
  }

  Future<void> add_data(game_detail data) async {
    data_his.add(data);
    notifyListeners();
  }

  game_detail get_data_monitor() {
    return monitor;
  }

  List<game_detail> get_data() {
    return data_his;
  }

  Future<void> clear_his() async {
    data_his.clear();
    notifyListeners();
  }

  int index1 = 0;
  int index2 = 0;

  void update_his_game_monitor(int index) {
    update_index_monitor(index);
    monitor = data_his[index];
    notifyListeners();
  }

  void stop() {}

  Future<void> save_data(game_detail data) async {
    int unixTimestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    final localDatabase = LocalDatabase();

    int end_time_unix = unixTimestamp;
    int play_scale = data.play_scale;
    int win_by = data.win_by;
    int end_turn = data.now_turn;

    String enemy = data.enemy;
    String Who_win = data.who_win;
    List<Map<String, dynamic>> his_data_table_all = [];
    List<Map<String, dynamic>> his_Who1 = [];
    List<Map<String, dynamic>> his_Who2 = [];
    List<Map<String, dynamic>> his_winner_table = [];

    for (int i = 0; i < data.data_table_all.length; i++) {
      Map<String, dynamic> detailMap = {
        'data_table_all': data.data_table_all[i],
      };
      his_data_table_all.add(detailMap);
    }
    for (int i = 0; i < data.Who1.length; i++) {
      Map<String, dynamic> detailMap = {
        'Who1': data.Who1[i],
      };
      his_Who1.add(detailMap);
    }
    for (int i = 0; i < data.Who2.length; i++) {
      Map<String, dynamic> detailMap = {
        'Who2': data.Who2[i],
      };
      his_Who2.add(detailMap);
    }
    for (int i = 0; i < data.winner_table.length; i++) {
      Map<String, dynamic> detailMap = {
        'winner_table': data.winner_table[i],
      };
      his_winner_table.add(detailMap);
    }

    await localDatabase.insert_his_game(
        end_time_unix: end_time_unix,
        play_scale: play_scale,
        win_by: win_by,
        enemy: enemy,
        data_table_all: jsonEncode(his_data_table_all),
        Who1: jsonEncode(his_Who1),
        Who2: jsonEncode(his_Who2),
        Who_win: Who_win,
        winner_table: jsonEncode(his_winner_table),
        end_turn: end_turn);

    // print(end_time_unix);
    // print(play_scale);
    // print(win_by);
    // print(enemy);
    // print(end_turn);

    /* print(jsonEncode(his_data_table_all));
    print("////////");
    print(jsonEncode(his_Who1));
    print("////////");

    print(jsonEncode(his_Who2));
    print("////////");

    print(jsonEncode(his_winner_table));
    print("////////");*/
  }

  Future<void> reset_date() async {
    monitor_index = -1;
    await clear_monitor();

    await clear_his();
    List<Map<String, dynamic>> his_game = [];

    final localDatabase = LocalDatabase();

    his_game = await localDatabase.getAll_his();

    // print(his_game);

    for (Map<String, dynamic> data in his_game) {
      int end_time_unix = data['end_time_unix'];
      //  print(end_time_unix);

      int play_scale = data['play_scale'];
      // print(play_scale);

      int win_by = data['win_by'];
      // print(win_by);

      String enemy = data['enemy'] ?? '';
      // print(enemy);

      int end_turn = data['end_turn'];
      //  print(end_turn);

      String Who_win = data['Who_win'];

      List<Map<String, dynamic>> data_table_all =
          (jsonDecode(data['data_table_all']) as List)
              .cast<Map<String, dynamic>>();
      List<Map<String, dynamic>> Who1 =
          (jsonDecode(data['Who1']) as List).cast<Map<String, dynamic>>();
      List<Map<String, dynamic>> Who2 =
          (jsonDecode(data['Who2']) as List).cast<Map<String, dynamic>>();
      List<Map<String, dynamic>> winner_table =
          (jsonDecode(data['winner_table']) as List)
              .cast<Map<String, dynamic>>();

      // print(Who_win);

      game_detail DATA = game_detail(
          state_game: 0,
          Start_time_unix: 0,
          end_time_unix: end_time_unix,
          play_scale: play_scale,
          win_by: win_by,
          enemy: enemy,
          who_start: "",
          who_now: 0,
          data_table_all: data_table_all,
          Who1: Who1,
          Who2: Who2,
          who_win: Who_win,
          now_turn: 0,
          end_turn: end_turn,
          winner_table: winner_table);

      await add_data(DATA);
    }
    sortDataHisByUnix(data_his);
  }

  void sortDataHisByUnix(List<game_detail> dataHis) {
    dataHis.sort((a, b) => b.end_time_unix.compareTo(a.end_time_unix));
    notifyListeners();
  }

  Future<void> Delect_all(context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: Container(
              height: 100,
              width: 200,
              color: Colors.white,
              child: Center(
                child: GestureDetector(
                  onTap: () async {
                    final localDatabase = LocalDatabase();

                    await localDatabase.deleteAllHis();
                    await reset_date();
                    Navigator.of(context).pop(false);

                    notifyListeners();
                  },
                  child: Container(
                    color: Colors.green,
                    height: 50,
                    width: 120,
                    child: Center(
                      child: Text(
                        "ยืนยัน",
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
                ),
              ),
            ),
          );
        });
  }
}
