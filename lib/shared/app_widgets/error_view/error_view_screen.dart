import 'package:flutter/material.dart';

import '../empty_view/empty_item_model.dart';
import '../empty_view/empty_view_screen.dart';

class ErrorViewScreen extends StatelessWidget {
  final String error;
  const ErrorViewScreen({Key? key, required this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EmptyViewScreen(
        item: EmptyItemModel(
            mainTextHeader: ' App.tr.error',
            h1: 'App.tr.errorHeader',
            image: 'Resources.connectionEmpty',
            h2: error));
  }
}
