import 'package:flutter/material.dart';

class Rules extends StatelessWidget {
  const Rules({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: RichText(
          textAlign: TextAlign.center,
          text: const TextSpan(
            text: 'By tapping Create Account or Sign In, you agree to our\n',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
            children: [
              TextSpan(
                text: 'Terms.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
              TextSpan(
                text: ' Learn how we process your data in our ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
              TextSpan(
                text: 'Privacy\nPolicy',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
              TextSpan(
                text: ' and ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
              TextSpan(
                text: 'Cookies Policy',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          )),
    );
  }
}
