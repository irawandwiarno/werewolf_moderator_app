import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ww_moderator/modules/game_screen/game_binding.dart';
import 'package:ww_moderator/modules/game_screen/game_screen_view.dart';
import 'exports.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // var dbRes = await MangaDatabase().database;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: HomeView(),
      getPages: AppRoutes.pages,
      initialBinding: HomeBinding(),
    );
  }
}
