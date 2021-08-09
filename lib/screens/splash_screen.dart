import 'dart:async';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    displaySplash();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // Color(0xffccb16d),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.35,
          ),
          Expanded(
            child: Align(
              alignment: FractionalOffset.center,
              child: ZoomIn(
                duration: const Duration(seconds: 4),
                child: Image.asset(
                  "assets/icons/logo.png",
                ),
              ),
            ),
          ),
          const Expanded(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: CircularProgressIndicator(
                backgroundColor: Colors.black,
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  Future<Timer> displaySplash() async {
    return Timer(const Duration(seconds: 5), onDoneLoading);
  }

  onDoneLoading() async {
    Navigator.pushReplacementNamed(context, '/home');
  }
}
