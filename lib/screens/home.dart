import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:get/get.dart';
import 'package:quiz_app/screens/congratulations.dart';

import '../controllers/question.controller.dart';
import '../models/question.model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ConfettiController _confettiController;

  final List<Question> questions = Get.find<QuestionController>().questions;

  int currentQuestionIndex = 0;
  List selectedChoices = [];

  void nextQuestion() {
    String chosenLetter = questions[currentQuestionIndex].choices[selectedChoices[currentQuestionIndex ]].split('.')[0];
    print("currentQuestionIndex");
    print(questions[currentQuestionIndex].qID!);
    Get.find<QuestionController>().submitAnswer(questions[currentQuestionIndex].qID!, chosenLetter);
    setState(() {
      if (currentQuestionIndex < questions.length - 1) {
        currentQuestionIndex++;
      }
    });
  }

  void previousQuestion() {
    setState(() {
      if (currentQuestionIndex > 0) {
        currentQuestionIndex--;
      }
    });
  }

  void selectChoice(String choice) {
    print(choice);
    int hi = Get.find<QuestionController>().questions[currentQuestionIndex].choices.indexOf(choice);
    print(currentQuestionIndex);
    setState(() {
      selectedChoices[currentQuestionIndex] = hi;
      print(selectedChoices.toString());
    });
  }

  void submitTest() async {
     String result = await Get.find<QuestionController>().checkAnswers();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CongratulationsPage(
          confettiController: _confettiController,
        ),
      ),
    );
    // Trigger the confetti effect
    _confettiController.play();
  }

  @override
  void initState() {
    super.initState();
    selectedChoices = List<int>.filled(questions.length, -1);
    _confettiController = ConfettiController(duration: const Duration(seconds: 3));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      backgroundColor: Colors.grey[900],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Question ${currentQuestionIndex + 1}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                Get.find<QuestionController>().questions[currentQuestionIndex].qUESTION!,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 32.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: Get.find<QuestionController>().questions[currentQuestionIndex].choices.map((choice) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 8.0),
                    child: ChoiceButton(
                      choice: choice,
                      isSelected: true,
                      onPressed: () {
                        selectChoice(choice);
                      },
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 32.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (currentQuestionIndex > 0)
                    ElevatedButton(
                      onPressed: previousQuestion,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                      ),
                      child: const Text(
                        'Previous',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ElevatedButton(
                    onPressed: currentQuestionIndex < questions.length - 1 ? nextQuestion : submitTest,
                    style: ElevatedButton.styleFrom(
                      primary: Colors.deepPurple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                    ),
                    child: Text(
                      currentQuestionIndex < questions.length - 1 ? 'Next' : 'Submit',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChoiceButton extends StatelessWidget {
  final String choice;
  final bool isSelected;
  final VoidCallback onPressed;

  const ChoiceButton({
    Key? key,
    required this.choice,
    required this.isSelected,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.deepPurple : Colors.grey[800],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      ),
      child: Text(
        choice,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.white70,
          fontSize: 18,
        ),
      ),
    );
  }
}
