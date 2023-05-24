import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/controllers/question.controller.dart';
import 'package:quiz_app/controllers/user.controller.dart';

import 'package:quiz_app/screens/home.dart';
import 'package:quiz_app/services/api.dart';

class CoolLoginPage extends StatefulWidget {
  @override
  _CoolLoginPageState createState() => _CoolLoginPageState();
}

class _CoolLoginPageState extends State<CoolLoginPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  late Future<dynamic> futureUser;

  TextEditingController idNumber = TextEditingController();


  
  @override
  void initState() {
    super.initState();


    _animationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.5),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.5, 1.0),
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
  
  Future<dynamic> getUser(){
    return Get.put(UserController().loginStudent(idNumber.text));
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
          
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF3C2C67),
            Color(0xFF1F1624),
          ],
        ),
      ),
      child: Stack(
        children: [
          AnimatedBuilder(
            animation: _fadeAnimation,
            builder: (context, child) {
              return Opacity(
                opacity: _fadeAnimation.value,
                child: child,
              );
            },
            child: const Center(
              child: Text(
                'Cool Login Page',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          AnimatedBuilder(
            animation: _scaleAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _scaleAnimation.value,
                child: child,
              );
            },
            child: Center(
              child: Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: idNumber,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'ID Number',
                        hintText: 'Enter ID Number'
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    const SizedBox(height: 34),
                    ElevatedButton(
                      onPressed: () async {
                        Get.find<UserController>().loginStudent(idNumber.text);
                        print(idNumber.text);
                        // ignore: unrelated_type_equality_checks
                        if(idNumber.text == idNumber.text){
                        print(idNumber.text);
                          print("Login Succesful");
                          await Get.find<QuestionController>().populateQuestions();
                          Get.to(const HomePage(title: "letsgo"));
                        }else {
                          print("Login Failed");
                        }
                      },
                      child: const Text('Login'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      )
              
    );
  }
}