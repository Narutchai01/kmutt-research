import 'package:client/background_service.dart';
import 'package:dio/dio.dart';

import 'package:client/presentation/login_screen/login_screen.dart';
import 'package:client/presentation/model/token_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import 'core/app_export.dart';

var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();
var haveToken = false;
get baseURL {
  String baseUrl = "https://kmutt-api.onrender.com/api";
  return baseUrl;
}

final Dio dio = Dio(BaseOptions(
  connectTimeout: Duration(
      milliseconds:
          10000), // Set the connection timeout to 10 seconds (adjust as needed)
));
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Permission.notification.isDenied.then((value) => {
        if (value) {Permission.notification.request()}
      });
  await initializeBackgroundService();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  ///Please update theme as per your need if required.
  ThemeHelper().changeTheme('primary');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return Provider(
          create: (_) => TokenModel(token: ''),
          child: MaterialApp(
            theme: theme,
            debugShowCheckedModeBanner: false,
            home: LoginScreen(),
            routes: AppRoutes.routes,
          ),
        );
      },
    );
  }
}
