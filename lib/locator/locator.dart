import 'package:bluetooth_manager/bluetooth_manager.dart';
import 'package:get_it/get_it.dart';

void setUp() {
  GetIt.I.registerLazySingleton(() => BluetoothManager());
}
