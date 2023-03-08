import 'package:flutter/material.dart';

class IdInheritedWidget extends InheritedWidget {
  final int id;

  const IdInheritedWidget({
    Key? key,
    required this.id,
    required Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(IdInheritedWidget oldWidget) {
    return id != oldWidget.id;
  }

  static IdInheritedWidget of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<IdInheritedWidget>()!;
  }
}