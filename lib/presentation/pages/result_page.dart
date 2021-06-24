import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bussiness_logic/bloc/weather_bloc.dart';
import 'package:weather_app/presentation/themes/style.dart';
import 'package:weather_app/presentation/widgets/app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResultPage extends StatefulWidget {
  final String city;

  const ResultPage({Key? key, required this.city}) : super(key: key);
  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  late WeatherBloc weatherBloc;

  @override
  void initState() {
    super.initState();
    weatherBloc = BlocProvider.of<WeatherBloc>(context);

    weatherBloc.add(GetWeatherInfo(widget.city));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: defaultAppbar('Result Page'),
        body: Center(
          child: BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state) {
              if (state is WeatherLoading) {
                return CircularProgressIndicator();
              } else if (state is WeatherLoaded) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.city,
                      style: myTextTheme.headline4,
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      state.weatherModel.main.temp.toString() + " Kelvin(K)",
                      textAlign: TextAlign.center,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CachedNetworkImage(
                          imageUrl:
                              "http://openweathermap.org/img/wn/${state.weatherModel.weather[0].icon}@2x.png",
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) =>
                                  CircularProgressIndicator(
                            value: downloadProgress.progress,
                          ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                        SizedBox(width: 5.w),
                        Text(
                          state.weatherModel.weather[0].description.toString(),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )
                  ],
                );
              } else if (state is WeatherFailure) {
                return Text(
                  state.error.toString(),
                  textAlign: TextAlign.center,
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
