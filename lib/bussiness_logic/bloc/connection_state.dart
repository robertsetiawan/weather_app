part of 'connection_bloc.dart';

abstract class ConnectionAppState extends Equatable {
  final bool isConnected;
  ConnectionAppState(this.isConnected);
  
  @override
  List<Object> get props => [];
}

class ConnectionInitial extends ConnectionAppState {

  ConnectionInitial({bool isConnected = false}) : super(isConnected);
}

class ConnectionEstablished extends ConnectionAppState{

  ConnectionEstablished({bool isConnected = true}) : super(isConnected);
}
