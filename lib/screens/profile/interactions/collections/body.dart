import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

import '../../../../components/constants.dart';
import '../../../../components/image_constants.dart';
import '../../../../components/widgets/dialogs/add_collection_dialog.dart';
import '../../../../components/routes/route.gr.dart';
import '../../../../components/widgets/dialogs/confirmation_dialog.dart';
import '../../../../components/widgets/dialogs/nothing_found_dialog.dart';
import '../../../../components/widgets/error.dart';
import '../../../../components/widgets/loading.dart';
import '../../../../models/collection.dart';
import '../../../../models/inherited_id.dart';
import '../../../collections/components/collection_card.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Future<List<Collection>> getCollections(int id) async {
    var client = http.Client();
    try {
      var response = await client.get(
          Uri.https(url, '/shelves/collections/by-user', {'take': '15'}),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            'userId': id.toString()
          });
      if (response.statusCode == 200) {
        return RecommendedCollections.fromJson(
                jsonDecode(utf8.decode(response.bodyBytes)))
            .collections;
      } else {
        throw Exception();
      }
    } finally {
      client.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final inheritedWidget = IdInheritedWidget.of(context);

    return FutureBuilder<List<Collection>>(
        future: getCollections(inheritedWidget.id),
        builder:
            (BuildContext context, AsyncSnapshot<List<Collection>> snapshot) {
          if (snapshot.hasData) {
            List<Collection> collection = snapshot.data!;
            return SizedBox(
                height: size.height,
                width: size.width,
                child: SingleChildScrollView(
                  reverse: false,
                  child: Column(
                    children: [
                      drawHead(context, size, inheritedWidget.id),
                      for (int i = 0; i < collection.length; ++i)
                        buildCard(collection[i], inheritedWidget.id),
                      SizedBox(
                        height: size.height * 0.1,
                      ),
                    ],
                  ),
                ));
          } else if (snapshot.hasError) {
            return WebErrorWidget(errorMessage: snapshot.error.toString());
          } else {
            // By default, show a loading spinner.
            return const LoadingWidget();
          }
        });
  }

  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }

  Future<void> deleteCollection(int colId, int userId) async {
    var client = http.Client();
    final jsonString = json.encode({});
    try {
      var response = await client.delete(
          Uri.https(url, '/shelves/collections/${colId.toString()}/remove'),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            'userId': userId.toString()
          },
          body: jsonString);
      if (response.statusCode != 200) {
        showDialog(
            context: context,
            builder: (BuildContext context) => const Center(
                child: NothingFoundDialog(
                    'Что-то пошло не так!\nКоллекция не была удалена.',
                    warningGif,
                    'Ошибка')));
      }
    } finally {
      client.close();
    }
  }

  Widget buildCard(Collection collection, int id) {
    return Dismissible(
      key: Key(collection.getId().toString()),
      confirmDismiss: (DismissDirection direction) async {
        return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return ConfirmationDialog(
              text: 'Вы действительно хотите удалить этот сборник?',
              press: () async {
                await deleteCollection(collection.getId(), id);
                context.router.pop(true);
              },
            );
          },
        );
      },
      background: deleteBackGroundItem(),
      child: CollectionCard(
        press: () => (context.router.push(CollectionBooksRoute(
            collectionId: collection.getId(),
            collectionName: collection.getName()))),
        collection: collection,
      ),
    );
  }

  Widget deleteBackGroundItem() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
          color: redColor, borderRadius: BorderRadius.all(Radius.circular(15))),
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 20),
      child: const Icon(
        Icons.delete,
        color: Colors.white,
      ),
    );
  }

  Widget drawHead(BuildContext context, Size size, int id) {
    return Container(
      margin: const EdgeInsets.only(left: 15, right: 15, top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: size.height * 0.03,
          ),
          Row(
            children: <Widget>[
              SizedBox(
                height: size.height * 0.09,
                width: size.width * 0.09,
                child:
                    //Image.network('https://disk.yandex.ru/i/i8FVLoIZxIl8xQ')
                    Image.asset('assets/images/book_shelf.png'),
              ),
              const SizedBox(width: 10),
              Text(
                'Сборники',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'VelaSansExtraBold',
                    //color: Colors.black,
                    fontSize: size.width / 12,
                    fontWeight: FontWeight.w800),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () => showDialog(
                    context: context,
                    builder: (BuildContext context) =>
                        AddCollectionDialog(id)).then(onGoBack),
                child: SizedBox(
                  height: 35,
                  width: 35,
                  child: Image.asset('assets/icons/add.png'),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
