import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/data/models/weather_model.dart';
import 'package:weather_app/data/repositories/weather_repository.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial());

  WeatherRepository weatherRepository = new WeatherRepository();

  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    if (event is GetWeatherInfo) {
      yield* mapGetWeatherInfoToState(event);
    } else if (event is RestartWeatherInfo) {
      yield WeatherInitial();
    }
  }

  Stream<WeatherState> mapGetWeatherInfoToState(GetWeatherInfo event) async* {
    yield WeatherLoading();

    try {
      final WeatherModel weatherModel =
          await weatherRepository.getWeatherInfo(event.city);
      yield WeatherLoaded(weatherModel);
    } catch (e) {
      yield WeatherFailure(e);
    }
  }
}
