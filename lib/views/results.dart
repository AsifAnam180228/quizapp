import 'package:flutter/material.dart';
import 'package:quizapp/widgets/widgets.dart';
class Results extends StatefulWidget {
  final int correct, incorrect, total;

  Results({@required this.correct,@required this.incorrect,@required this.total});

  @override
  _ResultsState createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("${widget.correct}/${widget.total}",
              style: TextStyle(
                fontSize: 18,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
              ),
              SizedBox(height: 10,),
              Text("Congratulations!!!",style: TextStyle(
                fontSize: 25,
                color: Colors.red,

              ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10,),
              Text("You have answered ${widget.correct} answers correctly and"
                  " ${widget.incorrect} answers incorrectly out of ${widget.total} questions",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 80,),
              GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                  child: logButton(context, "Home", null,),


              )
            ],
          ),
        ),
      ),
    );
  }
}
