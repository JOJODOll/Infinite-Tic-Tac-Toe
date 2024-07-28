import 'dart:async';

import 'package:digio_xo_test/A_provider/check_winner-provider.dart';
import 'package:digio_xo_test/A_provider/game_detail.provider.dart';
import 'package:digio_xo_test/A_provider/his_game_provider.dart';
import 'package:digio_xo_test/A_provider/page_state_provider.dart';
import 'package:digio_xo_test/A_provider/system_provider.dart';
import 'package:digio_xo_test/pagemanage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => page_state_provider()),
        ChangeNotifierProvider(create: (_) => system_provider()),
        ChangeNotifierProvider(create: (_) => game_detail_provider()),
        ChangeNotifierProvider(create: (_) => check_winner_provider()),
        ChangeNotifierProvider(create: (_) => his_game_provider()),
      ],
      child: MaterialApp(
        home: HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int out = 0;
  bool state_out = false;
  Timer? timer;

  void OUT() {
    if (out == 0 && !state_out) {
      timer?.cancel(); // Cancel any existing timer
      out++;
      timer = Timer(Duration(milliseconds: 500), () {
        out = 0;
        timer?.cancel(); // Cancel any existing timer
      });
    } else {
      out++;
      if (out >= 2) {
        out = 0;

        // SystemNavigator.pop(); // Exit the app
        timer?.cancel(); // Cancel any existing timer
        _showDialog(context);
      }
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        OUT();
      },
      child: Scaffold(
        body: Container(
          child: Consumer<system_provider>(
            builder: (context, systems, child) {
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: page_manage(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('ออกจากโปรแกรม'),
          // content: Text('Do you really want to exit the app?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('ไม่'),
            ),
            TextButton(
              onPressed: () {
                SystemNavigator.pop();
                SystemNavigator.pop(); // Exit the app
              },
              child: Text('ใช่'),
            ),
          ],
        );
      },
    );
  }
}
