import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:http/http.dart' as http;
import 'package:shelfie/components/widgets/error.dart';
import 'package:shelfie/models/filters.dart';
import 'package:shelfie/screens/filter/conponents/slider.dart';
import 'dart:convert';
import 'dart:io';
import '../../../screens/filter/conponents/filter_list.dart';
import '../../../screens/filter/conponents/filter_text.dart';
import '../../buttons/dialog_button.dart';
import '../../constants.dart';

class FiltersDialog extends Dialog {
  late FilterList genres;
  late FilterList countries;
  late FilterList restrictions;
  SliderWidget slider = SliderWidget();

  FiltersDialog({Key? key}) : super(key: key);

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

  int getMinRating() {
    return slider.getRating().round();
  }

  List<String> getSelectedGenres() {
    return genres.selectedItemsList;
  }

  List<String> getSelectedCountries() {
    return countries.selectedItemsList;
  }

  List<String> getSelectedRestrictions() {
    return restrictions.selectedItemsList;
  }

  @override
  Dialog build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: SingleChildScrollView(
        reverse: false,
        child: Container(
            padding: const EdgeInsets.all(5),
            width: size.width * 0.8,
            height: size.height * 0.84,
            child: FutureBuilder<Filters>(
                future: getFilters(),
                builder:
                    (BuildContext context, AsyncSnapshot<Filters> snapshot) {
                  if (snapshot.hasData) {
                    genres = FilterList(
                      data: snapshot.data!.genres,
                    );
                    countries = FilterList(
                      data: snapshot.data!.languages,
                    );
                    restrictions = FilterList(
                      data: snapshot.data!.ageRestrictions,
                    );

                    return SingleChildScrollView(
                      reverse: false,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          const FilterText(text: 'Жанр', icon: 'mask'),
                          genres,
                          const FilterText(text: 'Страна', icon: 'flag'),
                          countries,
                          const FilterText(text: 'Рейтинг', icon: 'star'),
                          slider,
                          const FilterText(text: 'Ограничения', icon: null),
                          restrictions,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              DialogButton(
                                  press: () {
                                    context.router.pop();
                                  },
                                  isAsync: true,
                                  reverse: false,
                                  text: 'Применить'),
                            ],
                          ),
                          const SizedBox(height: 15),
                        ],
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return WebErrorWidget(
                        errorMessage: snapshot.error.toString());
                  } else {
                    // By default, show a loading spinner.
                    return const Center(
                        child: CircularProgressIndicator(color: primaryColor));
                  }
                })),
      ),
    );
  }
}
