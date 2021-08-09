import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:story_digital/commonWidgets/flot_appbar.dart';
import 'package:story_digital/screens/explore.dart';
import 'package:story_digital/screens/my_orders.dart';

import 'adminScreens/add_books.dart';
// import 'package:ff_navigation_bar/ff_navigation_bar.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<bool> _exit() async {
    bool _ret = false;
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: const Text(
                'Are you sure?',
                style: TextStyle(
                  color: Colors.black87,
                ),
              ),
              content: const SingleChildScrollView(
                child: Text(
                  'Do you want to exit the app',
                  style: TextStyle(
                    color: Colors.black87,
                  ),
                ),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      setState(() {
                        _ret = false;
                      });
                    },
                    child: const Text('No')),
                TextButton(
                    onPressed: () {
                      setState(() {
                        _ret = true;
                      });
                      SystemChannels.platform
                          .invokeMethod('SystemNavigator.pop');
                    },
                    child: const Text('Yes')),
              ],
            ));
    return _ret;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _exit(),
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: FloatAppBar(),
        body: SizedBox.expand(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
            },
            children: <Widget>[
              Explore(),
              MyOrders(),
              AddBook(),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavyBar(
          selectedIndex: _currentIndex,
          onItemSelected: (index) {
            setState(() => _currentIndex = index);
            _pageController.jumpToPage(index);
          },
          items: <BottomNavyBarItem>[
            BottomNavyBarItem(
                activeColor: Colors.brown,
                inactiveColor: const Color(0xffcc826d),
                title: const Text('Explore'),
                icon: const Icon(Icons.home)),
            BottomNavyBarItem(
                activeColor: Colors.brown,
                inactiveColor: const Color(0xffcc826d),
                title: const Text('My orders'),
                icon: const Icon(Icons.history)),
            BottomNavyBarItem(
                activeColor: Colors.brown,
                inactiveColor: const Color(0xffcc826d),
                title: const Text('Add Product'),
                icon: const Icon(Icons.note_add_outlined)),
          ],
        ),
      ),
    );
  }
}
