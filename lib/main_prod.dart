import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'config/app/app_configs.dart';
import 'config/firebase/app_firebase.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await AppFirebase.instance.configs(env: "production");
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  FlavorConfig(
      name: "PROD",
      color: Colors.blue,
      variables: {
        "env": "production",
        "baseUrl": "https://www.example.com",
      }
  );
  appInitialization();
}