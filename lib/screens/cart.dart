import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';
class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  void initState() {
      super.initState();
      getCartItems();
  }
  double orderTotal=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Cart',
          style: TextStyle(fontSize: 20),
        ),
        backgroundColor: Colors.brown,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
              /// Pass `Stream<QuerySnapshot>` to stream
                stream: FirebaseFirestore.instance
                    .collection("users")
                    .doc('smile')
                    .collection("cart")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    /// Retrieve `List<DocumentSnapshot>` from snapshot
                    final List<DocumentSnapshot> documents = snapshot.data!.docs;
                    // emptyCart
                    return documents.isEmpty?Center(child: Padding(
                      padding: const EdgeInsets.only(top: 48.0),
                      child: Image.asset("assets/images/emptyCart.png"),
                    )):ListView.builder(
                      itemCount: documents.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        // return Text(documents[index]["product_name"]);
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: SizedBox(
                              height: 100,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  AspectRatio(
                                    aspectRatio: 1.0,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(15.0),
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                            documents[index]["images"],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20.0, 0.0, 2.0, 0.0),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Expanded(
                                            flex: 1,
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  documents[index]
                                                  ["Book_name"],
                                                  maxLines: 4,
                                                  overflow:
                                                  TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),

                                                // Text(
                                                //   documents[index]
                                                //   ["description"],
                                                //   maxLines: 2,
                                                //   overflow:
                                                //   TextOverflow.ellipsis,
                                                //   style: const TextStyle(
                                                //     fontSize: 12.0,
                                                //     color: Colors.black54,
                                                //   ),
                                                // ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                              MainAxisAlignment.end,
                                              children: <Widget>[
                                                Text(
                                                  documents[index]
                                                  ["author"],
                                                  style: const TextStyle(
                                                    fontSize: 12.0,
                                                    color: Colors.black87,
                                                  ),
                                                ),
                                                Text(
                                                  'Price: ' +
                                                      documents[index]
                                                      ["price"]
                                                          .toString() +
                                                      ' rupees',
                                                  style: const TextStyle(
                                                    fontSize: 12.0,
                                                    color: Colors.black54,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10.0, 0.0, 2.0, 0.0),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            height: 30,
                                            width: 103,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: const Color(0xffb8cc6d),
                                                width: 1.5,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(10),
                                            ),
                                            child: Row(
                                              children: <Widget>[
                                                GestureDetector(
                                                  onTap: () {
                                                    decreaseItemInCart( documents[index]["bookId"], context);

                                                  },
                                                  child: Container(
                                                    decoration: const BoxDecoration(
                                                      borderRadius:
                                                      BorderRadius.only(
                                                        topLeft:
                                                        Radius.circular(8),
                                                        bottomLeft:
                                                        Radius.circular(8),
                                                      ),
                                                      color: Color(0xffb8cc6d),
                                                      // Color(0xffe0cfa6),
                                                    ),
                                                    width: 35,
                                                    height: 30,
                                                    child: const Icon(
                                                      Icons.remove,
                                                      size: 25,
                                                      color:
                                                      Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  child: Text(
                                                    documents[index]
                                                    ["Quantity"]
                                                        .toString(),
                                                    // product.quantity.toString(),
                                                    textAlign: TextAlign.center,
                                                    // style: kProductNameTextStyle,
                                                  ),
                                                  width: 30,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    increaseItemInCart( documents[index]["bookId"], context);
                                                  },
                                                  child: Container(
                                                    width: 35,
                                                    height: 30,
                                                    decoration: const BoxDecoration(
                                                      borderRadius:
                                                      BorderRadius.only(
                                                        topRight:
                                                        Radius.circular(8),
                                                        bottomRight:
                                                        Radius.circular(8),
                                                      ),
                                                      color: Color(0xffb8cc6d),
                                                    ),
                                                    child: const Icon(
                                                      Icons.add,
                                                      size: 25,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),

                                          Expanded(
                                            flex: 1,
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                              MainAxisAlignment.end,
                                              children: <Widget>[
                                                IconButton(
                                                  icon: const Icon(Icons.delete),
                                                  iconSize: 24.0,
                                                  color: const Color(0xffcc6d88),
                                                  onPressed: (){
                                                    FirebaseFirestore.instance.collection("users").doc('smile').collection("cart").doc(documents[index]["bookId"]).delete();
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return const Text('It\'s Error!');
                  }
                  return const Text("Add Product");
                }),
            const SizedBox(
              height: 150,
            )
          ],
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(5),
        width: double.infinity,
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("users")
                    .doc('smile')
                    .collection("cart")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final List<DocumentSnapshot> documents = snapshot.data!.docs;
                    return Text(
                      "Total Book's: " + documents.length.toString(),
                      style:
                      const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    );
                  } else if (snapshot.hasError) {
                    return const Text('no');
                  }
                  return const Text("");
                }),
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("users")
                    .doc('smile')
                    .collection("cart")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {

                    final List<DocumentSnapshot> documents = snapshot.data!.docs;
                    double cartvalue = 0;
                    for (int i = 0; i < documents.length; i++) {
                      cartvalue = cartvalue +
                          (documents[i]["price"] *
                              documents[i]["Quantity"]);
                    }

                      orderTotal=cartvalue;


                    return Text(
                      "SubTotal: " + cartvalue.toString() + " Rupees",
                      style:
                      const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    );
                  } else if (snapshot.hasError) {
                    return const Text('no');
                  }
                  return const Text("");
                }),


            StreamBuilder<QuerySnapshot>(
              // <2> Pass `Stream<QuerySnapshot>` to stream
                stream: FirebaseFirestore.instance
                    .collection("users")
                    .doc('smile')
                    .collection("cart")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    // <3> Retrieve `List<DocumentSnapshot>` from snapshot
                    final List<DocumentSnapshot> documents = snapshot.data!.docs;
                    // emptyCart
                    return documents.isEmpty?
                    SizedBox(
                      height: 40,
                      width: double.infinity,
                      child: TextButton.icon(
                          style: TextButton.styleFrom(
                              elevation: 1,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(15))),
                              // BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                              primary: Colors.white,
                              backgroundColor: const Color(0xffcc826d),
                              textStyle:
                              const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                          label: const Text('Add Product'),
                          icon: const Icon(Icons.border_all),
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                    ):
                    SizedBox(
                      height: 40,
                      width: double.infinity,
                      child: TextButton.icon(
                          style: TextButton.styleFrom(
                              elevation: 1,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(15))),
                              // BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                              primary: Colors.white,
                              backgroundColor: const Color(0xffcc826d),
                              textStyle:
                              const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                          label: const Text('Place Order'),
                          icon: const Icon(Icons.border_all),
                          onPressed: () {
                            showLoaderDialog(context);
                            createOrderInUser();
                            emptyCart();


                          }),
                    );
                  } else if (snapshot.hasError) {
                    return const Text('no');
                  }
                  return const Text("");
                }),



          ],
        ),
      ),
    );
  }
  void increaseItemInCart(
      String bookId,
      BuildContext context) {
    FirebaseFirestore.instance
        .collection("users")
        .doc('smile')
        .collection("cart")
        .doc(bookId)
        .get()
        .then((doc) => {
      FirebaseFirestore.instance
          .collection("users")
          .doc('smile')
          .collection("cart")
          .doc(bookId)
          .get()
          .then((dataSnapshot) => {
        FirebaseFirestore.instance
            .collection("users")
            .doc('smile')
            .collection("cart")
            .doc(bookId)
            .update({
          "bookId": bookId,
          "Quantity": dataSnapshot.get("Quantity") + 1,
        })
      }),

    });
  }
  void decreaseItemInCart(
      String bookId,
      BuildContext context) {
    FirebaseFirestore.instance
        .collection("users")
        .doc('smile')
        .collection("cart")
        .doc(bookId)
        .get()
        .then((doc) => {
      FirebaseFirestore.instance
          .collection("users")
          .doc('smile')
          .collection("cart")
          .doc(bookId)
          .get()
          .then((dataSnapshot) => {
        FirebaseFirestore.instance
            .collection("users")
            .doc('smile')
            .collection("cart")
            .doc(bookId)
            .update({
          "bookId": bookId,
          "Quantity": dataSnapshot.get("Quantity")==1?dataSnapshot.get("Quantity"):dataSnapshot.get("Quantity") - 1,
        })
      }),

    });

  }

  List cartItemsList = [];

  getCartItems() {
    FirebaseFirestore.instance
        .collection("users")
        .doc("smile")
        .collection("cart")
        .get()
        .then((querySnapshot) {
      for (var element in querySnapshot.docs) {
        cartItemsList.add(element.data());
      }
    });
  }

  Future<void> createOrderInUser() async{
    String orderId = DateTime.now().microsecondsSinceEpoch.toString();
    await FirebaseFirestore.instance
        .collection("users")
        .doc("smile")
        .collection("orders")
        .doc(orderId)
        .set({
      "OrderId": orderId,
      "date": DateTime.now(),
      "delivered": false,
      "orderStatus": "pending",
      "Payment Type":"Pre-Paid",
      "Total": orderTotal,

    });
    for (int i = 0; i < cartItemsList.length; i++) {
      FirebaseFirestore.instance
          .collection("users")
          .doc("smile")
          .collection("orders")
          .doc(orderId)
          .collection("products")
          .doc()
          .set(cartItemsList[i]);
    }
  }

  Future<void>emptyCart() async{
   await FirebaseFirestore.instance
        .collection("users")
        .doc("smile")
        .collection("cart")
        .get()
        .then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
    });
   Navigator.pop(context);
   Navigator.pushReplacementNamed(context, '/placeOrder');
  }

  showLoaderDialog(BuildContext context){
    AlertDialog alert=AlertDialog(
      content:  Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const CircularProgressIndicator(),
          JumpingText('Uploading...'),
        ],),
    );
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }

}

