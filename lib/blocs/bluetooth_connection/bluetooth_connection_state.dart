part of 'bluetooth_connection_cubit.dart';

@immutable
abstract class BluetoothConnectionState {}

@JsonSerializable()
class BluetoothConnectionInitial extends BluetoothConnectionState {}

@JsonSerializable()
class BluetoothUnavailable extends BluetoothConnectionState {}

@JsonSerializable()
class BluetoothReady extends BluetoothConnectionState {}

@JsonSerializable()
class BluetoothDeviceConnecting extends BluetoothConnectionState {}

@JsonSerializable()
class BluetoothDeviceConnected extends BluetoothConnectionState {
  BluetoothDeviceConnected({required this.deviceId, required this.deviceName}) : super();
  final String deviceId;
  final String deviceName;
}

@JsonSerializable()
class BluetoothDeviceDisconnected extends BluetoothConnectionState {
  BluetoothDeviceDisconnected({required this.deviceId, required this.deviceName}) : super();
  final String deviceId;
  final String deviceName;
}

@JsonSerializable()
class BluetoothError extends BluetoothConnectionState {
  BluetoothError({required this.code, required this.message, required this.exception}) : super();

  final String code;
  final String message;
  final Exception exception;
}
