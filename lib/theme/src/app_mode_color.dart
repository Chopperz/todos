part of '../app_theme.dart';

mixin _ThemeModeColor {
   ThemeData get light => ThemeData.light(
     useMaterial3: true,
     // colorScheme: ColorScheme.fromSeed(
     //   primary: Colors.indigoAccent,
     //   seedColor: Colors.deepPurple,
     //   inversePrimary: Colors.indigoAccent.shade400,
     //   secondary: Colors.indigo,
     // ),
     // scaffoldBackgroundColor: Colors.grey.shade100,
   );

   ThemeData get dark => ThemeData.dark(
     useMaterial3: true,
   );
}