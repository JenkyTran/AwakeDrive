part of 'bluetooth_device_connect_cubit.dart';

@immutable
abstract class BluetoothDeviceConnectState {}

class BluetoothDeviceConnectInitial extends BluetoothDeviceConnectState {}

class BluetoothDeviceConnecting extends BluetoothDeviceConnectState {}

class BluetoothDeviceConnected extends BluetoothDeviceConnectState {
  BluetoothDeviceConnected({required this.device}) : super();

  final ScanResult device;
}

class BluetoothDeviceDisconnecting extends BluetoothDeviceConnectState {}

class BluetoothDeviceDisconnected extends BluetoothDeviceConnectState {
  BluetoothDeviceDisconnected({required this.device}) : super();

  final ScanResult device;
}

class BluetoothDeviceConnectError extends BluetoothDeviceConnectState {}
