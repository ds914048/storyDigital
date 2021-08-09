import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:story_digital/screens/book_details.dart';

class Search extends SearchDelegate<String> {
  late String result;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear)),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pop(context);
          // close(context, result);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('Books').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return const Text('Loading...');

        final results = snapshot.data!.docs.where(
            (a) => a['Book_name'].toUpperCase().contains(query.toUpperCase()));

        return ListView(
          children: results
              .map<Widget>((a) => GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  BookDetails(bookId: a['BookId'])));
                    },
                    child: Card(
                        child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 3),
                      height: 100,
                      child: Row(
                        children: [
                          AspectRatio(
                            aspectRatio: 1.0,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    a["images"][0],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: Text(
                                  a['Book_name'],
                                  maxLines: 2,
                                  style: const TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15),
                                ),
                              ),
                              Text(
                                "Price: " + a['price'].toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400, fontSize: 17),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: Text(
                                  "author: " + a['author'],
                                  maxLines: 1,
                                  style: const TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 17),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )),
                  ))
              .toList(),
        );
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('Books').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return const Text('Loading...');

        final results = snapshot.data!.docs.where(
            (a) => a['Book_name'].toUpperCase().contains(query.toUpperCase()));

        return ListView(
          children: results
              .map<Widget>((a) => GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  BookDetails(bookId: a['BookId'])));
                    },
                    child: Card(
                        child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 3),
                      height: 100,
                      child: Row(
                        children: [
                          AspectRatio(
                            aspectRatio: 1.0,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    a["images"][0],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: Text(
                                  a['Book_name'],
                                  maxLines: 2,
                                  style: const TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15),
                                ),
                              ),
                              Text(
                                "Price: " + a['price'].toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400, fontSize: 17),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: Text(
                                  "author: " + a['author'],
                                  maxLines: 1,
                                  style: const TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 17),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )),
                  ))
              .toList(),
        );
      },
    );
  }
}
