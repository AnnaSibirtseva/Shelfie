import 'package:flutter/material.dart';

import '../constants.dart';

class Clipper1 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width * 1 / iconSplitPart, 0.0);
    path.lineTo(size.width * 1 / iconSplitPart, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return false;
  }
}

class Clipper2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(size.width * 1 / iconSplitPart, 0.0);
    path.lineTo(size.width * 2 / iconSplitPart, 0.0);
    path.lineTo(size.width * 2 / iconSplitPart, size.height);
    path.lineTo(size.width * 1 / iconSplitPart, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return false;
  }
}

class Clipper3 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(size.width * 2 / iconSplitPart, 0.0);
    path.lineTo(size.width * 3 / iconSplitPart, 0.0);
    path.lineTo(size.width * 3 / iconSplitPart, size.height);
    path.lineTo(size.width * 2 / iconSplitPart, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return false;
  }
}

class Clipper4 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(size.width * 3 / iconSplitPart, 0.0);
    path.lineTo(size.width * 4 / iconSplitPart, 0.0);
    path.lineTo(size.width * 4 / iconSplitPart, size.height);
    path.lineTo(size.width * 3 / iconSplitPart, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return false;
  }
}

class Clipper5 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(size.width * 4 / iconSplitPart, 0.0);
    path.lineTo(size.width * 5 / iconSplitPart, 0.0);
    path.lineTo(size.width * 5 / iconSplitPart, size.height);
    path.lineTo(size.width * 4 / iconSplitPart, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return false;
  }
}
