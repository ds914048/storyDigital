import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:story_digital/commonWidgets/flot_appbar.dart';

class BookDetails extends StatefulWidget {
  final bookId;

  const BookDetails({Key? key, required this.bookId}) : super(key: key);

  @override
  _BookDetailsState createState() => _BookDetailsState();
}

class _BookDetailsState extends State<BookDetails> {
  @override
  void initState() {
    bookId = widget.bookId;
    readData(bookId);
    super.initState();
  }

  String bookId = "";
  String bookName = "";
  String author = "";
  String price = "";
  String description = "";
  List images = [];

  Future readData(bookId) async {
    FirebaseFirestore.instance
        .collection("Books")
        .doc(bookId)
        .get()
        .then((dataSnapshot) async {
      setState(() {
        bookName = dataSnapshot.get("Book_name");
        author = dataSnapshot.get("author");
        price = dataSnapshot.get("price");
        description = dataSnapshot.get("description");
        images = dataSnapshot.get("images");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FloatAppBar(),
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Card(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                      child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: images.isEmpty
                        ? Image.network(
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRkbJceY2_9dEA9OO-TJ2rIYYIA7KwZtwtDEC_YJK2qfCjbG6pV6xou10I25fLdutv_5No&usqp=CAU",
                            height: 250,
                          )
                        : Image.network(
                            images[0],
                            height: 250,
                          ),
                  )),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.only(top: 15, left: 18),
                    child: Text(
                      bookName,
                      style: const TextStyle(
                          fontSize: 25,
                          color: Color(0xffcc826d),
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: Text(
                      "Author:  $author",
                      style: const TextStyle(
                          fontSize: 14,
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: Text(
                      "Price: ₹ $price",
                      style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  const Divider(),
                  const Padding(
                    padding: EdgeInsets.only(left: 18, top: 10),
                    child: Text(
                      "Details",
                      style: TextStyle(
                        fontSize: 25,
                        color: Color(0xffccb16d),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Text(
                      description,
                      style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              )),
            ),
          ],
        ),
      ),
    );
  }
}
