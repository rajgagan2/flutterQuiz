import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/providers/quiz_data.dart';
import 'package:quizapp/screens/quiz_screen.dart';
import 'package:quizapp/screens/results_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => QuizData(),
      child: MaterialApp(
        title: 'Flutter Demo',
        themeMode: ThemeMode.dark,
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          unselectedWidgetColor: Color.fromRGBO(232, 233, 234, 0.9),
          textTheme: TextTheme(
            bodyText1: TextStyle(),
            bodyText2: TextStyle(),
          ).apply(
            bodyColor: Color.fromRGBO(232, 233, 234, 0.9),
            displayColor: Color.fromRGBO(232, 233, 234, 0.9),
          ),
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: QuizScreen(),
        routes: {
          ResultsScreen.routeName: (ctx) => ResultsScreen(),
        },
      ),
    );
  }
}
