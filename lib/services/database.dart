import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  Future<void> addQuizData(Map quizData, quizId) async {
    await Firestore.instance
        .collection("Quiz")
        .document(quizId)
        .setData(quizData)
        .catchError((e) {
      print(e.toString());
    });
  }
  Future<void> addQuestionData(Map questionData, String quizId) async{
    await Firestore.instance.collection("Quiz")
        .document(quizId).collection("Question")
        .add(questionData)
        .catchError((e){
          print(e);
    });
  }
  getQuizData()async{
    return await Firestore.instance.collection(("Quiz")).snapshots();
  }
  getQuestionData(String quizId) async{
    return await Firestore.instance.collection("Quiz").document(quizId)
    .collection("Question")
  .getDocuments();
  }
  Future<void> addData(userData) async {
    Firestore.instance.collection("users").add(userData)
        .catchError((e){
          print(e);
    });
  }
  getData() async{
    return Firestore.instance.collection("users").snapshots();
  }
}
