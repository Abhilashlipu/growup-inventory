import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grow_up/data/api/api_client.dart';
import 'package:grow_up/util/app_constants.dart';

class OrderRepo {
  ApiClient apiClient;
  OrderRepo({@required this.apiClient});

  Future<Response> getOrderList(String offset) async {
    return await apiClient
        .getData('${AppConstants.ORDER_LIST}?limit=10&offset=$offset');
  }

  Future<Response> getInvoiceData(int orderId) async {
    return await apiClient.getData('${AppConstants.INVOICE}?order_id=$orderId');
  }
}
