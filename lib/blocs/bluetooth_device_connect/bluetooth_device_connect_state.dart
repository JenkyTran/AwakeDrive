part of 'bluetooth_device_connect_cubit.dart';

@immutable
abstract class BluetoothDeviceConnectState {}

class BluetoothDeviceConnectInitial extends BluetoothDeviceConnectState {}

class BluetoothDeviceConnecting extends BluetoothDeviceConnectState {
  BluetoothDeviceConnecting({required this.device}) : super();

  final BluetoothDeviceInfo device;
}

class BluetoothDeviceConnected extends BluetoothDeviceConnectState {
  BluetoothDeviceConnected({required this.device}) : super();

  final BluetoothDeviceInfo device;
}

class BluetoothDeviceDisconnecting extends BluetoothDeviceConnectState {
  BluetoothDeviceDisconnecting({required this.device}) : super();

  final BluetoothDeviceInfo device;
}

class BluetoothDeviceDisconnected extends BluetoothDeviceConnectState {
  BluetoothDeviceDisconnected({required this.device}) : super();

  final BluetoothDeviceInfo device;
}

class BluetoothDeviceConnectError extends BluetoothDeviceConnectState {
  BluetoothDeviceConnectError({required this.device}) : super();

  final BluetoothDeviceInfo device;
}

class BluetoothDeviceDisconnectError extends BluetoothDeviceConnectState {
  BluetoothDeviceDisconnectError({required this.device}) : super();

  final BluetoothDeviceInfo device;
}
