import 'package:flutter/material.dart';

class SubmitFormButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const SubmitFormButton(
      {super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onPressed,
      child: SizedBox(
        height: 30,
        width: 100,
        child: ElevatedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2),
                side: BorderSide(color: Colors.grey, width: 1.5),
              ),
            ),
            backgroundColor: MaterialStateProperty.all(Colors.grey.shade200),
          ),
          onPressed: () {},
          child: Text(
            text,
            style: TextStyle(color: Colors.grey.shade800),
          ),
        ),
      ),
    );
  }
}
