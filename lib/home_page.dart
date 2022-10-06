import 'package:hassel/shared/app_widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'app.dart';
import 'core/app_business_logic/app_cubit/app_cubit.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          widget.title,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '',
              style: Theme.of(context).textTheme.headline4,
            ),
            CustomButton(
              height: 10.h,
              width: 80.w,
              title: 'App.tr.changeTheme',
              onTap: () {
                AppCubit.get(context).changeTheme();
              },
              titleColor: Theme.of(context).primaryColor,
              borderColor: Theme.of(context).backgroundColor,
            ),
            SizedBox(
              height: 5.h,
            ),
            CustomButton(
              height: 10.h,
              width: 80.w,
              title: 'App.tr.changeLanguage',
              onTap: () {
                AppCubit.get(context).changeLang();
              },
              titleColor: Theme.of(context).primaryColor,
              borderColor: Theme.of(context).backgroundColor,
            ),
          ],
        ),
      ),
    );
  }
}
