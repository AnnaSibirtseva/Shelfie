import 'dart:io';

import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import '../../../models/user_collection.dart';

import '../../buttons/dialog_button.dart';
import '../../constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../cards/add_col_card.dart';
import '../error.dart';

class AddBookToCollectionDialog extends Dialog {
  final int userId;
  final int bookId;

  const AddBookToCollectionDialog(this.userId, this.bookId, {Key? key})
      : super(key: key);

  Future<List<UserCollection>> getUserCollections() async {
    var client = http.Client();
    try {
      var response = await client.get(
          Uri.https(
              url, '/shelves/collections/check', {'bookId': bookId.toString()}),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            'userId': userId.toString()
          });
      if (response.statusCode == 200) {
        return UserCollectionList.fromJson(
                jsonDecode(utf8.decode(response.bodyBytes)))
            .allCollections;
      } else {
        throw Exception();
      }
    } finally {
      client.close();
    }
  }

  @override
  Dialog build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: SingleChildScrollView(
        reverse: false,
        child: Container(
          padding: const EdgeInsets.all(15),
          width: size.width * 0.8,
          height: size.height * 0.4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children: [
                  Icon(
                    Icons.settings,
                    size: size.width / 15,
                  ),
                  const Spacer(),
                  Text('Добавить в сборник',
                      style: TextStyle(
                          fontFamily: 'VelaSansExtraBold',
                          fontSize: size.width / 20,
                          fontWeight: FontWeight.w800)),
                  const Spacer(),
                  Icon(
                    Icons.settings,
                    size: size.width / 15,
                  ),
                ],
              ),
              const Divider(color: primaryColor),
              const SizedBox(height: 10),
              SizedBox(
                height: size.height * 0.2,
                child: FutureBuilder<List<UserCollection>>(
                    future: getUserCollections(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<UserCollection>> snapshot) {
                      if (snapshot.hasData) {
                        return SingleChildScrollView(
                            reverse: false,
                            child: Column(
                              children: [
                                if (snapshot.data!.isEmpty)
                                   Column(
                                     mainAxisAlignment: MainAxisAlignment.center,
                                     crossAxisAlignment: CrossAxisAlignment.center,
                                     children: [
                                       SizedBox(height: size.height * 0.1,),
                                       const Text("У вас нет сборников"),
                                     ],
                                   ),
                                if (snapshot.data!.isNotEmpty)
                                  for (int i = 0;
                                      i < snapshot.data!.length;
                                      ++i)
                                    AddCollectionCard(
                                      collection: snapshot.data![i],
                                      bookId: bookId,
                                      userId: userId,
                                    )
                              ],
                            ));
                      } else if (snapshot.hasError) {
                        return WebErrorWidget(
                            errorMessage: snapshot.error.toString());
                      } else {
                        return const Center(
                            child:
                                CircularProgressIndicator(color: primaryColor));
                      }
                    }),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DialogButton(
                      press: () {
                        context.router.pop();
                      },
                      isAsync: true,
                      reverse: true,
                      text: 'OK'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
