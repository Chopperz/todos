import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GlobalKey<NavigatorState> navigatorKey =
    GlobalKey<NavigatorState>(debugLabel: "app-global-navigator-key");

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>(debugLabel: "app-global-scaffold-messenger-key");

late SharedPreferences sharedPreferences;

late String appDirectoryPath;

const String USER_TOKEN_KEY = "user-token-key";
const String IS_REMEMBER_ME_KEY = "remember-me-key";
