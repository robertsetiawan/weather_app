part of 'city_bloc.dart';

abstract class CityState extends Equatable {
  const CityState();

  @override
  List<Object> get props => [];
}

class CityInitial extends CityState {}

class LocationSelectedCity extends CityState {
  final String selectedCity;

  LocationSelectedCity(this.selectedCity);
  @override
  List<Object> get props => [selectedCity];
}

class LocationLoadedCity extends CityState {
  final List<String> cityList;

  LocationLoadedCity(this.cityList);

  @override
  List<Object> get props => [cityList];
}

class CityLoading extends CityState{}

class CityError extends CityState{
  final dynamic error;

  CityError(this.error);
}
