import 'package:flutter/material.dart';

class BotonAzul extends StatelessWidget {
  final String text;
  final ShapeBorder? shape ;
  final VoidCallback onpressed;
  const BotonAzul({super.key, required this.text, this.shape, required this.onpressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      // padding: const EdgeInsets.only(bottom: 15, top: 15),
      elevation: 2,
      highlightElevation: 5,
      color: Colors.blue,
      textColor: Colors.white,
      shape: shape ?? const StadiumBorder(),
      onPressed: onpressed,
      child: Container(
        width: double.infinity,
        height: 55,
        child: Center(
          child: Text(
            text,
            style: const TextStyle(fontSize: 17),
          ),
        ),
      ),
    );
  }
}
