import 'package:flutter/material.dart';

class TinderLogo extends StatelessWidget {
  final double size;

  const TinderLogo({
    super.key,
    this.size = 120.0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size * 1.3,
      child: LayoutBuilder(builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;
        final maxHeight = constraints.maxHeight;

        return Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: maxWidth * 0.4,
                      height: maxHeight * 0.35,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.elliptical(50, 50),
                        ),
                      ),
                    ),
                    Container(
                      width: maxWidth * 0.6,
                      height: maxHeight * 0.55,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.elliptical(80, 100),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: maxWidth,
                  height: maxHeight * 0.35,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(100),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: 0,
              right: maxWidth * 0.35,
              child: Transform.rotate(
                angle: -0.7,
                child: Container(
                  width: maxWidth * 0.5,
                  height: maxHeight * 0.3,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE95270),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(maxWidth * 0.5),
                      bottomRight: Radius.circular(maxWidth * 0.5),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
