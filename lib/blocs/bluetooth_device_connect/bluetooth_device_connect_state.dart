part of 'bluetooth_device_connect_cubit.dart';

@immutable
abstract class BluetoothDeviceConnectState {
  const BluetoothDeviceConnectState({required this.device});
  final BluetoothDeviceInfo? device;
}

class BluetoothDeviceConnectInitial extends BluetoothDeviceConnectState {
  const BluetoothDeviceConnectInitial() : super(device: null);
}

class BluetoothDeviceConnecting extends BluetoothDeviceConnectState {
  const BluetoothDeviceConnecting({required BluetoothDeviceInfo device}) : super(device: device);
}

class BluetoothDeviceConnected extends BluetoothDeviceConnectState {
  const BluetoothDeviceConnected({required BluetoothDeviceInfo device}) : super(device: device);
}

class BluetoothDeviceDisconnecting extends BluetoothDeviceConnectState {
  const BluetoothDeviceDisconnecting({required BluetoothDeviceInfo device}) : super(device: device);
}

class BluetoothDeviceDisconnected extends BluetoothDeviceConnectState {
  const BluetoothDeviceDisconnected({required BluetoothDeviceInfo device}) : super(device: device);
}

class BluetoothDeviceConnectError extends BluetoothDeviceConnectState {
  const BluetoothDeviceConnectError({required BluetoothDeviceInfo device}) : super(device: device);
}

class BluetoothDeviceDisconnectError extends BluetoothDeviceConnectState {
  const BluetoothDeviceDisconnectError({required BluetoothDeviceInfo device}) : super(device: device);
}
