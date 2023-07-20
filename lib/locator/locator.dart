import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:get_it/get_it.dart';

final _getIt = GetIt.instance;

void setUp() {
  _getIt.registerLazySingleton<FlutterReactiveBle>(() => FlutterReactiveBle());
}
