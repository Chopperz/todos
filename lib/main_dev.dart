import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'config/app/app_configs.dart';
import 'config/firebase/app_firebase.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await AppFirebase.instance.configs();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  FlavorConfig(
      name: "DEV",
      color: Colors.red,
      location: BannerLocation.topStart,
      variables: {
        "env": "development",
        "baseUrl": "https://jsonplaceholder.typicode.com",
      }
  );
  appInitialization();
}
