import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:get/get.dart';
import 'package:quiz_app/screens/congratulations.dart';

import '../controller/questionController.dart';
import '../models/question_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ConfettiController _confettiController;

  final RxList questions = Get.find<QuestionController>().ques;

  int currentQuestionIndex = 0;
  Map<int, String> selectedChoices = {};

  void nextQuestion() {
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
    setState(() {
      selectedChoices[currentQuestionIndex] = choice;
    });
  }

  void submitTest() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            CongratulationsPage(confettiController: _confettiController),
      ),
    );
    // Trigger the confetti effect
    _confettiController.play();
  }

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 3));
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
            mainAxisAlignment: MainAxisAlignment.center,
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
                Get.find<QuestionController>()
                    .ques[currentQuestionIndex]
                    .question
                    .toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 32.0),
              Column(
                children: Get.find<QuestionController>()
                    .ques[currentQuestionIndex]
                    .choices!
                    .map((choice) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 8.0),
                    child: ChoiceButton(
                      choice: choice,
                      isSelected:
                          selectedChoices.containsKey(currentQuestionIndex) &&
                              selectedChoices[currentQuestionIndex] == choice,
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24.0, vertical: 12.0),
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
                    onPressed: currentQuestionIndex < questions.length - 1
                        ? nextQuestion
                        : submitTest,
                    style: ElevatedButton.styleFrom(
                      primary: Colors.deepPurple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24.0, vertical: 12.0),
                    ),
                    child: Text(
                      currentQuestionIndex < questions.length - 1
                          ? 'Next'
                          : 'Submit',
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
        primary: isSelected ? Colors.deepPurple : Colors.grey[800],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
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
