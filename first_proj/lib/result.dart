import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int resultScore;
  final Function resetHandler;

  Result(this.resultScore, this.resetHandler);

  String get resultPhrase {
    String resultText;
    if (resultScore <= 8) {
      resultText = 'You are cool';
    } else if (resultScore <= 12) {
      resultText = 'you are awasome';
    } else if (resultScore <= 16) {
      resultText = 'you are just fine';
    } else {
      resultText = 'you are yeh bhi thik hai';
    }
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Text(
            resultPhrase,
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          FlatButton(
            onPressed: resetHandler,
            child: Text('Reset Quiz!'),
            textColor: Colors.blue,
          )
        ],
      ),
    );
  }
}
