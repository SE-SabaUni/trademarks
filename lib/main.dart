import 'package:content_app/utils/Themes.dart';

import 'package:content_app/view/screen/auth/auth.dart';
import 'package:content_app/view/screen/bar.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'logic/bindings/binding.dart';

late SharedPreferences sharedPreference;
late SharedPreferences SuggestionsSearch;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreference = await SharedPreferences.getInstance();
  SuggestionsSearch = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,

      theme: Themes.LightTheme,
      // darkTheme: Themes.darkTheme,
      initialBinding: myBinding(),
      home: Bar(),
    );
  }
}
