import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'views/homePage/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final directory = await getApplicationSupportDirectory();
  //print("Application Support Directory: ${directory.path}");
  runApp(ProviderScope(child:MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ERP App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
    );
  }
}
