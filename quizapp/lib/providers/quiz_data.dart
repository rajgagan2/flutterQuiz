import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QuizDataList {
  final String dataId;
  final String question;
  final String optionA;
  final String optionB;
  final String optionC;
  final String optionD;
  final String feedback;
  final int answer;

  QuizDataList({
    @required this.dataId,
    @required this.question,
    @required this.optionA,
    @required this.optionB,
    @required this.optionC,
    @required this.optionD,
    @required this.answer,
    @required this.feedback,
  });
}

class QuizData with ChangeNotifier {
  List<QuizDataList> _quizData = [];

  List<QuizDataList> get quizData {
    return [..._quizData];
  }

  Future<void> fetchAndSetData() async {
    final List<QuizDataList> loadedData = [];

    var data = await Firestore.instance.collection('questions').getDocuments();
    data.documents.forEach((element) {
      loadedData.add(QuizDataList(
        dataId: element.documentID,
        question: element['question'],
        optionA: element['options']['option_a'],
        optionB: element['options']['option_b'],
        optionC: element['options']['option_c'],
        optionD: element['options']['option_d'],
        answer: element['answer'],
        feedback: element['feedback'],
      ));
    });

    _quizData = loadedData;
    notifyListeners();
  }
}
