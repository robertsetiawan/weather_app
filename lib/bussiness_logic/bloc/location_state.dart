part of 'location_bloc.dart';

abstract class LocationState extends Equatable {
  const LocationState();
  
  @override
  List<Object> get props => [];
}

class LocationInitial extends LocationState {}

class LocationSelectedCountry extends LocationState{
  final String selectedCountry;

  LocationSelectedCountry(this.selectedCountry);
}

class LocationLoadedCountry extends LocationState{
  final List<String> countryList;

  LocationLoadedCountry(this.countryList);

  @override
  List<Object> get props => [countryList];
}


class LocationLoading extends LocationState{}

class LocationError extends LocationState{
  final dynamic error;

  LocationError(this.error);
}
