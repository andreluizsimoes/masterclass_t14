import 'package:flutter/material.dart';

class FormRow extends StatelessWidget {
  final String text;

  const FormRow({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: Row(
        children: [
          Text(
            text,
            style: const TextStyle(
              fontFamily: 'Times New Roman',
              fontSize: 16,
            ),
          ),
          const SizedBox(
            width: 200,
            child: TextField(
              decoration: InputDecoration(
                isDense: true,
                border: OutlineInputBorder(),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
