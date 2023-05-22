import 'dart:math';

import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';

class CongratulationsPage extends StatelessWidget {
  final ConfettiController confettiController;

  const CongratulationsPage({Key? key, required this.confettiController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Congratulations'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Congratulations! You have completed the test.',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.0),
            ConfettiWidget(
              confettiController: confettiController,
              blastDirection: -pi / 2,
              emissionFrequency: 0.05,
              numberOfParticles: 20,
              gravity: 0.1,
              colors: const [
                Colors.green,
                Colors.blue,
                Colors.pink,
                Colors.orange,
                Colors.purple,
              ],
            ),
          ],
        ),
      ),
    );
  }
}