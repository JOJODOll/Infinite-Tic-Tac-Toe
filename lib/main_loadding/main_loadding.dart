import 'package:digio_xo_test/A_provider/page_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class main_loadding extends StatefulWidget {
  const main_loadding({super.key});

  @override
  State<main_loadding> createState() => _main_loaddingState();
}

class _main_loaddingState extends State<main_loadding> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () async {
      final page_state_provider page_states =
          Provider.of<page_state_provider>(context, listen: false);
      // await prepare_data();
      await page_states.update_state(1);
    });
  }

  // Future<void> prepare_data() async {}
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Text(
          "Infinite TIC TAC TOE",
          style: GoogleFonts.sarabun(
            textStyle: Theme.of(context).textTheme.displayLarge,
            fontSize: 34,
            fontWeight: FontWeight.w800,
            color: Colors.black,
            fontStyle: FontStyle.normal,
          ),
        ),
      ),
    );
  }
}
