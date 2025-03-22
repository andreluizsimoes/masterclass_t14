import 'package:flutter/material.dart';

class SubmitFormButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const SubmitFormButton(
      {super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: SizedBox(
        height: 30,
        width: 70,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.grey, width: 1),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.grey.shade800,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
