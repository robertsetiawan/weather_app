part of 'city_bloc.dart';

abstract class CityEvent extends Equatable {
  const CityEvent();

  @override
  List<Object> get props => [];
}

class LocationClearCity extends CityEvent{}

class LocationLoadCity extends CityEvent{
  final String selectedCountry;

  LocationLoadCity(this.selectedCountry);
}


class LocationSelectCity extends CityEvent{
  final String selectedCity;

  LocationSelectCity(this.selectedCity);
}
