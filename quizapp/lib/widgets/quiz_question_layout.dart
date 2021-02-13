import 'package:flutter/material.dart';

class QuizQuestionLayout extends StatefulWidget {
  final String dataId;
  final String question;
  final String optionA;
  final String optionB;
  final String optionC;
  final String optionD;
  final String feedback;
  final int answer;
  final List<int> userAnswers;
  final pos;
  QuizQuestionLayout({
    @required this.dataId,
    @required this.question,
    @required this.optionA,
    @required this.optionB,
    @required this.optionC,
    @required this.optionD,
    @required this.answer,
    @required this.feedback,
    @required this.userAnswers,
    @required this.pos,
  });
  @override
  _QuizQuestionLayoutState createState() => _QuizQuestionLayoutState();
}

class _QuizQuestionLayoutState extends State<QuizQuestionLayout> {
  int radioGroupValue = 0;
  var _isInit = false;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInit) {
      _isInit = true;
      widget.userAnswers.add(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    print(widget.userAnswers.length);
    return Container(
        child: Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Text(
          widget.question,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: 40,
        ),
        Container(
          width: double.infinity,
          height: 60,
          padding: EdgeInsets.only(left: 20, right: 10),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            border: Border.all(
                color: radioGroupValue == 1 ? Colors.green : Colors.blueGrey),
            borderRadius: BorderRadius.all(
              Radius.circular(15.0),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.optionA,
                style: TextStyle(fontSize: 16),
              ),
              // IconButton(
              //   icon: Icon(Icons.radio_button_off_outlined, color: Colors.blueGrey,),
              //   onPressed: () {},
              //   color: Colors.white,
              // )
              Radio(
                value: 1,
                groupValue: radioGroupValue,
                activeColor: Colors.green,
                onChanged: (val) {
                  radioGroupValue = val;
                  if (widget.userAnswers.length <= widget.pos) {
                    widget.userAnswers.add(val);
                  } else {
                    widget.userAnswers[widget.pos] = val;
                  }
                  setState(() {});
                },
              )
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          width: double.infinity,
          height: 60,
          padding: EdgeInsets.only(left: 20, right: 10),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            border: Border.all(
                color: radioGroupValue == 2 ? Colors.green : Colors.blueGrey),
            borderRadius: BorderRadius.all(
              Radius.circular(15.0),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.optionB,
                style: TextStyle(fontSize: 16),
              ),
              // IconButton(
              //   icon: Icon(Icons.radio_button_off_outlined, color: Colors.blueGrey,),
              //   onPressed: () {},
              //   color: Colors.white,
              // )
              Radio(
                value: 2,
                groupValue: radioGroupValue,
                activeColor: Colors.green,
                onChanged: (val) {
                  radioGroupValue = val;
                  if (widget.userAnswers.length <= widget.pos) {
                    widget.userAnswers.add(val);
                  } else {
                    widget.userAnswers[widget.pos] = val;
                  }
                  setState(() {});
                },
              )
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          width: double.infinity,
          height: 60,
          padding: EdgeInsets.only(left: 20, right: 10),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            border: Border.all(
                color: radioGroupValue == 3 ? Colors.green : Colors.blueGrey),
            borderRadius: BorderRadius.all(
              Radius.circular(15.0),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.optionC,
                style: TextStyle(fontSize: 16),
              ),
              // IconButton(
              //   icon: Icon(Icons.radio_button_off_outlined, color: Colors.blueGrey,),
              //   onPressed: () {},
              //   color: Colors.white,
              // )
              Radio(
                value: 3,
                groupValue: radioGroupValue,
                activeColor: Colors.green,
                onChanged: (val) {
                  radioGroupValue = val;

                  if (widget.userAnswers.length <= widget.pos) {
                    widget.userAnswers.add(val);
                  } else {
                    widget.userAnswers[widget.pos] = val;
                  }

                  setState(() {});
                },
              )
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          width: double.infinity,
          height: 60,
          padding: EdgeInsets.only(left: 20, right: 10),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            border: Border.all(
                color: radioGroupValue == 4 ? Colors.green : Colors.blueGrey),
            borderRadius: BorderRadius.all(
              Radius.circular(15.0),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.optionD,
                style: TextStyle(fontSize: 16),
              ),
              // IconButton(
              //   icon: Icon(Icons.radio_button_off_outlined, color: Colors.blueGrey,),
              //   onPressed: () {},
              //   color: Colors.white,
              // )
              Radio(
                value: 4,
                groupValue: radioGroupValue,
                activeColor: Colors.green,
                onChanged: (val) {
                  radioGroupValue = val;
                  if (widget.userAnswers.length <= widget.pos) {
                    widget.userAnswers.add(val);
                  } else {
                    widget.userAnswers[widget.pos] = val;
                  }
                  setState(() {});
                },
              )
            ],
          ),
        )
      ],
    ));
  }
}
