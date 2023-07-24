import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_blue_elves/flutter_blue_elves.dart';

part 'bluetooth_device_scan_state.dart';

class BluetoothDeviceScanCubit extends Cubit<BluetoothDeviceScanState> {
  BluetoothDeviceScanCubit() : super(BluetoothDeviceScanInitial());
  final List<BluetoothDeviceInfo> scannedDevices = [];

  void subscribeBluetoothDevicesScan() {
    FlutterBlueElves.instance.startScan(30000).listen(
      (event) {
        if (!scannedDevices.map((e) => e.id).contains(event.id)) {
          final info = BluetoothDeviceInfo(
            id: event.id,
            name: event.localName,
            rssi: event.rssi,
            uuids: event.uuids,
            macAddress: event.macAddress,
            manufacturerSpecificData: event.manufacturerSpecificData,
            row: event.row,
          );
          scannedDevices.add(info);
          emit(BluetoothDeviceScanned(device: info));
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
    FlutterBlueElves.instance.getHideConnectedDevices().then((values) {
      for (final event in values) {
        if (!scannedDevices.map((e) => e.id).contains(event.id)) {
          final info = BluetoothDeviceInfo(
            id: event.id,
            name: event.name,
            uuids: event.uuids,
            macAddress: event.macAddress,
          );
          scannedDevices.add(info);
          emit(BluetoothDeviceScanned(device: info));
        }
      }
    });
    emit(BluetoothDeviceScanning());
  }

  void stopScan() {
    FlutterBlueElves.instance.stopScan();
    emit(BluetoothDeviceScanStopped());
  }
}
