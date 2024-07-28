import 'dart:math';

import 'package:digio_xo_test/A_model/state_game.dart';
import 'package:digio_xo_test/A_provider/check_winner-provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class game_detail_provider with ChangeNotifier {
  game_detail game_data = game_detail(
      state_game: 0,
      Start_time_unix: 0,
      end_time_unix: 0,
      play_scale: 3,
      win_by: 2, //+1
      enemy: "bot",
      who_start: "player1",
      who_now: 1,
      data_table_all: [0, 0, 0, 0, 0, 0, 0, 0, 0],
      Who1: [], // หาร2 ลง
      Who2: [],
      who_win: "",
      now_turn: 0,
      end_turn: 0,
      winner_table: [0, 0, 0, 0, 0, 0, 0, 0, 0]);

  List<dynamic> get_winner_table() {
    return game_data.winner_table;
  }

  void update_winner_tabel(List<int> data, int who) {
    for (int i = 0; i < data.length; i++) {
      game_data.winner_table[data[i]] = who == 1
          ? 1
          : who == 2
              ? 2
              : 0;
      notifyListeners();
    }
  }

  int get_border() {
    return game_data.win_by;
  }

  game_detail get_data() {
    return game_data;
  }

  void update_enemy_bot() {
    game_data.enemy = "bot";

    notifyListeners();
  }

  void update_enemy_player2() {
    game_data.enemy = "player2";

    notifyListeners();
  }

  Future<void> start_game(context, String data, String win_by) async {
    //print(data);
    List<String> scale = data.split('x');
    //print(scale[0]);

    int size_scale = int.parse(scale[0]);
    //  print(size_scale);

    List<int> zerosList = List.filled(size_scale * size_scale, 0);
    game_data.data_table_all.clear();
    game_data.winner_table.clear();
    game_data.Who1.clear();
    game_data.Who2.clear();

    game_data.data_table_all.addAll(zerosList);
    game_data.winner_table.addAll(zerosList);

    game_data.play_scale = size_scale;
    game_data.now_turn = 0;
    WHO_NOW(1);

    update_state(1);
    game_data.win_by = int.parse(win_by) - 1;
/*
    int randomNumber = Random().nextInt(2) + 1;
    if (randomNumber == 1) {
      game_data.who_now = 1;
    } else if (randomNumber == 2) {
      if (game_data.enemy == "bot") {
        game_data.who_now = 1;
      } else if (game_data.enemy == "player2") {
        game_data.who_now = 2;
      }
    }*/

    //สุ่ม who_now
    //
    notifyListeners();
  }

  Future<void> update_state(int state) async {
    game_data.state_game = state;

    notifyListeners();
  }

  Future<void> update_data_play(int index, context) async {
    if (game_data.state_game == 1) {
      if (game_data.data_table_all[index] == 0) {
        if (game_data.who_now == 1) {
          game_data.data_table_all[index] = 1;
          game_data.Who1.add(index);

          await check_winner(index, context);
          WHO_NOW(2);
          game_data.now_turn++;
          //  print(game_data.now_turn);

          notifyListeners();
          if (game_data.now_turn < game_data.data_table_all.length) {
            if (game_data.state_game == 1) {
              if (game_data.enemy == "bot") {
                int BOT_index = await BOT();

                game_data.data_table_all[BOT_index] = 2;
                game_data.Who2.add(BOT_index);

                await check_winner(BOT_index, context);
                WHO_NOW(1);
                game_data.now_turn++;
                //      print(game_data.now_turn);

                notifyListeners();
              }
            }
          }
        } else if (game_data.who_now == 2 && game_data.enemy == "player2") {
          game_data.data_table_all[index] = 2;
          game_data.Who2.add(index);

          await check_winner(index, context);

          WHO_NOW(1);
          game_data.now_turn++;
          // print(game_data.now_turn);

          notifyListeners();
        } else if (game_data.enemy == "bot" && game_data.who_now == 2) {
          int BOT_index = await BOT();

          game_data.data_table_all[BOT_index] = 2;
          game_data.Who2.add(BOT_index);

          await check_winner(index, context);

          WHO_NOW(1);
          game_data.now_turn++;
          // print(game_data.now_turn);

          notifyListeners();
        }
      }
    }

    if (game_data.state_game == 2) {
      WHO_NOW(0);
    }

    notifyListeners();

    if (game_data.now_turn == game_data.data_table_all.length &&
        game_data.state_game == 1) {
      update_winner("DRAW");
      game_data.state_game = 2;
      WHO_NOW(0);

      notifyListeners();
    }
  }

  Future<void> WHO_NOW(int data) async {
    game_data.who_now = data;

    notifyListeners();
  }

  Future<int> BOT() async {
    List<int> zeroIndexes = [];
    await Future.delayed(Duration(milliseconds: 100));

    for (int i = 0; i < game_data.data_table_all.length; i++) {
      if (game_data.data_table_all[i] == 0) {
        zeroIndexes.add(i);
      }
    }
    int randomIndex = Random().nextInt(zeroIndexes.length);
    int selectedIndex = zeroIndexes[randomIndex];

    return selectedIndex;
  }

  Future<void> check_winner(int index, context) async {
    final check_winner_provider check_winners =
        Provider.of<check_winner_provider>(context, listen: false);

    await check_winners.update_date(index, context);
  }

  Future<void> refesh_game(context) async {
    final check_winner_provider check_winners =
        Provider.of<check_winner_provider>(context, listen: false);

    List<int> zerosList =
        List.filled(game_data.play_scale * game_data.play_scale, 0);
    game_data.data_table_all.clear();
    game_data.winner_table.clear();
    game_data.data_table_all.addAll(zerosList);
    game_data.winner_table.addAll(zerosList);
    update_state(0);

    await check_winners.start(context);

    notifyListeners();
  }

  Future<void> update_winner(String data) async {
    game_data.who_win = data;

    notifyListeners();
  }
}
