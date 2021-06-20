import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/data/models/city_model.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(LocationInitial());

  CityModel cityModel = new CityModel();

  @override
  Stream<LocationState> mapEventToState(
    LocationEvent event,
  ) async* {
    if (event is LocationLoadCountry) {
      yield* mapLocationLoadCountryToState(event);
    } else if (event is LocationSelectCountry) {
      yield LocationSelectedCountry(event.selectedCountry);
    } else if (event is LocationClearCountry) {
      yield LocationInitial();
    }
  }

  Stream<LocationState> mapLocationLoadCountryToState(
      LocationLoadCountry event) async* {
    yield LocationLoading();

    try {
      List<String> countryData = await cityModel.getCountry();

      yield LocationLoadedCountry(countryData);
    } catch (e) {
      yield LocationError(e);
    }
  }
}
