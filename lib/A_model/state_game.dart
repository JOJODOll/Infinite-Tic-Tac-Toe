class state_game {
  int state = 0;
  state_game({required this.state});
}

class his_state_game {
  int state = 0;
  his_state_game({required this.state});
}

class game_detail {
  int state_game;
  int Start_time_unix = 0;
  int end_time_unix = 0;
  int play_scale = 0;
  int win_by = 0;
  String enemy = "";
  String who_start = "";
  int who_now = 0;
  List<dynamic> data_table_all = [];

  List<dynamic> Who1 = [];
  List<dynamic> Who2 = [];
  String who_win = "";

  int now_turn = 0;

  int end_turn = 0;

  List<dynamic> winner_table = [];

  game_detail({
    required this.state_game,
    required this.Start_time_unix,
    required this.end_time_unix,
    required this.play_scale,
    required this.win_by,
    required this.enemy,
    required this.who_start,
    required this.who_now,
    required this.data_table_all,
    required this.Who1,
    required this.Who2,
    required this.who_win,
    required this.now_turn,
    required this.end_turn,
    required this.winner_table,
  });
}
