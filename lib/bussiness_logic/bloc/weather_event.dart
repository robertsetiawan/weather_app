part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

class GetWeatherInfo extends WeatherEvent{
  final String city;

  GetWeatherInfo(this.city);
}

class RestartWeatherInfo extends WeatherEvent{}