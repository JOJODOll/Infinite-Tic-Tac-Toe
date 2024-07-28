import 'dart:math';

import 'package:digio_xo_test/A_provider/game_detail.provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vector_math/vector_math.dart';

class check_winner_provider with ChangeNotifier {
  List<List<Vector2>> player1 = [];
  List<List<Vector2>> player2 = [];

  Future<void> start(context) async {
    final game_detail_provider game_details =
        Provider.of<game_detail_provider>(context, listen: false);

    player1 = _createVector(
        game_details.get_data().data_table_all, game_details.get_border());
    player2 = _createVector(
        game_details.get_data().data_table_all, game_details.get_border());
    /*  print("player1");

    for (var row in player1) {
      print(row.map((v) => v.x.toInt().toString()).toList());
    }
    print("player2");
    for (var row in player2) {
      print(row.map((v) => v.x.toInt().toString()).toList());
    }*/

    notifyListeners();
  }

  Future<void> update_date(int index, context) async {
    final game_detail_provider game_details =
        Provider.of<game_detail_provider>(context, listen: false);

    List<int> INDEX_V = findVectorIndex(index,
        game_details.get_data().data_table_all, game_details.get_border());

    if (game_details.get_data().who_now == 1) {
      player1[INDEX_V[0]][INDEX_V[1]] = Vector2(1, 0.0);
      /* for (var row in player1) {
        print(row.map((v) => v.x.toInt().toString()).toList());
      }*/

      await winner_cheack(INDEX_V[0], INDEX_V[1], 1, context);
    }

    if (game_details.get_data().who_now == 2) {
      player2[INDEX_V[0]][INDEX_V[1]] = Vector2(2, 0.0);

      await winner_cheack(INDEX_V[0], INDEX_V[1], 2, context);
    }

    notifyListeners();
  }

