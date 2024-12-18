import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trainee/configs/themes/main_color.dart';
import 'package:trainee/modules/features/shop/controllers/shop_controller.dart';
import 'package:trainee/modules/features/shop/view/components/chip_shop.dart';
import 'package:trainee/shared/styles/google_text_style.dart';

class ShopBody extends StatelessWidget {
  const ShopBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          height: 10,
        ),
        Text(
          "Shop",
          style: GoogleTextStyle.fw400.copyWith(
            fontSize: 52,
            color: MainColor.white,
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Expanded(
          child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: ShopController.to.shopChip.length,
              separatorBuilder: (context, index) => const SizedBox(
                    height: 10.0,
                    width: 7,
                  ),
              itemBuilder: (context, index) {
                return Obx(
                  () => ChipShop(
                    backgroundColor:
                        ShopController.to.shopIndex.value == index ? 1 : 0,
                    text: ShopController.to.shopChip[index],
                    onTap: () {
                      ShopController.to.changeShopIndex(index);
                    },
                  ),
                );
              }),
        ),
        const SizedBox(
          height: 30,
        ),
        Obx(
          () => Expanded(
            flex: 10,
            child: ShopController.to.getBody(
              ShopController.to.shopIndex.value,
            ),
          ),
        ),
        const SizedBox(
          height: 100,
        )
      ],
    );
  }
}
