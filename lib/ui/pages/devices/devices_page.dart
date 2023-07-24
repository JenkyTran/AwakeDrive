import 'dart:math';

import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../blocs/bluetooth_device_scan/bluetooth_device_scan_cubit.dart';
import 'components/bluetooth_device_item.dart';
import 'components/other_devices_item.dart';

class DevicesPage extends StatefulWidget {
  const DevicesPage({Key? key}) : super(key: key);

  @override
  State<DevicesPage> createState() => _DevicesPageState();
}

class _DevicesPageState extends State<DevicesPage> with TickerProviderStateMixin {
  late AnimationController _reloadIconAnimationController;
  late CurvedAnimation _reloadIconAnimation;

  @override
  void initState() {
    super.initState();
    _reloadIconAnimationController = AnimationController(vsync: this);
    _reloadIconAnimation = CurvedAnimation(parent: _reloadIconAnimationController, curve: Curves.easeInOut);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<BluetoothDeviceScanCubit>(context).startScan();
      _reloadIconAnimationController.repeat(period: const Duration(milliseconds: 1000));
    });
  }

  @override
  void dispose() {
    _reloadIconAnimation.dispose();
    _reloadIconAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.pop(),
          ).p8(),
          const Spacer(),
          BlocBuilder<BluetoothDeviceScanCubit, BluetoothDeviceScanState>(
            builder: (context, state) => Text(
              'Available Devices (${BlocProvider.of<BluetoothDeviceScanCubit>(context).scannedDevices.filter((element) => element.name.isNotEmptyAndNotNull).length})',
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 18),
            ),
          ),
          const Spacer(),
          BlocBuilder(
            bloc: BlocProvider.of<BluetoothDeviceScanCubit>(context),
            builder: (context, state) {
              if (state is BluetoothDeviceScanning || state is BluetoothDeviceScanned) {
                return IconButton(
                  icon: AnimatedBuilder(
                    animation: _reloadIconAnimation,
                    builder: (context, child) {
                      return Transform.rotate(
                        angle: _reloadIconAnimation.value * 2.0 * pi,
                        child: child,
                      );
                    },
                    child: const Icon(Icons.refresh),
                  ),
                  onPressed: BlocProvider.of<BluetoothDeviceScanCubit>(context).stopScan,
                ).p8();
              }
              return IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: BlocProvider.of<BluetoothDeviceScanCubit>(context).startScan,
              ).p8();
            },
          ),
        ],
      ),
      body: BlocBuilder<BluetoothDeviceScanCubit, BluetoothDeviceScanState>(
        builder: (context, state) {
          final Iterable<BluetoothDeviceInfo> listFilter =
              BlocProvider.of<BluetoothDeviceScanCubit>(context).scannedDevices.filter((element) => element.name.isNotEmptyAndNotNull);
          final Iterable<BluetoothDeviceInfo> listOthers = BlocProvider.of<BluetoothDeviceScanCubit>(context).scannedDevices.filter((element) => element.name.isEmptyOrNull);
          return ListView.builder(
            itemCount: listFilter.length + 1,
            padding: const EdgeInsets.all(8),
            itemBuilder: (context, index) {
              if (index == 0) {
                return OtherItem(
                  icon: Icons.handyman_rounded,
                  label: 'Manual connect for non-listed devices',
                  color: const Color(0xFF36A8FF),
                  onClick: () => AppSettings.openAppSettings(type: AppSettingsType.bluetooth),
                );
              } else if (index == listFilter.length) {
                  return OtherItem(
                    icon: Icons.device_unknown_rounded,
                    label: 'Other devices (${listOthers.length})',
                    color: const Color(0xFF36A8FF),
                    onClick: () => AppSettings.openAppSettings(type: AppSettingsType.bluetooth),
                  );
              }
              final BluetoothDeviceInfo device = listFilter.sortedBy((a, b) {
                final int nameCompareResult = (a.name ?? 'z').compareTo(b.name ?? 'z');
                if (nameCompareResult != 0) {
                  return nameCompareResult;
                } else {
                  return a.id.compareTo(b.id);
                }
              })[index - 1];
              return BluetoothDeviceItem(
                info: device,
              ).pSymmetric(v: 2);
            },
          );
        },
      ),
    );
  }
}
