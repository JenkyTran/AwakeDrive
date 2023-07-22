part of 'bluetooth_connection_cubit.dart';

@immutable
abstract class BluetoothConnectionState {}

class BluetoothConnectionInitial extends BluetoothConnectionState {}

class BluetoothUnavailable extends BluetoothConnectionState {}

class BluetoothReady extends BluetoothConnectionState {}

class BluetoothDeviceConnecting extends BluetoothConnectionState {}

class BluetoothDeviceConnected extends BluetoothConnectionState {
  BluetoothDeviceConnected({required this.deviceId, required this.deviceName}) : super();
  final String deviceId;
  final String deviceName;
}

class BluetoothDeviceDisconnected extends BluetoothConnectionState {
  BluetoothDeviceDisconnected({required this.deviceId, required this.deviceName}) : super();
  final String deviceId;
  final String deviceName;
}

class BluetoothError extends BluetoothConnectionState {
  BluetoothError({required this.code, required this.message, required this.exception}) : super();

  final String code;
  final String message;
  final Exception exception;
}
