import 'package:digio_xo_test/A_provider/page_state_provider.dart';
import 'package:digio_xo_test/main_history/main_history.dart';
import 'package:digio_xo_test/main_loadding/main_loadding.dart';
import 'package:digio_xo_test/start_game/main_start.dart';
import 'package:digio_xo_test/start_page/start_page.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class page_manage extends StatefulWidget {
  const page_manage({super.key});

  @override
  State<page_manage> createState() => _page_manageState();
}

class _page_manageState extends State<page_manage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> page = [
      main_loadding(),
      start_page(),
      main_start(),
      main_history(),
    ];
    return Container(
      child:
          Consumer<page_state_provider>(builder: (context, page_states, child) {
        return Container(
          alignment: AlignmentDirectional.center,
          child: Container(
            child: Consumer<page_state_provider>(
              builder: (context, pageStates, child) {
                int selectedTabIndex = page_states.get_all()[0].state;

                return page[selectedTabIndex];
              },
            ),
          ),
        );
      }),
    );
  }
}
