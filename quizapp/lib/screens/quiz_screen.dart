import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/providers/quiz_data.dart';
import 'package:quizapp/screens/results_screen.dart';
import 'package:quizapp/widgets/quiz_question_layout.dart';
import 'package:connectivity/connectivity.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _pos = 1;
  var _isInit = false;
  bool connection = false;
  final globalKey = GlobalKey<ScaffoldState>();

  PageController _c = PageController(initialPage: 0);

  List<int> answers = [];
  List<int> userAnswers = [];

  Future<void> _fetchQuizData(BuildContext context) async {
    print("hello");
    try {
      await Provider.of<QuizData>(context, listen: false).fetchAndSetData();
    } catch (e) {
      print(e);
    }
  }

  Future<void> checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      setState(() {
        connection = true;
      });
    } else if (connectivityResult == ConnectivityResult.wifi) {
      setState(() {
        connection = true;
      });
    } else {
      setState(() {
        connection = false;
      });
    }
    _isInit = true;
  }

  Future<bool> checkSubmitConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void didChangeDependencies() {
    if (!_isInit) {
      checkConnection();
      _fetchQuizData(context);
      _c = new PageController();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<QuizData>(context);

    return Scaffold(
      key: globalKey,
      backgroundColor: Color.fromRGBO(29, 36, 67, 0.0),
      body: !_isInit
          ? Center(
              child: CircularProgressIndicator(),
            )
          : !connection
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('No internet connection'),
                      SizedBox(
                        height: 10,
                      ),
                      RaisedButton(
                          child: Text('Refresh'),
                          onPressed: () {
                            checkConnection();
                            setState(() {});
                          })
                    ],
                  ),
                )
              : PageView.builder(
                  controller: _c,
                  // physics: new NeverScrollableScrollPhysics(),
                  itemCount: data.quizData.length,
                  onPageChanged: (index) {
                    _pos = index + 1;
                    setState(() {});
                  },
                  itemBuilder: (ctx, position) {
                    return SingleChildScrollView(
                      padding: EdgeInsets.all(30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 50,
                          ),
                          Text(
                            'Quiz',
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.white70,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Question ${position + 1}/${data.quizData.length}',
                            style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Divider(
                            thickness: 0.5,
                            color: Colors.white70,
                          ),
                          QuizQuestionLayout(
                            question: data.quizData[position].question,
                            optionA: data.quizData[position].optionA,
                            optionB: data.quizData[position].optionB,
                            optionC: data.quizData[position].optionC,
                            optionD: data.quizData[position].optionD,
                            answer: data.quizData[position].answer,
                            feedback: data.quizData[position].feedback,
                            dataId: data.quizData[position].dataId,
                            userAnswers: userAnswers,
                            pos: position,
                          ),
                        ],
                      ),
                    );
                  },
                ),
      floatingActionButton: !connection
          ? null
          : Container(
              width: 120,
              padding: EdgeInsets.only(right: 20),
              child: FloatingActionButton.extended(
                onPressed: () {
                  if (_pos == data.quizData.length) {
                    print('eod');
                    data.quizData.forEach((element) {
                      answers.add(element.answer);
                    });
                    // print(answers);
                    // print(userAnswers);
                    checkSubmitConnection().then((value) {
                      if (value) {
                        Navigator.of(context).pushReplacementNamed(
                            ResultsScreen.routeName,
                            arguments: {
                              'userAnswers': userAnswers,
                              'answers': answers,
                            });
                      } else {
                        globalKey.currentState.hideCurrentSnackBar();
                        globalKey.currentState.showSnackBar(
                          SnackBar(
                            content: Text(
                              'Not connected to the internet',
                            ),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                    });

                    return;
                  }
                  _c.nextPage(
                      duration: Duration(milliseconds: 200),
                      curve: Curves.easeIn);
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                label: Text(
                  _pos == data.quizData.length ? 'Submit' : 'Next',
                  style: TextStyle(fontSize: 16),
                ),
                backgroundColor: Colors.lightBlue,
              ),
            ),
    );
  }
}
