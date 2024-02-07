import 'package:flutter/material.dart';

import '../components/constants.dart';
import '../components/image_constants.dart';

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
