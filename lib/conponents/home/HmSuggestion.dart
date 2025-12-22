import 'package:flutter/material.dart';

class HmSuggestion extends StatefulWidget {
  HmSuggestion({Key? key}) : super(key: key);

  @override
  _HmSuggestionState createState() => _HmSuggestionState();
}

class _HmSuggestionState extends State<HmSuggestion> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        // padding: EdgeInsets.symmetric(horizontal: 10),
        color: Colors.blue,
        alignment: Alignment.center,
        height: 300,
        child: Text("推荐", style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