  Future<void> winner_cheack(int r, int c, int who, context) async {
    bool state = true;
    // print(r);
    //print(c);

    final game_detail_provider game_details =
        Provider.of<game_detail_provider>(context, listen: false);

    List<int> index_win = [];

    if (who == 1) {
      List<List<Vector2>> buff = [];
      for (int i = 0; i <= game_details.get_border(); i++) {
        // สร้างลิสต์ Vector2 สำหรับแต่ละแถว
        List<Vector2> row = List.generate(
          game_details.get_border() + 1, // ขนาดของแต่ละแถว
          (_) => Vector2(1.0, 1.0), // ค่าเริ่มต้นเป็น Vector2(1.0, 1.0)
        );

        // เพิ่มแถวลงใน buff
        buff.add(row);
      }

      for (int i = 0; i <= game_details.get_border(); i++,) {
        state = true;
        for (int j = 0; j <= game_details.get_border(); j++) {
          if (player1[r][c - j + i][0] != buff[1][j][0]) {
            state = false;
          }
          ;
        }
        ;
        if (state) {
          //  print("แนว นอน");
          // find_index_winner(context, r, c, i, 1, WHOS);

          for (int j = 0; j <= game_details.get_border(); j++) {
            // print(game_details.get_data().play_scale);
            // print(c - j + i);
            int y = r - (game_details.get_border() - 1);
            int x = c - j + i - (game_details.get_border() - 1);
            //  print(x);
            // print(y);

            index_win
                .add((y - 1) * (game_details.get_data().play_scale) + (x - 1));
          }

          winner_function(context, index_win, who);
        }
      }
      for (int i = 0; i <= game_details.get_border(); i++,) {
        state = true;
        for (int j = 0; j <= game_details.get_border(); j++,) {
          if (player1[r - j + i][c][0] != buff[1][j][0]) {
            state = false;
          }
          ;
        }
        ;
        if (state) {
          //   print("แนว ตั้ง");

          for (int j = 0; j <= game_details.get_border(); j++) {
            // print(game_details.get_data().play_scale);
            // print(c - j + i);
            int y = r - j + i - (game_details.get_border() - 1);
            int x = c - (game_details.get_border() - 1);

            index_win
                .add((y - 1) * (game_details.get_data().play_scale) + (x - 1));
          }

          winner_function(context, index_win, who);
        }
      }
      for (int i = 0; i <= game_details.get_border(); i++,) {
        state = true;
        for (int j = 0; j <= game_details.get_border(); j++,) {
          if (player1[r - j + i][c - j + i][0] != buff[1][j][0]) {
            state = false;
          }
          ;
        }
        ;
        if (state) {
          //   print("ทะแยงลบ");
          for (int j = 0; j <= game_details.get_border(); j++) {
            // print(game_details.get_data().play_scale);
            // print(c - j + i);

            int y = r - j + i - (game_details.get_border() - 1);
            int x = c - j + i - (game_details.get_border() - 1);

            index_win
                .add((y - 1) * (game_details.get_data().play_scale) + (x - 1));
          }

          winner_function(context, index_win, who);
        }
      }
      for (int i = 0; i <= game_details.get_border(); i++,) {
        state = true;
        //int index_j = 0;
        for (int j = 0; j <= game_details.get_border(); j++,) {
          if (player1[r + j - i][c - j + i][0] != buff[1][j][0]) {
            state = false;
          }
          ;
        }
        ;
        if (state) {
          //  print("ทะแยงบวก");
          //find_index_winner(context, r, c, i, 4, WHOS);

          for (int j = 0; j <= game_details.get_border(); j++) {
            // print(game_details.get_data().play_scale);
            // print(c - j + i);

            int y = r + j - i - (game_details.get_border() - 1);
            int x = c - j + i - (game_details.get_border() - 1);

            index_win
                .add((y - 1) * (game_details.get_data().play_scale) + (x - 1));
          }

          winner_function(context, index_win, who);
        }
      }
    }
    if (who == 2) {
      List<List<Vector2>> buff = [];
      for (int i = 0; i <= game_details.get_border(); i++) {
        // สร้างลิสต์ Vector2 สำหรับแต่ละแถว
        List<Vector2> row = List.generate(
          game_details.get_border() + 1, // ขนาดของแต่ละแถว
          (_) => Vector2(2.0, 2.0), // ค่าเริ่มต้นเป็น Vector2(1.0, 1.0)
        );

        // เพิ่มแถวลงใน buff
        buff.add(row);
      }

      for (int i = 0; i <= game_details.get_border(); i++,) {
        state = true;
        for (int j = 0; j <= game_details.get_border(); j++) {
          if (player2[r][c - j + i][0] != buff[1][j][0]) {
            state = false;
          }
          ;
        }
        ;
        if (state) {
          //  print("แนว นอน");
          // find_index_winner(context, r, c, i, 1, WHOS);

          for (int j = 0; j <= game_details.get_border(); j++) {
            // print(game_details.get_data().play_scale);
            // print(c - j + i);
            int y = r - (game_details.get_border() - 1);
            int x = c - j + i - (game_details.get_border() - 1);

            index_win
                .add((y - 1) * (game_details.get_data().play_scale) + (x - 1));
          }

          winner_function(context, index_win, who);
        }
      }
      for (int i = 0; i <= game_details.get_border(); i++,) {
        state = true;
        for (int j = 0; j <= game_details.get_border(); j++,) {
          if (player2[r - j + i][c][0] != buff[1][j][0]) {
            state = false;
          }
          ;
        }
        ;
        if (state) {
          ////// print("แนว ตั้ง");

          for (int j = 0; j <= game_details.get_border(); j++) {
            // print(game_details.get_data().play_scale);
            // print(c - j + i);
            int y = r - j + i - (game_details.get_border() - 1);
            int x = c - (game_details.get_border() - 1);

            index_win
                .add((y - 1) * (game_details.get_data().play_scale) + (x - 1));
          }

          winner_function(context, index_win, who);
        }
      }
      for (int i = 0; i <= game_details.get_border(); i++,) {
        state = true;
        for (int j = 0; j <= game_details.get_border(); j++,) {
          if (player2[r - j + i][c - j + i][0] != buff[1][j][0]) {
            state = false;
          }
          ;
        }
        ;
        if (state) {
          ////// print("ทะแยงลบ");
          for (int j = 0; j <= game_details.get_border(); j++) {
            // print(game_details.get_data().play_scale);
            // print(c - j + i);

            int y = r - j + i - (game_details.get_border() - 1);
            int x = c - j + i - (game_details.get_border() - 1);

            index_win
                .add((y - 1) * (game_details.get_data().play_scale) + (x - 1));
          }

          winner_function(context, index_win, who);
        }
      }
      for (int i = 0; i <= game_details.get_border(); i++,) {
        state = true;
        //int index_j = 0;
        for (int j = 0; j <= game_details.get_border(); j++,) {
          if (player2[r + j - i][c - j + i][0] != buff[1][j][0]) {
            state = false;
          }
          ;
        }
        ;
        if (state) {
          /////   print("ทะแยงบวก");
          //find_index_winner(context, r, c, i, 4, WHOS);

          for (int j = 0; j <= game_details.get_border(); j++) {
            // print(game_details.get_data().play_scale);
            // print(c - j + i);

            int y = r + j - i - (game_details.get_border() - 1);
            int x = c - j + i - (game_details.get_border() - 1);

            index_win
                .add((y - 1) * (game_details.get_data().play_scale) + (x - 1));
          }

          winner_function(context, index_win, who);
        }
      }
    }
  }

