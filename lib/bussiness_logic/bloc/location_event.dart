part of 'location_bloc.dart';

abstract class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object> get props => [];
}

class LocationLoadCountry extends LocationEvent{}


class LocationSelectCountry extends LocationEvent{
  final String selectedCountry;

  LocationSelectCountry(this.selectedCountry);
}

class LocationClearCountry extends LocationEvent {}
