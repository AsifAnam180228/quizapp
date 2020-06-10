import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizapp/services/database.dart';
import 'package:quizapp/views/create_quiz.dart';
import 'package:quizapp/views/play_quiz.dart';
import 'package:quizapp/widgets/widgets.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DatabaseService databaseService = new DatabaseService();
  Stream quizStream;
  Widget quizList(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 28),
      child: StreamBuilder(
        stream: quizStream,
        builder: (context,snapshot){
          return snapshot.data == null
              ? Container():
              ListView.builder(
                itemCount: snapshot.data.documents.length,
                  itemBuilder: (context,index){
                  return QuizTitle(
                    imgUrl: snapshot.data.documents[index].data["quizImgUrl"],
                    desc: snapshot.data.documents[index].data["quizDesc"],
                    title: snapshot.data.documents[index].data["quizTitle"],
                    quizId: snapshot.data.documents[index].data["quizId"],
                  );
          });
        },
      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    databaseService.getQuizData().then((val){
      setState(() {
        quizStream = val;
      });
    });
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
      body: quizList(

      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),

        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CreateQuiz()));
        },
      ),
    );
  }
}
class QuizTitle extends StatelessWidget {
  final String imgUrl;
  final String title;
  final String desc;
  final String quizId;

   QuizTitle({@required this.imgUrl,@required this.title,@required this.desc,
   @required this.quizId
   });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context)=> PlayQuiz(quizId: quizId,)
        ));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 8),
        height: 150,
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
                child: Image.network(imgUrl,width: MediaQuery.of(context).size.width - 48,fit: BoxFit.cover,)),//fit: BoxFit.cover,
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.black26,
              ),

              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(title, style: TextStyle( color: Colors.white,fontSize: 20,fontWeight: FontWeight.w500),),
                  SizedBox(height: 6,),
                  Text(desc, style: TextStyle( color: Colors.white,fontSize: 15,fontWeight: FontWeight.w500),),

                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}
