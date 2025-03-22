import 'package:flutter/material.dart';

class TinderButton extends StatelessWidget {
  final String icon;
  final String text;
  final VoidCallback onTap;

  const TinderButton(
      {super.key, required this.icon, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return InkWell(
      onTap: onTap,
      child: Container(
        width: isPortrait ? double.infinity : 400,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.white, width: 2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Icon(icon, color: Colors.white, size: 24),
            Image.asset(icon, width: 24, height: 24),
            const SizedBox(width: 15),
            Expanded(
              child: Text(
                text.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
