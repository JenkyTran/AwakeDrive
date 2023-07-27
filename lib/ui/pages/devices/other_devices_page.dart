import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../blocs/bluetooth_device_connect/bluetooth_device_connect_cubit.dart';
import '../../../blocs/bluetooth_device_scan/bluetooth_device_scan_cubit.dart';
import '../../../blocs/bluetooth_devices_connect/bluetooth_devices_connect_cubit.dart';
import '../../../router/route.dart';
import 'components/bluetooth_device_item.dart';

class OtherDevicesPage extends StatelessWidget {
  const OtherDevicesPage({Key? key, required this.data}) : super(key: key);
  final List<BluetoothDeviceInfo> data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      floatingActionButton: BlocBuilder<BluetoothDevicesConnectCubit, BluetoothDevicesConnectState>(
        builder: (context, state) {
          if (BlocProvider.of<BluetoothDevicesConnectCubit>(context).devices.isNotEmpty) {
            return FloatingActionButton(
              backgroundColor: const Color(0xFF5387EC),
              onPressed: () => GoRouter.of(context).push(Routes.main),
              child: const Icon(
                Icons.arrow_forward_rounded,
                color: Colors.white,
              ),
            );
          }
          return const SizedBox();
        },
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => GoRouter.of(context).pop(),
          ).p8(),
          const Spacer(),
          BlocBuilder<BluetoothDeviceScanCubit, BluetoothDeviceScanState>(
            builder: (context, state) => Text(
              'Other Devices (${data.length})',
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 18),
            ),
          ),
          const Spacer(),
          const IconButton(
            icon: SizedBox(),
            onPressed: null,
          ).p8(),
        ],
      ),
      body: ListView.builder(
        itemCount: data.length,
        padding: const EdgeInsets.all(8),
        itemBuilder: (context, index) {
          final BluetoothDeviceInfo device = data.sortedBy((a, b) {
            final int nameCompareResult = (a.name ?? 'z').compareTo(b.name ?? 'z');
            if (nameCompareResult != 0) {
              return nameCompareResult;
            } else {
              return a.id.compareTo(b.id);
            }
          })[index];
          return BlocProvider(
            create: (context) => BluetoothDeviceConnectCubit(),
            child: BluetoothDeviceItem(
              info: device,
              reactive: false,
            ),
          ).pSymmetric(v: 2);
        },
      ),
    );
  }
}
