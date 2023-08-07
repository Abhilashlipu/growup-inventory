import 'dart:convert';

import 'package:grow_up/controller/account_controller.dart';
import 'package:grow_up/controller/auth_controller.dart';
import 'package:grow_up/controller/brand_controller.dart';
import 'package:grow_up/controller/cart_controller.dart';
import 'package:grow_up/controller/category_controller.dart';
import 'package:grow_up/controller/coupon_controller.dart';
import 'package:grow_up/controller/customer_controller.dart';
import 'package:grow_up/controller/expense_controller.dart';
import 'package:grow_up/controller/income_controller.dart';
import 'package:grow_up/controller/language_controller.dart';
import 'package:grow_up/controller/localization_controller.dart';
import 'package:grow_up/controller/menu_controller.dart';
import 'package:grow_up/controller/order_controller.dart';
import 'package:grow_up/controller/pos_controller.dart';
import 'package:grow_up/controller/product_controller.dart';
import 'package:grow_up/controller/splash_controller.dart';
import 'package:grow_up/controller/supplier_controller.dart';
import 'package:grow_up/controller/theme_controller.dart';
import 'package:grow_up/controller/transaction_controller.dart';
import 'package:grow_up/controller/unit_controller.dart';
import 'package:grow_up/data/repository/account_repo.dart';
import 'package:grow_up/data/repository/auth_repo.dart';
import 'package:grow_up/data/repository/brand_repo.dart';
import 'package:grow_up/data/repository/cart_repo.dart';
import 'package:grow_up/data/repository/category_repo.dart';
import 'package:grow_up/data/repository/coupon_repo.dart';
import 'package:grow_up/data/repository/customer_repo.dart';
import 'package:grow_up/data/repository/expense_repo.dart';
import 'package:grow_up/data/repository/income_repo.dart';
import 'package:grow_up/data/repository/language_repo.dart';
import 'package:grow_up/data/repository/order_repo.dart';
import 'package:grow_up/data/repository/pos_repo.dart';
import 'package:grow_up/data/repository/product_repo.dart';
import 'package:grow_up/data/repository/splash_repo.dart';
import 'package:grow_up/data/api/api_client.dart';
import 'package:grow_up/data/repository/supplier_repo.dart';
import 'package:grow_up/data/repository/transaction_repo.dart';
import 'package:grow_up/data/repository/unit_repo.dart';
import 'package:grow_up/util/app_constants.dart';
import 'package:grow_up/data/model/response/language_model.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

Future<Map<String, Map<String, String>>> init() async {
  // Core
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => ApiClient(
      appBaseUrl: AppConstants.BASE_URL, sharedPreferences: Get.find()));

  // Repository
  Get.lazyPut(
      () => SplashRepo(sharedPreferences: Get.find(), apiClient: Get.find()));
  Get.lazyPut(() => LanguageRepo());
  Get.lazyPut(
      () => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => OrderRepo(apiClient: Get.find()));
  Get.lazyPut(() => CategoryRepo(apiClient: Get.find()));
  Get.lazyPut(() => UnitRepo(apiClient: Get.find()));
  Get.lazyPut(() => BrandRepo(apiClient: Get.find()));
  Get.lazyPut(() => ProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => SupplierRepo(apiClient: Get.find()));
  Get.lazyPut(() => AccountRepo(apiClient: Get.find()));
  Get.lazyPut(() => ExpenseRepo(apiClient: Get.find()));
  Get.lazyPut(() => CustomerRepo(apiClient: Get.find()));
  Get.lazyPut(() => CouponRepo(apiClient: Get.find()));
  Get.lazyPut(
      () => CartRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => PosRepo(apiClient: Get.find()));
  Get.lazyPut(() => TransactionRepo(apiClient: Get.find()));
  Get.lazyPut(() => IncomeRepo(apiClient: Get.find()));

  // Controller
  Get.lazyPut(() => ThemeController(sharedPreferences: Get.find()));
  Get.lazyPut(() => SplashController(splashRepo: Get.find()));
  Get.lazyPut(() => LocalizationController(sharedPreferences: Get.find()));
  Get.lazyPut(() => LanguageController(sharedPreferences: Get.find()));
  Get.lazyPut(() => MenuController());
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => OrderController(orderRepo: Get.find()));
  Get.lazyPut(() => CategoryController(categoryRepo: Get.find()));
  Get.lazyPut(() => UnitController(unitRepo: Get.find()));
  Get.lazyPut(() => BrandController(brandRepo: Get.find()));
  Get.lazyPut(() => ProductController(productRepo: Get.find()));
  Get.lazyPut(() => SupplierController(supplierRepo: Get.find()));
  Get.lazyPut(() => AccountController(accountRepo: Get.find()));
  Get.lazyPut(() => ExpenseController(expenseRepo: Get.find()));
  Get.lazyPut(() => CustomerController(customerRepo: Get.find()));
  Get.lazyPut(() => CouponController(couponRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
  Get.lazyPut(() => PosController(posRepo: Get.find()));
  Get.lazyPut(() => TransactionController(transactionRepo: Get.find()));
  Get.lazyPut(() => IncomeController(incomeRepo: Get.find()));

  Map<String, Map<String, String>> _languages = Map();
  for (LanguageModel languageModel in AppConstants.languages) {
    String jsonStringValues = await rootBundle
        .loadString('assets/language/${languageModel.languageCode}.json');
    Map<String, dynamic> _mappedJson = json.decode(jsonStringValues);
    Map<String, String> _json = Map();
    _mappedJson.forEach((key, value) {
      _json[key] = value.toString();
    });
    _languages['${languageModel.languageCode}_${languageModel.countryCode}'] =
        _json;
  }
  return _languages;
}
