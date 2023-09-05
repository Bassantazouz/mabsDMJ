import 'package:flutter/material.dart';
import 'package:mapsd/ui/maps/maps.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      routes: {
        Maps.routName: (_) => Maps()
      },
      initialRoute: Maps.routName,
    );
  }
}
