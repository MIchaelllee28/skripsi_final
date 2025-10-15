import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SuccessDialog extends StatelessWidget {
  final String? title, description, btnText;
  const SuccessDialog({super.key, this.title, this.description, this.btnText});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 60),
            16.verticalSpace,
            Text(
              title ?? "Purchase Successful!",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            8.verticalSpace,
            Text(description ?? "Thank you for your purchase!"),
            16.verticalSpace,
            GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Text(
                  btnText ?? "Continue Shopping",
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
