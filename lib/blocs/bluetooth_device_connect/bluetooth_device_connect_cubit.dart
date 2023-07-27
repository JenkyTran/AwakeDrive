import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_bluetooth_serial_ble/flutter_bluetooth_serial_ble.dart';

import '../bluetooth_device_scan/bluetooth_device_scan_cubit.dart';

part 'bluetooth_device_connect_state.dart';

class BluetoothDeviceConnectCubit extends Cubit<BluetoothDeviceConnectState> {
  BluetoothDeviceConnectCubit() : super(const BluetoothDeviceConnectInitial());

  Future<void> connect(BluetoothDeviceInfo deviceInfo) async {
    emit(BluetoothDeviceConnecting(device: deviceInfo));
    if (deviceInfo.scannedBleDevice != null) {
      try {
        if (Platform.isAndroid) {
          if (!(await FlutterBluePlus.bondedDevices).any((element) => element.remoteId.str == deviceInfo.id)) {
            await deviceInfo.scannedBleDevice!.device.pair();
          }
        }
      } catch(e) {
        // ignored
      }
      await deviceInfo.scannedBleDevice!.device.connect(
        timeout: const Duration(seconds: 30),
        autoConnect: true,
      );
      if ((await FlutterBluePlus.connectedSystemDevices).map((e) => e.remoteId).contains(deviceInfo.scannedBleDevice!.device.remoteId)) {
        emit(BluetoothDeviceConnected(device: deviceInfo));
      } else {
        emit(BluetoothDeviceConnectError(device: deviceInfo));
      }
    } else {
      if (await FlutterBluetoothSerial.instance.getBondStateForAddress(deviceInfo.address) == BluetoothBondState.bonded || (await FlutterBluetoothSerial.instance.bondDeviceAtAddress(deviceInfo.address) ?? false)) {
        final BluetoothConnection connection = await BluetoothConnection.toAddress(deviceInfo.address, type: ConnectionType.CLASSIC);
        if (connection.isConnected) {
          emit(BluetoothDeviceConnected(device: deviceInfo, classicConnection: connection));
          // debug
          // FlutterBluetoothSerial.instance.removeDeviceBondWithAddress(deviceInfo.address);
        } else {
          emit(BluetoothDeviceConnectError(device: deviceInfo));
        }
      } else {
        emit(BluetoothDeviceConnectError(device: deviceInfo));
      }
    }
  }

  Future<void> disconnect(BluetoothDeviceInfo deviceInfo, {BluetoothConnection? classicConnection, bool classicImmediately = false}) async {
    emit(BluetoothDeviceDisconnecting(device: deviceInfo));
    if (deviceInfo.scannedBleDevice != null) {
      if (!(await FlutterBluePlus.connectedSystemDevices).map((e) => e.remoteId).contains(deviceInfo.scannedBleDevice!.device.remoteId)) {
        emit(BluetoothDeviceDisconnected(device: deviceInfo));
      }
      await deviceInfo.scannedBleDevice!.device.disconnect();
      if (!(await FlutterBluePlus.connectedSystemDevices).map((e) => e.remoteId).contains(deviceInfo.scannedBleDevice!.device.remoteId)) {
        emit(BluetoothDeviceDisconnected(device: deviceInfo));
      } else {
        emit(BluetoothDeviceDisconnectError(device: deviceInfo));
      }
    } else {
      if (classicConnection == null) {
        emit(BluetoothDeviceConnectError(device: deviceInfo));
      } else if (classicConnection.isConnected) {
        if (classicImmediately) {
          classicConnection.close().whenComplete(() => emit(BluetoothDeviceDisconnected(device: deviceInfo)));
        } else {
          classicConnection.finish().whenComplete(() => emit(BluetoothDeviceDisconnected(device: deviceInfo)));
        }
      } else {
        emit(BluetoothDeviceDisconnected(device: deviceInfo));
      }
    }
  }

  void preserve(BluetoothDeviceConnectState state) {
    emit(state);
  }
}
