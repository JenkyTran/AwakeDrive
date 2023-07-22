part of 'bluetooth_device_scan_cubit.dart';

@immutable
abstract class BluetoothDeviceScanState {}

class BluetoothDeviceScanInitial extends BluetoothDeviceScanState {}

class BluetoothDeviceScanning extends BluetoothDeviceScanState {}

class BluetoothDeviceScanned extends BluetoothDeviceScanState {
  BluetoothDeviceScanned({required this.device}) : super();

  final ScanResult device;
}

class BluetoothDeviceScanStopped extends BluetoothDeviceScanState {}

class BluetoothDeviceScanError extends BluetoothDeviceScanState {}
