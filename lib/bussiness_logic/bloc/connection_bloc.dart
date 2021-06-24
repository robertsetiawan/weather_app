import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';

part 'connection_event.dart';
part 'connection_app_state.dart';

class ConnectionBloc extends Bloc<ConnectionEvent, ConnectionAppState> {
  ConnectionBloc() : super(ConnectionInitial());

  Connectivity _connectivity = Connectivity();

  @override
  Stream<ConnectionAppState> mapEventToState(
    ConnectionEvent event,
  ) async* {
    ConnectivityResult result;
    if (event is ConnectionCheck) {
      try {
        while (true) {
          result = await _connectivity.checkConnectivity();
          if (result == ConnectivityResult.none) {
            yield ConnectionInitial();
          } else {
            yield ConnectionEstablished();
          }
        }
      } on PlatformException catch (e) {
        print(e.toString());
      }
    }
  }
}
