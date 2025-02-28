import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final String? image;
  final Color bgColor;
  final Color textColor;

  const LoginButton(
      {super.key,
      required this.onPressed,
      required this.text,
      this.image,
      required this.bgColor,
      required this.textColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(bgColor),
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (image != null) Image.asset(image!, width: 24, height: 24),
            if (image != null) const SizedBox(width: 10),
            Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
