import 'package:flutter/material.dart';
import 'package:hassel/app.dart';
import 'package:hassel/shared/app_widgets/widgets_helper.dart';

class MyCreditCardScreen extends StatefulWidget {
  const MyCreditCardScreen({Key? key}) : super(key: key);

  @override
  State<MyCreditCardScreen> createState() => _MyCreditCardScreenState();
}

class _MyCreditCardScreenState extends State<MyCreditCardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetsHelper.customAppBar(context, title: App.tr.paymentCards),
    );
  }
}
