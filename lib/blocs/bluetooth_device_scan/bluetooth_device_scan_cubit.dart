import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_bluetooth_serial_ble/flutter_bluetooth_serial_ble.dart';

part 'bluetooth_device_scan_state.dart';

class BluetoothDeviceScanCubit extends Cubit<BluetoothDeviceScanState> {
  BluetoothDeviceScanCubit() : super(BluetoothDeviceScanInitial());
  final List<BluetoothDeviceInfo> scannedDevices = [];

  void subscribeBluetoothDevicesScan() {
    Future.delayed(const Duration(seconds: 15), () {
      FlutterBluetoothSerial.instance.cancelDiscovery();
      emit(BluetoothDeviceScanStopped());
    });
    FlutterBluetoothSerial.instance.startDiscovery().listen(
      (event) {
        if (!scannedDevices.map((e) => e.id).contains(event.device.address)) {
          final info = BluetoothDeviceInfo(
            id: event.device.address,
            name: event.device.name,
            rssi: event.rssi,
            address: event.device.address,
            scannedDevice: event,
          );
          scannedDevices.add(info);
          emit(BluetoothDeviceScanning(device: info));
        }
      },
      onError: (err, stackTrace) {
        emit(BluetoothDeviceScanError());
      },
      onDone: () {
        emit(BluetoothDeviceScanStopped());
      },
      cancelOnError: true,
    );
    FlutterBluePlus.scan(timeout: const Duration(seconds: 15)).listen(
      (event) {
        if (!scannedDevices.map((e) => e.id).contains(event.device.remoteId.str)) {
          final info = BluetoothDeviceInfo(
            id: event.device.remoteId.str,
            name: event.device.localName,
            rssi: event.rssi,
            uuids: event.advertisementData.serviceUuids,
            address: event.device.remoteId.str,
            scannedBleDevice: event,
          );
          scannedDevices.add(info);
          emit(BluetoothDeviceScanning(device: info));
        }
      },
      onError: (err, stackTrace) {
        emit(BluetoothDeviceScanError());
      },
      onDone: () {
        emit(BluetoothDeviceScanStopped());
      },
      cancelOnError: true,
    );
  }

  void startScan() {
    if (state is BluetoothDeviceScanning) {
      return;
    }
    scannedDevices.removeWhere((element) => true);
    subscribeBluetoothDevicesScan();
    emit(BluetoothDeviceScanning());
  }

  void stopScan() {
    FlutterBluetoothSerial.instance.cancelDiscovery();
    FlutterBluePlus.stopScan().whenComplete(() => emit(BluetoothDeviceScanStopped()));
  }
}
