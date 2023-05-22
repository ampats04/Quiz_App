import 'package:get/get.dart';
import 'package:quiz_app/models/questionModel.dart';

class QuestionController extends GetxController {
  RxList<Question> ques = [
    Question(
      id: 1,
      option: ['Paris', 'London', 'Berlin', 'Rome'],
      qid: 1,
      question: "What is the capital of France?",
    ),
    Question(
      id: 2,
      option: ['Brian', 'Jeremy', 'Keith', 'Andy'],
      qid: 2,
      question: "What is the capital of My COck?",
    )
  ].obs;


}
