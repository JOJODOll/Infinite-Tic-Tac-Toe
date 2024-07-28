import 'package:digio_xo_test/A_model/page_state.dart';
import 'package:flutter/material.dart';

class page_state_provider with ChangeNotifier {
  List<page_state> page_states = [page_state(state: 0)];

  List<page_state> get_all() {
    return page_states;
  }

  Future<void> update_state(int data) async {
    page_states[0].state = data;
    notifyListeners();
  }
}

class scanner_state_provider with ChangeNotifier {
  List<scanner_state> scanner_states = [scanner_state(state: 0)];

  List<scanner_state> get_all() {
    return scanner_states;
  }

  void update_state(int data) {
    scanner_states[0].state = data;
    notifyListeners();
  }
}
