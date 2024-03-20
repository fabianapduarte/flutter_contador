import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

const int increment = 1;
const int decrement = -1;
const int totalTables = 20;

void main() {
  runApp(MaterialApp(title: 'Contador', home: _Home()));
}

class _Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<_Home> {
  int _occupiedTables = 0;

  void handleTotalTable(int number) {
    setState(() {
      _occupiedTables += number;

      if (_occupiedTables >= 20) {
        _occupiedTables = 20;
      } else if (_occupiedTables < 0) {
        _occupiedTables = 0;
      }
    });
  }

  OutlinedButton getButton(String textButton, int number, bool isDisabled) {
    return OutlinedButton(
      style: ButtonStyle(
          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
          padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 10, horizontal: 30)),
          side: MaterialStateProperty.all(BorderSide(
              color: isDisabled ? Colors.deepPurple.shade200 : Colors.deepPurple.shade700,
              width: 1.0,
              style: BorderStyle.solid))),
      onPressed: isDisabled
          ? null
          : () {
              handleTotalTable(number);
            },
      child: Text(
        textButton,
        style: GoogleFonts.inter(
            textStyle: TextStyle(
                color: isDisabled ? Colors.deepPurple.shade200 : Colors.deepPurple.shade700,
                fontWeight: FontWeight.w400,
                fontSize: 16.0,
                decoration: TextDecoration.none)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int availableTables = totalTables - _occupiedTables;

    return Stack(
      children: <Widget>[
        Container(
          color: Colors.grey.shade200,
          height: 1000.0,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 20.0),
                  child: SvgPicture.asset(
                    "assets/event.svg",
                    semanticsLabel: "Illustration",
                    height: 200.0,
                    width: 200.0,
                    fit: BoxFit.cover,
                  ),
                ),
                Text(
                  "$availableTables",
                  style: GoogleFonts.inter(
                      textStyle: TextStyle(
                          color: Colors.deepPurple.shade700,
                          fontWeight: FontWeight.w900,
                          fontSize: 54.0,
                          decoration: TextDecoration.none)),
                ),
                Text(
                  "mesas disponíveis",
                  style: GoogleFonts.inter(
                      textStyle: const TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                          fontSize: 24.0,
                          decoration: TextDecoration.none)),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 50.0),
                    child: getButton("Entrar", increment, availableTables == 0)),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 50.0),
                    child: getButton("Sair", decrement, availableTables == 20))
              ],
            ),
          ],
        )
      ],
    );
  }
}
