import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/presentation/pages/home_page.dart';
import 'package:weather_app/presentation/themes/style.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/cloud.png',
                width: 100.w,
                height: 100.w,
              ),
              SizedBox(height: 20.h),
              Text(
                'Simple Weather App',
                style: myTextTheme.headline5,
              ),
              SizedBox(height: 30.h),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                },
                child: Text(
                  'Start',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
