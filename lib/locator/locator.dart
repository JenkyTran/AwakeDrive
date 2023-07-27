import 'package:bluetooth_manager/bluetooth_manager.dart';
import 'package:get_it/get_it.dart';
import 'package:location/location.dart';

void setUp() {
  GetIt.I.registerLazySingleton(() => BluetoothManager());
  GetIt.I.registerLazySingleton(() => Location());
}
