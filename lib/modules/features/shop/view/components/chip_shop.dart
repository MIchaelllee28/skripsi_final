import 'package:flutter/material.dart';

class ChipShop extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final double hSize;
  final double wSize;
  final int backgroundColor;

  const ChipShop({
    Key? key,
    required this.text,
    required this.onTap,
    this.hSize = 60,
    this.wSize = 120,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: wSize,
        height: hSize,
        decoration: BoxDecoration(
          color: backgroundColor == 0
              ? Colors.white
              : const Color.fromARGB(255, 116, 221, 121),
          borderRadius:
              BorderRadius.circular(30), // Rounded corners instead of circle
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
          border: Border.all(
            color: Colors.green.shade200,
            width: 1.5,
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color:
                  backgroundColor == 0 ? Colors.green.shade700 : Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
