part of 'bluetooth_device_scan_cubit.dart';

@immutable
abstract class BluetoothDeviceScanState {}

class BluetoothDeviceScanInitial extends BluetoothDeviceScanState {}

class BluetoothDeviceScanning extends BluetoothDeviceScanState {}

class BluetoothDeviceScanned extends BluetoothDeviceScanState {
  BluetoothDeviceScanned({required this.device}) : super();

  final BluetoothDeviceInfo device;
}

class BluetoothDeviceScanStopped extends BluetoothDeviceScanState {}

class BluetoothDeviceScanError extends BluetoothDeviceScanState {}

class BluetoothDeviceInfo {
  const BluetoothDeviceInfo({
    required this.id,
    this.uuids,
    this.scannedBleDevice,
    this.scannedDevice,
    this.name,
    required this.address,
    this.rssi,
  });

  final String id;
  final String? name;
  final String address;
  final List<dynamic>? uuids;
  final int? rssi;
  final ScanResult? scannedBleDevice;
  final BluetoothDiscoveryResult? scannedDevice;
}
