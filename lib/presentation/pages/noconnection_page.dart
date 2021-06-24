import 'package:flutter/material.dart';
import 'package:weather_app/presentation/widgets/app_bar.dart';

class NoConnectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: defaultAppbar('No Connection'),
      body: Container(),
    ));
  }
}
