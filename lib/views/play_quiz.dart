import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quizapp/models/question_model.dart';
import 'package:quizapp/services/database.dart';
import 'package:quizapp/views/results.dart';
import 'package:quizapp/widgets/quiz_play_widget.dart';
import 'package:quizapp/widgets/widgets.dart';
class PlayQuiz extends StatefulWidget {
  final String quizId;
  PlayQuiz({this.quizId});
  @override
  _PlayQuizState createState() => _PlayQuizState();
}
int total = 0;
int _correct = 0;
int _incorrect = 0;
int _notAttempted = 0;
class _PlayQuizState extends State<PlayQuiz> {
  DatabaseService databaseService = new DatabaseService() ;
  bool isLoading = true;
  QuerySnapshot questionSnapshot;
  QuestionModel getQuestionModelFromDataSnapshot(
      DocumentSnapshot questionSnapshot
      ){
    QuestionModel questionModel = new QuestionModel();
    questionModel.question = questionSnapshot.data["question"];
    List<String> options = [
      questionSnapshot.data["option1"],
      questionSnapshot.data["option2"],
      questionSnapshot.data["option3"],
      questionSnapshot.data["option4"],
    ];
    options.shuffle();
    questionModel.option1 = options[0];
    questionModel.option2 = options[1];
    questionModel.option3 = options[2];
    questionModel.option4 = options[3];
    questionModel.correctOption = questionSnapshot.data["option1"];
    questionModel.answered =false;
    return questionModel;
  }
  @override
  void initState() {
    // TODO: implement initState
    databaseService.getQuestionData(widget.quizId).then((value){
      questionSnapshot = value;
      _notAttempted=0;
      _correct =0;
      _incorrect = 0;
      total = questionSnapshot.documents.length;

      print("$total this is total ");
      setState(() {
      });
    });
    print("${widget.quizId}");
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.blue),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            questionSnapshot ==null?
                Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ):
                ListView.builder(
                  padding:EdgeInsets.symmetric(horizontal: 24) ,
                  shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: questionSnapshot.documents.length,
                    itemBuilder: (context,index){
                      return QuizPlayTile(
                        questionModel: getQuestionModelFromDataSnapshot(
                            questionSnapshot.documents[index]),
                        index:index,
                  );
                })
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context)=> Results(
              correct : _correct,
              incorrect: _incorrect,
              total: total,
            )
          ));
        },
      ),
    );
  }
}

class QuizPlayTile extends StatefulWidget {
  final int index;
  final QuestionModel questionModel;

  QuizPlayTile({@required this.questionModel,@required this.index});

  @override
  _QuizPlayTileState createState() => _QuizPlayTileState();
}

class _QuizPlayTileState extends State<QuizPlayTile> {
  String optionSelected = "";
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              child:
              Text("Q${widget.index+1})  ${widget.questionModel.question}", style: TextStyle(
                fontSize: 18,
                color: Colors.black87,
              ),)
             // "Q${widget.index + 1} ${widget.questionModel.question}",
          ),
          SizedBox(height: 12,),
          GestureDetector(
            onTap: (){
              if(!widget.questionModel.answered){
                ///correct
                if(widget.questionModel.option1==
                    widget.questionModel.correctOption){
                  optionSelected= widget.questionModel.option1;
                  widget.questionModel.answered=true;
                  _correct = _correct +1;
                  _notAttempted =_notAttempted -1;
                  setState(() {

                  });
                }else{
                  optionSelected = widget.questionModel.option1;
                  widget.questionModel.answered=true;
                  _incorrect = _incorrect+ 1;
                  _notAttempted =_notAttempted -1;
                  setState(() {

                  });
                }
              }
            },
            child: GestureDetector(
              onTap: (){
                if(!widget.questionModel.answered){
                  ///correct
                  if(widget.questionModel.option1== widget.questionModel.correctOption){
                    optionSelected= widget.questionModel.option1;
                    widget.questionModel.answered=true;
                    _correct = _correct +1;
                    _notAttempted =_notAttempted -1;
                    setState(() {

                    });
                  }else{
                    optionSelected = widget.questionModel.option1;
                    widget.questionModel.answered=true;
                    _incorrect = _incorrect+ 1;
                    _notAttempted =_notAttempted -1;
                    setState(() {

                    });
                  }
                }
              },
              child: OptionTile(
                correctAnswer: widget.questionModel.correctOption,
                description: widget.questionModel.option1,
                option: "A",
                optionSelected: optionSelected,
              ),
            ),
          ),
          SizedBox(height: 12,),
          GestureDetector(
            onTap: (){
              if(!widget.questionModel.answered){
                ///correct
                if(widget.questionModel.option2== widget.questionModel.correctOption){
                  optionSelected= widget.questionModel.option2;
                  widget.questionModel.answered=true;
                  _correct = _correct +1;
                  _notAttempted =_notAttempted -1;
                  setState(() {
                    print(" ${widget.questionModel.correctOption}");
                  });
                }else{
                  optionSelected = widget.questionModel.option2;
                  widget.questionModel.answered=true;
                  _incorrect = _incorrect+ 1;
                  _notAttempted =_notAttempted -1;
                }
                setState(() {

                });
              }
            },
            child: OptionTile(
              correctAnswer: widget.questionModel.correctOption,
              description: widget.questionModel.option2,
              option: "B",
              optionSelected: optionSelected,
            ),
          ),
          SizedBox(height: 12,),
          GestureDetector(
            onTap: (){
              if(!widget.questionModel.answered){
                ///correct
                if(widget.questionModel.option3== widget.questionModel.correctOption){
                  optionSelected= widget.questionModel.option3;
                  widget.questionModel.answered=true;
                  _correct = _correct +1;
                  _notAttempted =_notAttempted -1;
                  setState(() {

                  });
                }else{
                  optionSelected = widget.questionModel.option3;
                  widget.questionModel.answered=true;
                  _incorrect = _incorrect+ 1;
                  _notAttempted =_notAttempted -1;
                  setState(() {

                  });
                }
              }
            },
            child: OptionTile(
              correctAnswer: widget.questionModel.correctOption,
              description: widget.questionModel.option3,
              option: "C",
              optionSelected: optionSelected,
            ),
          ),
          SizedBox(height: 12,),
          GestureDetector(
            onTap: (){
              if(!widget.questionModel.answered){
                ///correct
                if(widget.questionModel.option4== widget.questionModel.correctOption){
                  optionSelected= widget.questionModel.option4;
                  widget.questionModel.answered=true;
                  _correct = _correct +1;
                  _notAttempted =_notAttempted -1;
                  setState(() {

                  });
                }else{
                  optionSelected = widget.questionModel.option4;
                  widget.questionModel.answered=true;
                  _incorrect = _incorrect+ 1;
                  _notAttempted =_notAttempted -1;
                  setState(() {

                  });
                }
              }
            },
            child: OptionTile(
              correctAnswer: widget.questionModel.correctOption,
              description: widget.questionModel.option4,
              option: "D",
              optionSelected: optionSelected,
            ),
          ),
          SizedBox(height: 12,),
        ],
      ),
    );
  }
}
