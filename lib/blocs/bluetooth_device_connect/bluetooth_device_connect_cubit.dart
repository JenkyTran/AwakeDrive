import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

part 'bluetooth_device_connect_state.dart';

class BluetoothDeviceScanCubit extends Cubit<BluetoothDeviceConnectState> {
  BluetoothDeviceScanCubit() : super(BluetoothDeviceConnectInitial());
}
