import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trainee/shared/styles/google_text_style.dart';

class InsufficientFundsDialog extends StatelessWidget {
  final int requiredCoins;
  final int currentCoins;

  const InsufficientFundsDialog({
    Key? key,
    required this.requiredCoins,
    required this.currentCoins,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final shortage = requiredCoins - currentCoins;

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFFFFEBEE),
          border: Border.all(
            color: const Color(0xFFD32F2F),
            width: 4,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              offset: const Offset(4, 4),
              blurRadius: 0,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFD32F2F),
                border: Border.all(
                  color: const Color(0xFFB71C1C),
                  width: 3,
                ),
              ),
              child: const Icon(
                Icons.money_off,
                size: 50,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 20),

            // Title
            Text(
              'Not Enough Coins!',
              style: GoogleTextStyle.fw700.copyWith(
                fontSize: 24,
                color: const Color(0xFFD32F2F),
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 16),

            // Coin info
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: const Color(0xFFD32F2F),
                  width: 2,
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'You have:',
                        style: GoogleTextStyle.fw400.copyWith(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.monetization_on,
                            color: Color(0xFFF57C00),
                            size: 20,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            currentCoins.toString(),
                            style: GoogleTextStyle.fw600.copyWith(
                              fontSize: 18,
                              color: const Color(0xFFF57C00),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'You need:',
                        style: GoogleTextStyle.fw400.copyWith(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.monetization_on,
                            color: Color(0xFFD32F2F),
                            size: 20,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            requiredCoins.toString(),
                            style: GoogleTextStyle.fw600.copyWith(
                              fontSize: 18,
                              color: const Color(0xFFD32F2F),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Divider(height: 16, thickness: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Short by:',
                        style: GoogleTextStyle.fw400.copyWith(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.remove_circle,
                            color: Color(0xFFD32F2F),
                            size: 20,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            shortage.toString(),
                            style: GoogleTextStyle.fw700.copyWith(
                              fontSize: 18,
                              color: const Color(0xFFD32F2F),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Tips
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF9C4),
                border: Border.all(
                  color: const Color(0xFFF57C00),
                  width: 2,
                ),
              ),
              child: Column(
                children: [
                  Text(
                    'How to Get Coins:',
                    style: GoogleTextStyle.fw600.copyWith(
                      fontSize: 16,
                      color: const Color(0xFFF57C00),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '• Water your plant daily\n• Spin the Lucky Wheel\n• Complete challenges',
                    style: GoogleTextStyle.fw400.copyWith(
                      fontSize: 14,
                      color: Colors.black87,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Close button
            GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFD32F2F),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: const Color(0xFFB71C1C),
                    width: 3,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      offset: const Offset(3, 3),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: Text(
                  'OK',
                  style: GoogleTextStyle.fw600.copyWith(
                    fontSize: 18,
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
