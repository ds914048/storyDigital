import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';

class AddBook extends StatefulWidget {
  const AddBook({Key? key}) : super(key: key);

  @override
  _AddBookState createState() => _AddBookState();
}

class _AddBookState extends State<AddBook> {
  final _formKey = GlobalKey<FormState>();
  final bookName = TextEditingController();
  final bookImageUrl = TextEditingController();

  final bookPrice = TextEditingController();
  final bookAuthor = TextEditingController();

  final bookDescription = TextEditingController();

  String bookId = DateTime.now().microsecondsSinceEpoch.toString();

  Future<void> saveBookToFireStore() async {
    FirebaseFirestore.instance.collection("Books").doc(bookId).set({
      "BookId": bookId,
      'Book_name': bookName.text,
      'price': bookPrice.text,
      'author': bookAuthor.text,
      'description': bookDescription.text,
      'images': [
        bookImageUrl.text,
      ],
    }).then((value) => {
          bookId = DateTime.now().microsecondsSinceEpoch.toString(),
          bookName.text = '',
          bookPrice.text = '',
          bookAuthor.text = '',
          bookDescription.text = '',
          bookImageUrl.text = '',
          Navigator.pop(context),

        });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: bookImageUrl,
                    decoration: InputDecoration(
                      labelText: "Book Image URL",
                      labelStyle: const TextStyle(
                        color: Color(0xff28d6c0),
                      ),
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: const BorderSide(
                          color: Color(0xff28d6c0),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: const BorderSide(
                          color: Color(0xff28d6c0),
                          width: 2.0,
                        ),
                      ),
                    ),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Book Image url cannot be empty";
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.text,
                    style: const TextStyle(
                      fontFamily: "Poppins",
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: bookName,
                    decoration: InputDecoration(
                      labelText: "Book Name",
                      labelStyle: const TextStyle(
                        color: Color(0xff28d6c0),
                      ),
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: const BorderSide(
                          color: Color(0xff28d6c0),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: const BorderSide(
                          color: Color(0xff28d6c0),
                          width: 2.0,
                        ),
                      ),
                    ),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Book name cannot be empty";
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.text,
                    style: const TextStyle(
                      fontFamily: "Poppins",
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: bookPrice,
                    decoration: InputDecoration(
                      labelText: "Price",
                      labelStyle: const TextStyle(
                        color: Color(0xff28d6c0),
                      ),
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: const BorderSide(
                          color: Color(0xff28d6c0),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: const BorderSide(
                          color: Color(0xff28d6c0),
                          width: 2.0,
                        ),
                      ),
                    ),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Book name cannot be empty";
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.number,
                    style: const TextStyle(
                      fontFamily: "Poppins",
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: bookAuthor,
                    decoration: InputDecoration(
                      labelText: "Author",
                      labelStyle: const TextStyle(
                        color: Color(0xff28d6c0),
                      ),
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: const BorderSide(
                          color: Color(0xff28d6c0),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: const BorderSide(
                          color: Color(0xff28d6c0),
                          width: 2.0,
                        ),
                      ),
                    ),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Book Author cannot be empty";
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.text,
                    style: const TextStyle(
                      fontFamily: "Poppins",
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: bookDescription,
                    decoration: InputDecoration(
                      labelText: "Description",
                      labelStyle: const TextStyle(
                        color: Color(0xff28d6c0),
                      ),
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: const BorderSide(
                          color: Color(0xff28d6c0),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: const BorderSide(
                          color: Color(0xff28d6c0),
                          width: 2.0,
                        ),
                      ),
                    ),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Book Description cannot be empty";
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.multiline,
                    maxLines: 7,
                    style: const TextStyle(
                      fontFamily: "Poppins",
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: TextButton.icon(
                        style: TextButton.styleFrom(
                            shadowColor: const Color(0xff28d6c0),
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25))),
                            // BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                            primary: Colors.white,
                            backgroundColor: const Color(0xff28d6c0),
                            textStyle: const TextStyle(
                                fontSize: 19, fontWeight: FontWeight.w600)),
                        label: const Text('Add  Book'),
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            showLoaderDialog(context);
                            saveBookToFireStore();
                          }
                        }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  ///function for showing loading AlertDialog to user when app is in Add Book process
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
