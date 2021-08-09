import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:story_digital/screens/search.dart';

class FloatAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 40,
          right: 10,
          left: 10,
          bottom: 2,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Material(
                  type: MaterialType.transparency,
                  child: IconButton(
                    splashColor: Colors.grey,
                    icon: const Icon(Icons.menu),
                    onPressed: () {
                      // Scaffold.of(context).openDrawer();
                    },
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                        padding: EdgeInsets.zero,
                        icon: const Icon(
                          Icons.search,
                          color: Colors.black,
                          size: 30,
                        ),
                        onPressed: () async {
                          final result = showSearch<String>(
                              context: context, delegate: Search());
                        }),
                    Badge(
                      badgeContent: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection("users")
                              .doc("smile")
                              .collection("cart")
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              final List<DocumentSnapshot> documents =
                                  snapshot.data!.docs;
                              return Text(
                                documents.length.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              );
                            } else if (snapshot.hasError) {
                              return const Text('0');
                            }
                            return const Text("0");
                          }),
                      position: const BadgePosition(top: 3, start: 23),
                      badgeColor: const Color(0xffcc826d),
                      child: IconButton(
                        icon: const Icon(
                          Icons.shopping_cart,
                          color: Colors.black87,
                          size: 30,
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/cart');

                          // Navigator.push(context, MaterialPageRoute(builder: (context) {
                          //   return Cart();
                          // }));
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
