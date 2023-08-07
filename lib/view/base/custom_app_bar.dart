import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grow_up/controller/cart_controller.dart';
import 'package:grow_up/controller/menu_controller.dart';
import 'package:grow_up/util/dimensions.dart';
import 'package:grow_up/util/images.dart';
import 'package:grow_up/util/styles.dart';
import 'package:grow_up/view/base/custom_ink_well.dart';
import 'package:grow_up/view/screens/dashboard/nav_bar_screen.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isBackButtonExist;
  CustomAppBar({this.isBackButtonExist = true});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).cardColor,
      titleSpacing: 0,
      elevation: 5,
      leadingWidth: isBackButtonExist ? 50 : 120,
      leading: isBackButtonExist
          ? Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_SMALL),
              child: CustomInkWell(
                onTap: () => Get.back(),
                child: Icon(Icons.arrow_back_sharp,
                    color: Theme.of(context).primaryColor, size: 25),
              ),
            )
          : Padding(
              padding:
                  const EdgeInsets.only(left: Dimensions.FONT_SIZE_EXTRA_SMALL),
              child: InkWell(
                  onTap: () => Get.find<MenuController>().selectHomePage(),
                  child: Image.asset(Images.logo_with_name,
                      width: 120, height: 30)),
            ),
      title: Text(''),
      actions: [
        Builder(builder: (context) {
          return IconButton(
            onPressed: () => Scaffold.of(context).openEndDrawer(),
            icon: Icon(Icons.menu_outlined,
                color: Theme.of(context).primaryColor),
          );
        }),
      ],
    );
  }

  @override
  Size get preferredSize =>
      Size(Dimensions.WEB_MAX_WIDTH, GetPlatform.isDesktop ? 70 : 50);
}
