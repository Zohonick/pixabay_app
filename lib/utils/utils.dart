import 'package:flutter/material.dart';

int calculateColumns(BuildContext context) {
  return MediaQuery.of(context).size.width ~/ 140;
}
