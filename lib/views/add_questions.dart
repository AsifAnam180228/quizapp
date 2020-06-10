import 'package:flutter/material.dart';
import 'package:quizapp/services/database.dart';
import 'package:quizapp/widgets/widgets.dart';

class AddQuestion extends StatefulWidget {
  final String quizId;
  AddQuestion({this.quizId});
  @override
  _AddQuestionState createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  final _formKey = GlobalKey<FormState>();
  String question, option1, option2, option3, option4;
  bool _isloading = false ;
  DatabaseService databaseService = new DatabaseService();
  uploadQuestionData()async{
    if(_formKey.currentState.validate()){
      setState(() {
        _isloading = true;
      });

      Map<String,String> questionMap ={
        "question" : question,
        "option1" :option1,
        "option2": option2,
        "option3" :option3,
        "option4": option4,

      };
      await databaseService.addQuestionData(questionMap, widget.quizId).then((value)
      {
        setState(() {
          _isloading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.blue),
        brightness: Brightness.light,
      ),
      body: _isloading ? Container(
        child: Center(child: CircularProgressIndicator(),),): Form(
        key: _formKey,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: <Widget>[
              TextFormField(
                validator: (val) => val.isEmpty ? "Enter Question" : null,
                decoration: InputDecoration(hintText: "Question"),
                onChanged: (val) {
                  question = val;
                },
              ),
              SizedBox(
                height: 6,
              ),
              TextFormField(
                validator: (val) =>
                val.isEmpty ? "Enter Option" : null,
                decoration: InputDecoration(hintText: "Option 1"),
                onChanged: (val) {
                  option1 = val;
                },
              ),
              SizedBox(
                height: 6,
              ),
              TextFormField(
                validator: (val) =>
                val.isEmpty ? "Enter Option" : null,
                decoration: InputDecoration(hintText: "Option 2"),
                onChanged: (val) {
                  option2 = val;
                },
              ),
              SizedBox(
                height: 6,
              ),
              TextFormField(
                validator: (val) =>
                val.isEmpty ? "Enter Option" : null,
                decoration: InputDecoration(hintText: "Option 3"),
                onChanged: (val) {
                  option3 = val;
                },
              ),
              SizedBox(
                height: 6,
              ),
              TextFormField(
                validator: (val) =>
                val.isEmpty ? "Enter Option" : null,
                decoration: InputDecoration(hintText: "Option 4"),
                onChanged: (val) {
                  option4 = val;
                },
              ),
              SizedBox(
                height: 6,
              ),
              Spacer(),
            Row(
              children: <Widget>[
                GestureDetector(
                  onTap: (){
                    uploadQuestionData();
                    Navigator.pop(context);

                  },
                    child: logButton(context, "submit", MediaQuery.of(context).size.width/2 - 36)
                ),
                SizedBox(width: 24,),
                GestureDetector(
                  onTap: (){
                    uploadQuestionData();

                  },
                    child: logButton(context, "Add Question", MediaQuery.of(context).size.width/2 - 36)
                ),
                SizedBox(height: 70,)
              ],
            )
            ],
          ),
        ),
      ),
    );
  }
}
