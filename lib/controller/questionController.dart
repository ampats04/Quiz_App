import 'package:get/get.dart';
import 'package:quiz_app/models/question_model.dart';

class QuestionController extends GetxController {
  RxList<Question> ques = [
    Question(
      id: 1,
      question: "What is the capital of France?",
      choices: ['Paris', 'London', 'Berlin', 'Rome'],
    ),
    Question(
      id: 2,
      question: 'What is the largest planet in our solar system?',
      choices: ['mycock', 'cockmine', 'AndyCock', 'MYjeremysCock'],
    )
  ].obs;
}
