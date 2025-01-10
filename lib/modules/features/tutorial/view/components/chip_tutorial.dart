import 'package:flutter/material.dart';

class ChipTutorial extends StatelessWidget {
  final String imageUrl;
  final VoidCallback onTap;
  final double size;
  final int backgroundColor;

  const ChipTutorial({
    Key? key,
    required this.imageUrl,
    required this.onTap,
    this.size = 60.0,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: backgroundColor == 0
              ? Colors.white
              : const Color.fromARGB(255, 209, 246, 98),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipOval(child: Image.asset(imageUrl)),
        ),
      ),
    );
  }
}
