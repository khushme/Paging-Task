import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paging_master/screens/main_screen/main_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      enableLog: true,
      initialRoute: "/",
      getPages: [
        GetPage(
            name: "/", page: () => MainScreen())
      ],
    
    );
  }
}
