import 'package:flutter/material.dart';

class ResultsScreen extends StatelessWidget {
  static const routeName = '/results-screen';
  List<bool> result = [];
  int sum = 0;

  calculateScore(List<int> userAns, List<int> ans) {
    for (int i = 0; i < userAns.length; i++) {
      if (userAns[i] == ans[i]) {
        sum = sum + 1;
        result.add(true);
      } else {
        result.add(false);
      }
    }
    print("sum $sum");
  }

  @override
  Widget build(BuildContext context) {
    var data = ModalRoute.of(context).settings.arguments as Map<String, List>;
    var userAns = data['userAnswers'];
    var answers = data['answers'];
    calculateScore(userAns, answers);
    print("$sum $result");
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Your Score:',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              sum.toString(),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 25,
            ),
            RaisedButton(
              onPressed: () => Navigator.of(context).popAndPushNamed("/"),
              child: Text('Restart Quiz~'),
            )
          ],
        ),
      ),
    );
  }
}
