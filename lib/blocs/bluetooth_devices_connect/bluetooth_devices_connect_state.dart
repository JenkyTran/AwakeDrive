part of 'bluetooth_devices_connect_cubit.dart';

@immutable
abstract class BluetoothDevicesConnectState {}

class BluetoothDevicesConnectInitial extends BluetoothDevicesConnectState {}

class BluetoothDeviceAdded extends BluetoothDevicesConnectState {
  BluetoothDeviceAdded({required this.device});
  
  final BluetoothDeviceInfo device;
}

class BluetoothDeviceRemoved extends BluetoothDevicesConnectState {
  BluetoothDeviceRemoved({required this.device});
  
  final BluetoothDeviceInfo device;
}