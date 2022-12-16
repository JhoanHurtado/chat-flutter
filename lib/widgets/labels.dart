import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  final String routa;
  final String textQuestion;
  final String textAnswer;

  const Labels({super.key, required this.routa, required this.textQuestion, required this.textAnswer});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            textQuestion,
            style: TextStyle(
                color: Colors.black54,
                fontSize: 15,
                fontWeight: FontWeight.w300),
          ),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            child: Text(
              textAnswer,
              style: TextStyle(
                  color: Colors.blue[600],
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            onTap: () => Navigator.pushReplacementNamed(context, routa),
          )
        ],
      ),
    );
  }
}
