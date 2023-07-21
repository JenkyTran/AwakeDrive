import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bluetooth_connection_state.dart';

class BluetoothConnectionCubit extends Cubit<BluetoothConnectionState> {
  BluetoothConnectionCubit() : super(BluetoothConnectionInitial());
}
