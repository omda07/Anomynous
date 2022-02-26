import 'package:flapkap/provider/myHomePageProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/homePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MyHomePageProvider>(
      create: (context) => MyHomePageProvider(),
      child: Consumer<MyHomePageProvider>(
        builder: (context, provider, child){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'FlapKap',
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.white,
              primarySwatch: Colors.purple,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: MyHomePage(),
          );
        },

      ),
    );
  }
}
