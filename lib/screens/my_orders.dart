import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({Key? key}) : super(key: key);

  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
              // <2> Pass `Stream<QuerySnapshot>` to stream
              stream: FirebaseFirestore.instance
                  .collection("users")
                  .doc("smile")
                  .collection("orders")
                  .orderBy("date", descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  // <3> Retrieve `List<DocumentSnapshot>` from snapshot
                  final List<DocumentSnapshot> documents = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: documents.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      DateTime myDateTime = (documents[index]["date"]).toDate();
                      return GestureDetector(
                        onTap: () {},
                        child: Card(
                            color: const Color(0xffd9c593),
                            child: Container(
                              padding: const EdgeInsets.all(15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Order ID : " +
                                        documents[index]["OrderId"].toString(),
                                    style: const TextStyle(
                                        color: Color(0xffaf8f3d),
                                        fontWeight: FontWeight.w700,
                                        fontSize: 17),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Date : " +
                                        myDateTime.day.toString() +
                                        "-" +
                                        myDateTime.month.toString() +
                                        "-" +
                                        myDateTime.year.toString(),
                                    style: const TextStyle(
                                        color: Color(0xffaf8f3d),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15),
                                  ),
                                  Text(
                                    "Payment Type : " +
                                        documents[index]["Payment Type"],
                                    style: const TextStyle(
                                        color: Color(0xffaf8f3d),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Total : " +
                                        documents[index]["Total"].toString(),
                                    style: const TextStyle(
                                        color: Color(0xffaf8f3d),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        "Order Status : " +
                                            documents[index]["orderStatus"],
                                        style: const TextStyle(
                                            color: Color(0xffaf8f3d),
                                            fontWeight: FontWeight.w400,
                                            fontSize: 15),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text("No orders yet!"),
                  );
                }
                return const Center(
                  child: Text("No orders yet!"),
                );
              }),
        ],
      ),
    );
  }
}
