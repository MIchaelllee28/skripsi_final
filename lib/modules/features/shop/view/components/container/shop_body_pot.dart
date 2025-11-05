import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:trainee/modules/features/shop/controllers/shop_controller.dart';

class ShopBodyPot extends StatelessWidget {
  const ShopBodyPot({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 3 / 4,
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
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
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 6.0),
                  child: Container(
                    width: 50,
                    height: 50,
                    color: Colors.transparent,
                    child: Image.asset(
                      'assets/images/shop/pita.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              // Product Image
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Obx(
                    () => ShopController.to.potItems.isEmpty
                        ? const CircularProgressIndicator()
                        : Hero(
                            tag: 'pot_$index',
                            child: CachedNetworkImage(
                              height: 120,
                              imageUrl: ShopController.to.potItems[index]
                                  ['image'],
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error, color: Colors.red.shade300),
                              fit: BoxFit.contain,
                            ),
                          ),
                  ),
                ),
              ),

              // Price Tag
              GestureDetector(
                onTap: () {
                  ShopController.to
                      .buyItem(ShopController.to.potItems[index]['id']);
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.green.shade100,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.monetization_on_rounded,
                        color: Colors.green.shade800,
                        size: 20,
                      ),
                      const SizedBox(width: 6),
                      Obx(
                        () => Text(
                          ShopController.to.potItems.isEmpty
                              ? '0'
                              : ShopController.to.potItems[index]['status'] == 1
                                  ? 'Owned'.toString()
                                  : ShopController.to.potItems[index]['harga']
                                      .toString(),
                          style: TextStyle(
                            color: Colors.green.shade900,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
