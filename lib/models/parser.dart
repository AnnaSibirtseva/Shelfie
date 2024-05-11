import 'package:flutter/material.dart';
import 'package:instant/instant.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import '../components/constants.dart';
import '../components/image_constants.dart';

int offset = DateTime.now().toLocal().timeZoneOffset.inHours;
int offsetMin = DateTime.now().toLocal().timeZoneOffset.inMinutes;

String getImage(String imageUrl) {
  try {
    DecorationImage img = DecorationImage(
      image: NetworkImage(imageUrl),
      onError: (error, stackTrac) {
        imageUrl = defaultCollectionImg;
      },
      fit: BoxFit.cover,
    );
    return imageUrl;
  } on Exception catch (_) {
    return defaultCollectionImg;
  }
}

String getStringFromDate(DateTime dt) {
  var dtWithOffset = convertToUtcWithOffset(dt);

  initializeDateFormatting("ru_RU", null).then((_) {
    return DateFormat('dd MMM yyyy HH:mm', 'ru_RU').format(dtWithOffset);
  });
  return DateFormat('dd MMM yyyy HH:mm', 'ru_RU').format(dtWithOffset);
}

String parseDateTimeToDMY(DateTime dt) {
  var format = DateFormat('dd.MM.yy');
  return format.format(dt);
}

DateTime convertToUtcPlusZero(DateTime dt) {
  return dateTimeToOffset(offset: -1.0 * offset, datetime: dt);
}

DateTime convertToUtcWithOffset(DateTime dt) {
  return dateTimeToOffset(offset: 1.0 * offset, datetime: dt);
}
