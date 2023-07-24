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
    required this.uuids,
    this.name,
    this.macAddress,
    this.rssi,
    this.manufacturerSpecificData,
    this.row,
  });

  final String id;
  final String? name;
  final String? macAddress;
  final List<dynamic> uuids;
  final int? rssi;
  final Map<dynamic, dynamic>? manufacturerSpecificData;
  final Uint8List? row;
}
