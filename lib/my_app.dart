import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'package:order_search/bindings/binding_controller.dart';
import 'package:order_search/constant/app_constant.dart';
import 'package:order_search/constant/db_constant.dart';
import 'package:order_search/realm/order_picture.dart';
import 'package:order_search/routes/ware_house_scan/view/ware_house_home_screen.dart';
import 'package:order_search/services/database_helper.dart';
import 'package:order_search/services/offlinehelper.dart';
import 'package:toast/toast.dart';

import 'Utils/app_enums.dart';
import 'Utils/utils.dart';
import 'routes/login_screen/view/login_page_new.dart';
import 'routes/splash_screen/view/splash_screen_view.dart';

class MyApp extends StatefulWidget {
  static final navigatorKey = GlobalKey<NavigatorState>();

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    // OfflineHelper.startQueue();
    // DatabaseHelper().realm.all<PicturesQueue>().first.queue.changes.listen((event) {
    //   print("&&&${event}");
    // });
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    _connectionStatus = result;
    print(_connectionStatus);
    if (_connectionStatus == ConnectivityResult.wifi || _connectionStatus == ConnectivityResult.mobile) {
      DBConstants.isOnline.value = true;
    } else if (_connectionStatus == ConnectivityResult.none) {
      DBConstants.isOnline.value = false;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _connectivitySubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return GetMaterialApp(
      routingCallback: (routing) {
        if (routing?.current != AppLinks.signatureRoute) {
          if (mounted) {
            // WidgetsBinding.instance.addObserver();
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Utils.changeOrientation(Orientations.PORTRAIT);
            });
          }
        }
      },
      navigatorObservers: [NavigatorObserver()],
      debugShowCheckedModeBanner: false,
      navigatorKey: MyApp.navigatorKey,
      initialBinding: BindingController(),
      supportedLocales: [
        Locale('en'),
      ],
      localizationsDelegates: [
        CountryLocalizations.delegate,
      ],
      title: 'FleetEnable',
      initialRoute: AppLinks.splashScreenNamedRoute,
      defaultTransition: Transition.noTransition,
      getPages: pages,
      theme: ThemeData(
        androidOverscrollIndicator: AndroidOverscrollIndicator.stretch,
        textTheme: GoogleFonts.interTextTheme(),
        // fontFamily: GoogleFonts.averageSans().toString(),
        pageTransitionsTheme: PageTransitionsTheme(builders: {
          TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
        }),
        primarySwatch: Utils.primaryMaterial,
        buttonTheme: ButtonThemeData(buttonColor: Utils.primaryMaterial, splashColor: Utils.primaryMaterial),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
              splashFactory: InkSplash.splashFactory,
              surfaceTintColor: MaterialStatePropertyAll(Colors.indigo),
              shape: MaterialStatePropertyAll(BeveledRectangleBorder(borderRadius: BorderRadius.circular(4)))),
        ),
      ),
      //home: PermissionHandlerScreen(),
    );
  }

  static const appTransition = Transition.native;

  static const transitionDuration = Duration(milliseconds: 400);

  List<GetPage> pages = [
    GetPage(
        name: AppLinks.splashScreenNamedRoute,
        page: () => SplashScreenView(),
        binding: BindingController(),
        transition: appTransition,
        transitionDuration: transitionDuration),
    //GetPage(name: NamedRoute.permissionsNamedRoute, page: () => PermissionHandlerScreen()),
    GetPage(
        name: AppLinks.loginNamedRoute,
        page: () => LoginPage(),
        transition: appTransition,
        transitionDuration: transitionDuration),
    GetPage(
        name: AppLinks.searchOrderView,
        page: () => ScannedOrderListView(),
        transition: appTransition,
        transitionDuration: transitionDuration),
  ];
}
