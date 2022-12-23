import 'package:flutter/material.dart';
import 'package:sioc_scanner/Api/sheets_api.dart';
import 'Screens/home.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AssetsSheetsApi.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}
