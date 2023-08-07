import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grow_up/controller/account_controller.dart';
import 'package:grow_up/controller/menu_controller.dart';
import 'package:grow_up/controller/product_controller.dart';
import 'package:grow_up/util/color_resources.dart';
import 'package:grow_up/util/dimensions.dart';
import 'package:grow_up/util/images.dart';
import 'package:grow_up/util/styles.dart';
import 'package:grow_up/view/base/custom_drawer.dart';
import 'package:grow_up/view/base/title_row.dart';
import 'package:grow_up/view/screens/account_management/account_list_screen.dart';
import 'package:grow_up/view/screens/account_management/widget/account_list_view.dart';
import 'package:grow_up/view/screens/home/widget/revenue_statistics.dart';
import 'package:grow_up/view/screens/home/widget/transaction_chart.dart';
import 'package:grow_up/view/screens/product/widget/limited_product_list_view.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double maxYExpense = 0, maxYIncome = 0;
  double intervalRateExpense = 0, intervalRateIncome = 0;
  double spaceRateExpense = 0, spaceRateIncome = 0;

  @override
  void initState() {
    super.initState();
  }

  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor.withOpacity(.03),
      resizeToAvoidBottomInset: false,
      endDrawer: CustomDrawer(),
      body: SafeArea(
        child: RefreshIndicator(
          color: Theme.of(context).cardColor,
          backgroundColor: Theme.of(context).primaryColor,
          onRefresh: () async {
            return false;
          },
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Center(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 200,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 30,
                              ),
                              Text(
                                "Welcome to",
                                style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.indigo,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Grow Up",
                                style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.amber[900],
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Inventory System ",
                            style: TextStyle(
                                fontSize: 30,
                                color: Colors.indigo,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "By",
                            style: TextStyle(
                                fontSize: 30,
                                color: Colors.indigo,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Abhilash Jena ",
                            style: TextStyle(
                                fontSize: 30,
                                color: Colors.amber[900],
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    GetBuilder<AccountController>(builder: (account) {
                      return account.accountList != null &&
                              account.accountList.length != 0
                          ? Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: Dimensions.PADDING_SIZE_SMALL),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).cardColor),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          Dimensions.PADDING_SIZE_DEFAULT,
                                          Dimensions.PADDING_SIZE_DEFAULT,
                                          Dimensions.PADDING_SIZE_DEFAULT,
                                          Dimensions.PADDING_SIZE_DEFAULT),
                                      child: Row(
                                        children: [
                                          Container(
                                              width: Dimensions.ICON_SIZE_SMALL,
                                              child: Image.asset(
                                                  Images.my_account)),
                                          SizedBox(
                                              width: Dimensions
                                                  .PADDING_SIZE_SMALL),
                                          Expanded(
                                              child: TitleRow(
                                            title: 'my_account'.tr,
                                            onTap: () {
                                              Get.to(AccountListScreen(
                                                  fromAccount: true));
                                            },
                                          )),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: Dimensions.PADDING_SIZE_DEFAULT,
                                    bottom: Dimensions.PADDING_SIZE_SMALL,
                                    right: Dimensions.PADDING_SIZE_DEFAULT,
                                  ),
                                  child: Row(
                                    children: [
                                      Text('#'),
                                      SizedBox(
                                          width: Dimensions.PADDING_SIZE_LARGE),
                                      Expanded(
                                          flex: 8,
                                          child: Text(
                                            '${'account'.tr}',
                                            style: fontSizeMedium.copyWith(
                                                fontSize:
                                                    Dimensions.FONT_SIZE_LARGE,
                                                color: ColorResources
                                                    .getTitleColor()),
                                          )),
                                      Text(
                                        '${'balance'.tr}',
                                        style: fontSizeMedium.copyWith(
                                            fontSize:
                                                Dimensions.FONT_SIZE_LARGE,
                                            color:
                                                ColorResources.getTitleColor()),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                    padding: EdgeInsets.only(
                                        top: Dimensions.PADDING_SIZE_SMALL,
                                        bottom: Dimensions.PADDING_SIZE_SMALL),
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).cardColor),
                                    child: AccountListView(
                                        scrollController: _scrollController,
                                        isHome: true)),
                              ],
                            )
                          : SizedBox();
                    }),
                    GetBuilder<ProductController>(builder: (stockOutProduct) {
                      return stockOutProduct.limitedStockProductList != null &&
                              stockOutProduct.limitedStockProductList.length !=
                                  0
                          ? Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: Dimensions.PADDING_SIZE_SMALL),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).cardColor),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          Dimensions.PADDING_SIZE_DEFAULT,
                                          Dimensions.PADDING_SIZE_DEFAULT,
                                          Dimensions.PADDING_SIZE_DEFAULT,
                                          Dimensions.PADDING_SIZE_DEFAULT),
                                      child: Row(
                                        children: [
                                          Container(
                                              width: Dimensions.ICON_SIZE_SMALL,
                                              child: Image.asset(
                                                  Images.limited_stock)),
                                          SizedBox(
                                              width: Dimensions
                                                  .PADDING_SIZE_SMALL),
                                          Expanded(
                                              child: TitleRow(
                                            title: 'limited_stocks'.tr,
                                            onTap: () {
                                              Get.find<MenuController>()
                                                  .selectStockOutProductList();
                                            },
                                          )),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: Dimensions.PADDING_SIZE_DEFAULT,
                                      bottom: Dimensions.PADDING_SIZE_SMALL,
                                      right: Dimensions.PADDING_SIZE_DEFAULT),
                                  child: Row(
                                    children: [
                                      Text('#'),
                                      SizedBox(
                                          width: Dimensions.PADDING_SIZE_LARGE),
                                      Expanded(
                                          flex: 9,
                                          child: Text(
                                            '${'product_name'.tr}',
                                            style: fontSizeMedium.copyWith(
                                                fontSize:
                                                    Dimensions.FONT_SIZE_LARGE,
                                                color: ColorResources
                                                    .getTitleColor()),
                                          )),
                                      Text(
                                        '${'qty'.tr}',
                                        style: fontSizeMedium.copyWith(
                                            fontSize:
                                                Dimensions.FONT_SIZE_LARGE,
                                            color:
                                                ColorResources.getTitleColor()),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                    padding: EdgeInsets.only(
                                        top: Dimensions.PADDING_SIZE_SMALL,
                                        bottom: Dimensions
                                            .PADDING_SIZE_EXTRA_LARGE),
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).cardColor),
                                    child: LimitedStockProductListView(
                                        scrollController: _scrollController,
                                        isHome: true)),
                              ],
                            )
                          : SizedBox();
                    }),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SliverDelegate extends SliverPersistentHeaderDelegate {
  Widget child;
  SliverDelegate({@required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 70;

  @override
  double get minExtent => 70;

  @override
  bool shouldRebuild(SliverDelegate oldDelegate) {
    return oldDelegate.maxExtent != 70 ||
        oldDelegate.minExtent != 70 ||
        child != oldDelegate.child;
  }
}
