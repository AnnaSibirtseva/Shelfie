import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../models/user_collection.dart';
import '../../constants.dart';

class AddCollectionCard extends StatefulWidget {
  final UserCollection collection;
  final int userId;
  final int bookId;

  const AddCollectionCard({
    Key? key,
    required this.collection,
    required this.userId,
    required this.bookId,
  }) : super(key: key);

  @override
  State<AddCollectionCard> createState() => _AddCollectionCardState();
}

class _AddCollectionCardState extends State<AddCollectionCard> {
  late bool showFlag;

  @override
  void initState() {
    super.initState();
    showFlag = widget.collection.getIsInCollection();
  }

  Future<void> addToCollection() async {
    var client = http.Client();
    final jsonString = json.encode({});
    try {
      var response = await client.post(
          Uri.https(url,
              '/shelves/collections/${widget.collection.getId()}/add/${widget.bookId}'),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            'userId': widget.userId.toString()
          },
          body: jsonString);
      if (response.statusCode != 200) {
        throw Exception();
      }
    } finally {
      client.close();
    }
  }

  Future<void> removeFromCollection() async {
    var client = http.Client();
    final jsonString = json.encode({});
    try {
      var response = await client.delete(
          Uri.https(url,
              '/shelves/collections/${widget.collection.getId()}/remove/${widget.bookId}'),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            'userId': widget.userId.toString()
          },
          body: jsonString);
      if (response.statusCode != 200) {
        throw Exception();
      }
    } finally {
      client.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: const EdgeInsets.all(5),
        child: Row(
          children: [
            Expanded(
              child: Text(
                widget.collection.getName(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Spacer(),
            showFlag
                ? InkWell(
                    onTap: () async {
                      await removeFromCollection();
                      setState(() {
                        showFlag = !showFlag;
                      });
                    },
                    child: const Icon(
                      Icons.remove_circle_outline_rounded,
                      color: secondaryColor,
                    ))
                : InkWell(
                    onTap: () async {
                      await addToCollection();
                      setState(() {
                        showFlag = !showFlag;
                      });
                    },
                    child: const Icon(
                      Icons.add_circle_outline_rounded,
                      color: primaryColor,
                    )),
          ],
        ),
      ),
    );
  }
}
