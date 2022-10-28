import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:stock_market_simulator/screens/mainPage/mainPageBackground/mainPageBackground.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Stock market simulator',
    theme: ThemeData(
      scaffoldBackgroundColor: Color(0xff191b26),
      appBarTheme: AppBarTheme(
        color: Colors.transparent,
        elevation: 00,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color:  Color(0xffff6d00),
          fontFamily: 'Inter',
          fontSize: 40,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(
          color: Color(0xffff3c0e),
          size: 40,
        )
      ),
      textTheme: const TextTheme(
          subtitle1: TextStyle(color: Color(0xffff6d00), fontWeight: FontWeight.bold),
          subtitle2: TextStyle(color: Color(0xffff6d00), fontWeight: FontWeight.bold),
          bodyText1: TextStyle(color: Color(0xffff6d00), fontWeight: FontWeight.bold),
          bodyText2: TextStyle(color: Color(0xffff6d00), fontWeight: FontWeight.bold)
      ),
      fontFamily: 'Inter',
      elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(primary: Color(0xffff3c0e))),
    ),
    // initialRoute: 'SignUp',
    // routes: {
    //   'SignUp': (context) => SignUp(),
    //   'SignIn': (context) => SignIn(),
    // },
    home: MainPageBackground(),
  ));
}
