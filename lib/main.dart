import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/bussiness_logic/bloc/city_bloc.dart';
import 'package:weather_app/bussiness_logic/bloc/connection_bloc.dart';
import 'package:weather_app/bussiness_logic/bloc/location_bloc.dart';
import 'package:weather_app/presentation/pages/welcome_page.dart';
import 'package:weather_app/presentation/themes/style.dart';
import 'bussiness_logic/bloc/weather_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WeatherBloc>(
          create: (BuildContext context) => WeatherBloc(),
        ),
        BlocProvider<LocationBloc>(
          create: (BuildContext context) => LocationBloc(),
        ),
        BlocProvider<CityBloc>(
          create: (BuildContext context) => CityBloc(),
        ),
        BlocProvider<ConnectionBloc>(
          create: (BuildContext context) =>
              ConnectionBloc()..add(ConnectionCheck()),
        )
      ],
      child: ScreenUtilInit(
        designSize: Size(288, 624),
        builder: () => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Simple Weather App',
          theme: ThemeData(
            textTheme: myTextTheme,
            appBarTheme: AppBarTheme(textTheme: myTextTheme),
            primarySwatch: Colors.blue,
          ),
          home: WelcomePage(),
        ),
      ),
    );
  }
}