  void winner_function(context, List<int> index, who) {
    final game_detail_provider game_details =
        Provider.of<game_detail_provider>(context, listen: false);
    if (game_details.get_data().state_game == 1) {
      game_details.update_winner_tabel(index, who);
      // print(index);

      if (who == 1) {
        game_details.update_winner("player1");
      } else if (who == 2) {
        game_details.update_winner(game_details.get_data().enemy);
      } else {
        game_details.update_winner("NON ??");
      }

      game_details.update_state(2);
    }

    ///// print("who win" + who.toString());
  }

/*
  void find_index_winner(
      context, int r, int c, int i, int CASE, int who) async {
    final game_detail_provider game_details =
        Provider.of<game_detail_provider>(context, listen: false);

    int border = game_details.get_border();
    int scale = game_details.get_data().play_scale;
    if (CASE == 1) {
      // print(r - border + 1 + i);
      // print(c - (2 * border) + 1 + i);
      int C = 1;
      int x = r - border + i + 1;
      int y = c - (2 * border) + 1 + i;

      // print(i);
      List_index_to_update_winner(context, x, y, C, who);
    } else if (CASE == 2) {
      int C = 2;

      /*print(r - (2 * border) + 1);
      print(c - border + 1 + i);*/

      int x = r - (2 * border) + 1 + i;
      int y = c - border + 1 + i;
      // print(i);
      List_index_to_update_winner(context, x, y, C, who);
    } else if (CASE == 3) {
      int C = 3;
      // print(r - (2 * border) + i + 1);
      // print(c - (2 * border) + i + 1);

      int x = r - (2 * border) + 1 + i;
      int y = c - (2 * border) + 1 + i;

      // print(i);
      List_index_to_update_winner(context, x, y, C, who);
    } else if (CASE == 4) {
      int C = 4;

      // print(r + (2 * border) - i - scale + 1); //y
      //print(c + 1); //x

      int x = c + 1;
      int y = r + (2 * border) - i - scale + 1;
      //  print(i);
      List_index_to_update_winner(context, x, y, C, who);
    }
  }*/

  void List_index_to_update_winner(context, List<int> index, who) {}

/*
  Future<void> List_index_to_update_winner(
      context, int x, int y, int CASE, int who) async {
    final game_detail_provider game_details =
        Provider.of<game_detail_provider>(context, listen: false);

    List<int> Listindex = [];
    int winner_point = game_details.get_border() + 1;
    int scale = game_details.get_data().play_scale;
    int start = (x - 1) * scale + (y - 1);
    print(x);
    print(y);
    if (CASE == 1) {
      print("case1");

      for (int i = 0; i < winner_point; i++) {
        Listindex.add(start);
        start++;
      }
    } else if (CASE == 2) {
      print("case2");

      for (int i = 0; i < winner_point; i++) {
        Listindex.add(start);
        start += scale;
      }
    } else if (CASE == 3) {
      print("case3");

      for (int i = 0; i < winner_point; i++) {
        Listindex.add(start);
        start += scale + 1;
      }
    } else if (CASE == 4) {
      print("case4");
      //int start2 = (y - 1) * scale + (x - 1);

      for (int i = 0; i < winner_point; i++) {
        Listindex.add(start);
        start += scale - 1;
      }
    }
    print(Listindex);
  }*/

  List<List<Vector2>> _createVector(List<dynamic> data, int borderSize) {
    // ตรวจสอบว่าขนาดของ borderSize ถูกต้อง

    // คำนวณขนาดของเวกเตอร์
    int n = sqrt(data.length).ceil();

    // สร้างเวกเตอร์ที่เต็มไปด้วยค่า Vector2.zero()
    List<List<Vector2>> vector = List.generate(
      n + 2 * borderSize,
      (_) => List.generate(n + 2 * borderSize, (_) => Vector2.zero()),
    );

    // เติมข้อมูลจาก data ลงในเวกเตอร์
    int index = 0;
    for (int i = borderSize; i < n + borderSize; i++) {
      for (int j = borderSize; j < n + borderSize; j++) {
        if (index < data.length) {
          vector[i][j] = Vector2(data[index].toDouble(), 0.0);
          index++;
        } else {
          break;
        }
      }
    }

    return vector;
  }

  List<int> findVectorIndex(int index, List<dynamic> numbers, int borderSize) {
    // คำนวณขนาดของเวกเตอร์
    int n = sqrt(numbers.length).ceil();

    // คำนวณตำแหน่งในเวกเตอร์
    int row = index ~/ n; // แถว
    int col = index % n; // คอลัมน์

    // คำนวณตำแหน่งในเวกเตอร์ที่มีขอบ
    int newRow = row + borderSize;
    int newCol = col + borderSize;

    return [newRow, newCol];
  }
}
