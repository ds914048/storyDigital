import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:story_digital/screens/book_details.dart';

class Explore extends StatefulWidget {
  const Explore({Key? key}) : super(key: key);

  @override
  _ExploreState createState() => _ExploreState();
}

List<String> imgList = [
  'https://cdn.elearningindustry.com/wp-content/uploads/2016/05/top-10-books-every-college-student-read-1024x640.jpeg',
  'https://s26162.pcdn.co/wp-content/uploads/2018/12/11-bookstores-6-three-lives-2.w710.h473.2x.jpg',
  'https://marketingweek.imgix.net/content/uploads/2017/07/28131730/read-book_750.jpg?auto=compress,format&q=60&w=750&h=460',
  'https://media-cldnry.s-nbcnews.com/image/upload/t_nbcnews-fp-1024-512,f_auto,q_auto:best/newscms/2018_29/2504731/180720-read-book-good-health-ac-417p.jpg'
];

class _ExploreState extends State<Explore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            CarouselSlider(
              options: CarouselOptions(
                aspectRatio: 2.0,
                enlargeCenterPage: true,
                enableInfiniteScroll: true,
                initialPage: 2,
                autoPlay: true,
              ),
              items: imageSliders,
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 20.0, top: 15),
                child: Text(
                  "All Books",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Color(0xffcc826d),
                  ),
                ),
              ),
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 20.0, top: 15),
                child: Text(
                  "Long press to delete a Books",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: Colors.lightGreen,
                  ),
                ),
              ),
            ),
            StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection("Books").snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final List<DocumentSnapshot> documents =
                        snapshot.data!.docs;
                    return GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: documents.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          crossAxisCount: 2,
                          childAspectRatio: 0.66,
                        ),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onLongPress: (){
                              showDialog<void>(
                                context: context,
                                barrierDismissible: false, // user must tap button!
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Delete Product'),
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: <Widget>[
                                          // Text('This is a demo alert dialog.'),
                                          Text('Would you like to delete '+documents[index]['Book_name']+'?'),
                                        ],
                                      ),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text('Approve'),
                                        onPressed: () async{
                                          await FirebaseFirestore.instance
                                              .collection("Books").doc(documents[index]['BookId']).delete();
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      TextButton(
                                        child: const Text('Cancel'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BookDetails(
                                        bookId: documents[index]["BookId"]),
                                  ));
                            },
                            child: Card(
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              margin: const EdgeInsets.all(8),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(
                                          top: 10.0,
                                        ),
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.40,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.40,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                documents[index]['images'][0]),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Text(
                                          documents[index]['Book_name'],
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              fontSize: 13,
                                              color: Colors.orange,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "MRP: ₹" +
                                        documents[index]['price'].toString(),
                                    style: const TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 13),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    width: double.infinity,
                                    child: TextButton.icon(
                                        style: TextButton.styleFrom(
                                            elevation: 1,
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(15))),
                                            primary: Colors.white,
                                            backgroundColor:
                                                const Color(0xffcc826d),
                                            textStyle: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600)),
                                        label: const Text('Add to cart'),
                                        icon: const Icon(
                                            Icons.add_shopping_cart_outlined),
                                        onPressed: () {
                                          checkItemInCart(
                                              documents[index]['BookId'],
                                              documents[index]['Book_name'],
                                              documents[index]['description'],
                                              documents[index]['price'],
                                              documents[index]['author'],
                                              documents[index]['images'][0],
                                              context);
                                        }),
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
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

  void checkItemInCart(String bookId, String bookName, String description,
      String price, String author, String images, BuildContext context) {
    FirebaseFirestore.instance
        .collection("users")
        .doc("smile")
        .collection("cart")
        .doc(bookId)
        .get()
        .then((doc) => {
              if (doc.exists)
                {
                  Fluttertoast.showToast(
                      msg: "Quantity Increase",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.blueGrey,
                      textColor: Colors.white,
                      fontSize: 16.0),
                  FirebaseFirestore.instance
                      .collection("users")
                      .doc("smile")
                      .collection("cart")
                      .doc(bookId)
                      .get()
                      .then((dataSnapshot) => {
                            FirebaseFirestore.instance
                                .collection("users")
                                .doc("smile")
                                .collection("cart")
                                .doc(bookId)
                                .update({
                              "bookId": bookId,
                              "Quantity": dataSnapshot.get("Quantity") + 1,
                            })
                          }),
                }
              else
                {
                  Fluttertoast.showToast(
                      msg: "Product Added",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.blueGrey,
                      textColor: Colors.white,
                      fontSize: 16.0),
                  FirebaseFirestore.instance
                      .collection("users")
                      .doc("smile")
                      .collection("cart")
                      .doc(bookId)
                      .set({
                    "bookId": bookId,
                    "Book_name": bookName,
                    "description": description,
                    "images": images,
                    "author": author,
                    "price": int.parse(price),
                    "Quantity": 1.toInt(),
                  })
                }
            });
  }
}

final List<Widget> imageSliders = imgList
    .map((item) => Container(
          margin: const EdgeInsets.all(5.0),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
            child: Image.network(item, fit: BoxFit.cover, width: 1000.0),
          ),
        ))
    .toList();
