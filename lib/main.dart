import 'dart:async';
import 'dart:io';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:grow_up/controller/localization_controller.dart';
import 'package:grow_up/controller/theme_controller.dart';
import 'package:grow_up/helper/notification_helper.dart';
import 'package:grow_up/helper/route_helper.dart';
import 'package:grow_up/theme/dark_theme.dart';
import 'package:grow_up/theme/light_theme.dart';
import 'package:grow_up/util/app_constants.dart';
import 'package:grow_up/util/messages.dart';
import 'package:grow_up/view/screens/root/not_found_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:url_strategy/url_strategy.dart';
import 'helper/get_di.dart' as di;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  if (GetPlatform.isIOS || GetPlatform.isAndroid) {
    HttpOverrides.global = new MyHttpOverrides();
  }
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FlutterDownloader.initialize(debug: true, ignoreSsl: true);
  Map<String, Map<String, String>> _languages = await di.init();

  int _orderID;
  try {
    if (GetPlatform.isMobile) {
      final NotificationAppLaunchDetails notificationAppLaunchDetails =
          await flutterLocalNotificationsPlugin
              .getNotificationAppLaunchDetails();
      if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
        _orderID = notificationAppLaunchDetails.payload != null
            ? int.parse(notificationAppLaunchDetails.payload)
            : null;
      }
      await NotificationHelper.initialize(flutterLocalNotificationsPlugin);
      FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);
    }
  } catch (e) {}

  runApp(MyApp(languages: _languages, orderID: _orderID));
}

class MyApp extends StatelessWidget {
  final Map<String, Map<String, String>> languages;
  final int orderID;
  MyApp({@required this.languages, @required this.orderID});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (themeController) {
        return GetBuilder<LocalizationController>(
          builder: (localizeController) {
            return GetMaterialApp(
              title: AppConstants.APP_NAME,
              debugShowCheckedModeBanner: false,
              navigatorKey: Get.key,
              theme: themeController.darkTheme ? dark : light,
              locale: localizeController.locale,
              translations: Messages(languages: languages),
              fallbackLocale: Locale(AppConstants.languages[0].languageCode,
                  AppConstants.languages[0].countryCode),
              initialRoute: RouteHelper.splash,
              getPages: RouteHelper.routes,
              unknownRoute: GetPage(name: '/', page: () => NotFoundScreen()),
              defaultTransition: Transition.topLevel,
              transitionDuration: Duration(milliseconds: 500),
            );
          },
        );
      },
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
