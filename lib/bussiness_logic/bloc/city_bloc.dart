import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/data/models/city_model.dart';

part 'city_event.dart';
part 'city_state.dart';

class CityBloc extends Bloc<CityEvent, CityState> {
  CityBloc() : super(CityInitial());

  CityModel cityModel = new CityModel();

  @override
  Stream<CityState> mapEventToState(
    CityEvent event,
  ) async* {
    if (event is LocationLoadCity){
      yield * mapLocationLoadCitryToState(event);
    } else if (event is LocationSelectCity){
      yield LocationSelectedCity(event.selectedCity);
    } else if (event is LocationClearCity){
      yield CityInitial();
    }
  }

  Stream<CityState> mapLocationLoadCitryToState(
      LocationLoadCity event) async* {
    yield CityLoading();

    try {
      List<String> cityData = await cityModel.getCity(event.selectedCountry);
      yield LocationLoadedCity(cityData);
    } catch (e) {
      yield CityError(e);
    }
  }
}
