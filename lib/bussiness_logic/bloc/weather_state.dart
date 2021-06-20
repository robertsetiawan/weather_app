part of 'weather_bloc.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();
  
  @override
  List<Object> get props => [];
}

class WeatherInitial extends WeatherState {}

class WeatherLoaded extends WeatherState{
  final WeatherModel weatherModel;

  WeatherLoaded(this.weatherModel);

  @override
  List<Object> get props => [weatherModel];
}

class WeatherFailure extends WeatherState{
  final dynamic error;

  WeatherFailure(this.error);

  @override
  List<Object> get props => [error];
}

class WeatherLoading extends WeatherState{}