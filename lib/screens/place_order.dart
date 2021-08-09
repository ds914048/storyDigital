import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlaceOrder extends StatefulWidget {
  const PlaceOrder({Key? key}) : super(key: key);

  @override
  _PlaceOrderState createState() => _PlaceOrderState();
}

class _PlaceOrderState extends State<PlaceOrder> {
  String orderId = DateTime.now().microsecondsSinceEpoch.toString();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Center(
                child: Icon(
                  Icons.check_circle_outline,
                  color: Colors.lightGreen,
                  size: 150,
                ),
              ),
              Text(
                "Your Order is Confirmed!!",
                style: TextStyle(fontSize: 26),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Thanks For Your Order",
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
          SizedBox(
            height: 60,
            width: 200,
            child: TextButton(
                style: TextButton.styleFrom(
                    elevation: 1,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(35))),
                    // BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                    primary: Colors.white,
                    backgroundColor: Colors.lightGreen,
                    textStyle: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w600)),
                child: const Text(
                  'Done',
                  style: TextStyle(fontSize: 25),
                ),
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, "/home", (route) => false);
                }),
          ),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}
