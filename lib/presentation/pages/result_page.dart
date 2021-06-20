import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bussiness_logic/bloc/weather_bloc.dart';
import 'package:weather_app/presentation/widgets/app_bar.dart';

class ResultPage extends StatefulWidget {
  final String city;

  const ResultPage({Key key, this.city}) : super(key: key);
  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  WeatherBloc weatherBloc;
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
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is WeatherLoaded) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(widget.city,
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Text(state.weatherModel.main.temp.toString() + " Kelvin(K)",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                      textAlign: TextAlign.center),
                  // Text(state.weatherModel.weather[0].description,
                  //     style:
                  //         TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
                  //     textAlign: TextAlign.center)
                ],
              );
            } else if (state is WeatherFailure) {
              return Center(
                child: Text(state.error.toString(), textAlign: TextAlign.center),
              );
            }
            return Container();
          },
        ),
      ),
    ));
  }
}
