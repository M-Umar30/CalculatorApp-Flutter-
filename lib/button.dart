import 'package:flutter/material.dart';

class buttonStyle extends StatelessWidget{
  final color;
  final textColor;
  final String buttonText;
  final onTap;

  buttonStyle({
    this.color,
    this.textColor,
    this.buttonText = '0',
    this.onTap
  });

  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(0.1),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50.0),
          child: Container(
            color: color,
            child: Center(
              child: Text(
                buttonText,
                style: TextStyle(
                  fontSize: 35.0,
                  color: textColor,
                ),
              ),
            ),
          ),
        ),

      ),
    );

  }
}