import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shelfie/components/buttons/dialog_button.dart';
import 'package:shelfie/components/buttons/rounded_button.dart';
import 'package:shelfie/components/routes/route.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:http/http.dart' as http;
import 'package:shelfie/components/widgets/error.dart';
import 'dart:convert';

import '../../components/constants.dart';
import '../../models/filters.dart';
import 'conponents/filter_text.dart';
import 'conponents/filter_list.dart';
import 'conponents/slider.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  Future<Filters> getFilters() async {
    var client = http.Client();
    try {
      var response =
          await client.get(Uri.https(url, '/books/search/filters'), headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      });
      if (response.statusCode == 200) {
        return Filters.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
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
    return FutureBuilder<Filters>(
        future: getFilters(),
        builder: (BuildContext context, AsyncSnapshot<Filters> snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              reverse: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  const FilterText(text: 'Жанр', icon: 'mask'),
                  FilterList(
                    data: snapshot.data!.genres,
                  ),
                  const FilterText(text: 'Страна', icon: 'flag'),
                  FilterList(
                    data: snapshot.data!.languages,
                  ),
                  const FilterText(text: 'Рейтинг', icon: 'star'),
                  SliderWidget(),
                  const FilterText(text: 'Ограничения', icon: null),
                  FilterList(
                    data: snapshot.data!.ageRestrictions,
                  ),
                  Center(
                    child: RoundedButton(
                        text: 'Применить',
                        press: () {
                          context.router.pop();
                        }),
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return WebErrorWidget(errorMessage: snapshot.error.toString());
          } else {
            // By default, show a loading spinner.
            return const Center(
                child: CircularProgressIndicator(color: primaryColor));
          }
        });
  }
}
