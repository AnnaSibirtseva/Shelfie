import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../models/inherited_id.dart';
import '../../../models/user_collection.dart';
import '../../constants.dart';

class FutureEventCard extends StatefulWidget {
  const FutureEventCard({
    Key? key,
  }) : super(key: key);

  @override
  State<FutureEventCard> createState() => _AddCollectionCardState();
}

class _AddCollectionCardState extends State<FutureEventCard> {
  late int id;

  @override
  void initState() {
    super.initState();
  }

  Future<void> addToCollection(int id) async {
    var client = http.Client();
    final jsonString = json.encode({});
    try {
      var response = await client.post(
          Uri.https(url, '/shelves/collections//add/'),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            'userId': id.toString()
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
    Size size = MediaQuery
        .of(context)
        .size;

    final inheritedWidget = IdInheritedWidget.of(context);
    id = inheritedWidget.id;

    return InkWell(
      child: Container(
        margin: const EdgeInsets.only(right: 5, top: 5),
        height: size.height * 0.35,
        width: size.width,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          border: Border.all(color: secondaryColor, width: 3),
        ),
        child: Column(
          children: [
            Expanded(
              child: SizedBox(
                width: size.width,
                child: Row(
                  children: [
                    Container(
                        width: size.width * 0.35,
                        decoration: const BoxDecoration(
                          borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(15)),
                          image: DecorationImage(
                            image: NetworkImage(
                                "https://i.pinimg.com/736x/d0/e3/33/d0e333e4cba6f8d183d08bae6c455a8b--rocket-ships-reading.jpg"),
                            fit: BoxFit.cover,
                          ),
                        )),
                    Flexible(
                      child: SingleChildScrollView(
                        child: SizedBox(
                          height: size.height * 0.3,
                          child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: Text("Печенье и Хокинг".replaceAll("", "\u{200B}"),
                                        softWrap: false,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w900,
                                            fontSize: size.width * 0.045)),
                                  ),
                                  const SizedBox(height: 10),
                                  eventPropNameText(
                                      "Книгa: ",
                                      size,
                                      '"Черные дыры и молодые Вселенные"'),
                                  const SizedBox(height: 10),
                                  eventPropText("Место: ", size, "Дом бабули Мэй", 3),
                                  const SizedBox(height: 10),
                                  eventPropText("Время: ", size, "04.07.2024", 1),
                                  const SizedBox(height: 10),
                                  eventPropText("Участники: ", size, "5", 1),
                                ],
                              ),
                            ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              height: size.height * 0.05,
              width: size.width,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15)),
                  color: secondaryColor),
              child: GestureDetector(
                onTap: () => {},
                child: const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Комментарии",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                        color: darkGrayColor),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget eventPropNameText(String name, Size size, String text) {
    return Flexible(
      child: RichText(
          softWrap: false,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.justify,
          text: TextSpan(
              text: name,
              style: TextStyle(
                  color: blackColor,
                  fontWeight: FontWeight.w400,
                  fontSize: size.width * 0.036),
              children: <TextSpan>[
              TextSpan(text: text,
              style: TextStyle(
                  color: primaryColor,
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.w400,
                  fontSize: size.width * 0.04)),
      ],
    )));
  }

  Widget eventPropText(String name, Size size, String text, int maxLines) {
    return Flexible(
        child: RichText(
            softWrap: false,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.justify,
            text: TextSpan(
              text: name,
              style: TextStyle(
                  color: blackColor,
                  fontWeight: FontWeight.w400,
                  fontSize: size.width * 0.038),
              children: <TextSpan>[
                TextSpan(text: text,
                    style: TextStyle(
                        color: blackColor,
                        fontWeight: FontWeight.w400,
                        fontSize: size.width * 0.04)),
              ],
            )));
  }
}
