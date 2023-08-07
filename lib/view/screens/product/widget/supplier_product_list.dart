import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grow_up/controller/supplier_controller.dart';
import 'package:grow_up/data/model/response/product_model.dart';
import 'package:grow_up/util/dimensions.dart';
import 'package:grow_up/view/base/no_data_screen.dart';
import 'package:grow_up/view/screens/product/widget/product_card_widget.dart';

class SupplierProductListView extends StatelessWidget {
  final int supplierId;
  final ScrollController scrollController;
  const SupplierProductListView(
      {Key key, this.scrollController, this.supplierId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int offset = 1;
    scrollController?.addListener(() {
      if (scrollController.position.maxScrollExtent ==
              scrollController.position.pixels &&
          Get.find<SupplierController>().supplierProductList.length != 0 &&
          !Get.find<SupplierController>().isLoading) {
        int pageSize;
        pageSize = Get.find<SupplierController>().supplierProductListLength;

        if (offset < pageSize) {
          offset++;
          print('end of the page');
          Get.find<SupplierController>().showBottomLoader();
          Get.find<SupplierController>()
              .getSupplierProductList(offset, supplierId);
        }
      }
    });

    return GetBuilder<SupplierController>(
      builder: (supplierProductController) {
        List<Products> productList;
        productList = supplierProductController.supplierProductList;

        return Column(children: [
          !supplierProductController.isFirst
              ? productList.length != null
                  ? productList.length != 0
                      ? ListView.builder(
                          itemCount: productList.length,
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (ctx, index) {
                            return ProductCardViewWidget(
                                product: productList[index]);
                          })
                      : NoDataScreen()
                  : SizedBox.shrink()
              : SizedBox(),
          supplierProductController.isLoading
              ? Center(
                  child: Padding(
                  padding: EdgeInsets.all(Dimensions.ICON_SIZE_EXTRA_SMALL),
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).primaryColor)),
                ))
              : SizedBox.shrink(),
        ]);
      },
    );
  }
}
