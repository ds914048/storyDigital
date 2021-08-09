import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:story_digital/screens/cart.dart';
import 'package:story_digital/screens/home.dart';
import 'package:story_digital/screens/place_order.dart';
import 'package:story_digital/screens/splash_screen.dart';

Future<void> main() async {
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          backgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            elevation: 0,
            centerTitle: true,
            color: Color(0xff28d6c0),
          )),
      initialRoute: '/',
      routes: {
        /// When navigating to the "/" route, build the FirstScreen widget that is SplashPage.
        '/': (context) => SplashScreen(),

        /// When navigating to the "/Home" route, build the Home of our app.
        '/home': (context) => const Home(),

        /// When navigating to the "/cart" route, build the cart screen of our app.
        '/cart': (context) => const Cart(),

        /// When navigating to the "/placeOrder" route, build the placeOrder screen of our app.
        '/placeOrder': (context) => const PlaceOrder(),

      },
    ),
  );

}