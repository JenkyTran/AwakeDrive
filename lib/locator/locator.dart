import 'package:bluetooth_manager/bluetooth_manager.dart';
import 'package:get_it/get_it.dart';

final _getIt = GetIt.instance;

void setUp() {
  GetIt.I.registerLazySingleton(() => BluetoothManager());
}
