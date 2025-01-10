import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trainee/modules/features/shop/controllers/shop_controller.dart';

class ShopBodyBackround extends StatelessWidget {
  const ShopBodyBackround({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          crossAxisSpacing: 100,
          mainAxisSpacing: 50,
          childAspectRatio: 3 / 4,
        ),
        itemCount: 3,
        itemBuilder: (context, index) {
          return Obx(
            () => ShopController.to.backroundItems.isEmpty
                ? const CircularProgressIndicator(
                    strokeWidth: 1,
                    value: 4,
                  )
                : Container(
                    decoration: BoxDecoration(
                      color: ShopController.to.backroundItems.isEmpty
                          ? Colors.red
                          : ShopController.to.parseBackgroundColor(
                              ShopController.to.backroundItems[index]
                                  ['deskripsi']),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            width: 50,
                            height: 50,
                            color: Colors.transparent,
                            child: Image.asset(
                              'lib/assets/images/shop/pita.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 100,
                        ),
                        // Background Name
                        Obx(
                          () => Text(
                            ShopController.to.backroundItems.isEmpty
                                ? 'Loading...'
                                : ShopController.to.backroundItems[index]
                                        ['nama'] ??
                                    'Background',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  blurRadius: 10.0,
                                  color: Colors.black54,
                                  offset: Offset(2.0, 2.0),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Price Tag
                        GestureDetector(
                          onTap: () {
                            ShopController.to.buyItem(
                                ShopController.to.backroundItems[index]['id']);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                            decoration: BoxDecoration(
                              color: Colors.green.shade100,
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Coin/Price Icon
                                Icon(
                                  Icons.monetization_on_rounded,
                                  color: Colors.green.shade800,
                                  size: 30,
                                ),
                                const SizedBox(width: 10),
                                Obx(
                                  () => Text(
                                    ShopController.to.backroundItems.isEmpty
                                        ? '0'
                                        : ShopController.to
                                                        .backroundItems[index]
                                                    ['status'] ==
                                                1
                                            ? 'Owned'
                                            : ShopController.to
                                                .backroundItems[index]['harga']
                                                .toString(),
                                    style: TextStyle(
                                      color: Colors.green.shade900,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }
}
