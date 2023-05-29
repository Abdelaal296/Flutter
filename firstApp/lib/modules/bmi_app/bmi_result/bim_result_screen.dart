import 'package:flutter/material.dart';

class BMIResultScreen extends StatelessWidget {
  final bool isMale;
  final int age ;
  final int result ;

  BMIResultScreen({
    required this.age,
    required this.isMale,
    required this.result,
  });


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'BMI Result'
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Gender : ${isMale ? 'Male':'Female' } ',style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30.0 ,
            ),
            ),
            Text(
              'Age :$age ',style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30.0 ,
            ),
            ),
            Text(
              'Result : $result',style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30.0 ,
            ),
            ),
          ],
        ),
      ),
    );
  }
}
