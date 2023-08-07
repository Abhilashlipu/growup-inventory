import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grow_up/util/images.dart';
import 'package:grow_up/view/base/custom_app_bar.dart';
import 'package:grow_up/view/base/custom_category_button.dart';
import 'package:grow_up/view/base/custom_drawer.dart';
import 'package:grow_up/view/screens/product/product_view_screen.dart';
import 'package:grow_up/view/screens/product_setup_screen/add_product_screen.dart';
import 'package:grow_up/view/screens/product_setup_screen/product_bulk_export.dart';
import 'package:grow_up/view/screens/product_setup_screen/product_bulk_import.dart';

class ProductSetupScreen extends StatelessWidget {
  const ProductSetupScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * .12;
    return Scaffold(
      appBar: CustomAppBar(),
      endDrawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomCategoryButton(
                buttonText: 'product_list'.tr,
                icon: Images.product_setup,
                isSelected: false,
                isDrawer: false,
                padding: width,
                onTap: () => Get.to(ProductScreen())),
            CustomCategoryButton(
                buttonText: 'add_new_product'.tr,
                icon: Images.add_category_icon,
                isSelected: false,
                onTap: () => Get.to(AddProductScreen()),
                padding: width,
                isDrawer: false),
          ],
        ),
      ),
    );
  }
}
