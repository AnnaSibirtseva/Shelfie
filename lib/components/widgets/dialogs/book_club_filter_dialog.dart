import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import '../../../models/filters.dart';
import '../../../models/tag.dart';
import '../../../screens/filter/conponents/filter_list.dart';
import '../../../screens/filter/conponents/filter_text.dart';
import '../../../screens/filter/conponents/slider.dart';
import '../../buttons/dialog_button.dart';
import '../../constants.dart';
import '../error.dart';

class BookClubFiltersDialog extends Dialog {
  late FilterList tags = FilterList(data: const []);
  late FilterList privacy = FilterList(data: const []);
  late List<ClubTag> fullTags;

  late List<String> tagNames = [];

  SliderWidget slider = SliderWidget(
    maxValue: 100.0,
  );

  BookClubFiltersDialog({Key? key}) : super(key: key);

  Future<List<ClubTag>> getFilters() async {
    var client = http.Client();
    try {
      var response =
          await client.get(Uri.https(url, '/clubs/search/tags'), headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      });
      if (response.statusCode == 200) {
        return BookClubFilters.fromJson(
                jsonDecode(utf8.decode(response.bodyBytes)))
            .tags;
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

  List<String> getSelectedTags() {
    List<String> ids = [];
    for (var item in fullTags) {
      if (tags.selectedItemsList.contains(item.getTagName())) {
        ids.add(item.getId().toString());
      }
    }
    return ids;
  }

  List<String> getSelectedPrivacy() {
    return privacy.selectedItemsList;
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
            child: FutureBuilder<List<ClubTag>>(
                future: getFilters(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<ClubTag>> snapshot) {
                  if (snapshot.hasData) {
                    fullTags = snapshot.data!;
                    for (var tag in fullTags) {
                      tagNames.add(tag.getTagName());
                    }
                    var saved = tags.selectedItemsList;
                    tags = FilterList(
                      data: tagNames,
                    );
                    tags.selectedItemsList = saved;
                    saved = privacy.selectedItemsList;
                    privacy = FilterList(
                      data: ["Открытый", "Закрытый"],
                    );
                    privacy.selectedItemsList = saved;

                    return SingleChildScrollView(
                      reverse: false,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          const FilterText(text: 'Теги', icon: null),
                          tags,
                          const FilterText(text: 'Участники', icon: null),
                          slider,
                          const FilterText(text: 'Приватность', icon: null),
                          privacy,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              DialogButton(
                                  press: () {
                                    tags.selectedItemsList = [];
                                    privacy.selectedItemsList = [];
                                    slider = SliderWidget(
                                      maxValue: 100.0,
                                    );
                                    context.router.pop();
                                  },
                                  isAsync: true,
                                  reverse: true,
                                  text: 'Сбросить'),
                              const SizedBox(width: 10,),
                              DialogButton(
                                  press: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            duration: Duration(seconds: 30),
                                            backgroundColor: primaryColor,
                                            content: Text("Загрузка...")));
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
