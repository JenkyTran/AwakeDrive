import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'bluetooth_connection_state.dart';

class BluetoothConnectionCubit extends Cubit<BluetoothConnectionState> {
  BluetoothConnectionCubit() : super(BluetoothConnectionInitial());
}
