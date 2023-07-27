import 'dart:math';

import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../blocs/bluetooth_device_connect/bluetooth_device_connect_cubit.dart';
import '../../../blocs/bluetooth_device_scan/bluetooth_device_scan_cubit.dart';
import '../../../blocs/bluetooth_devices_connect/bluetooth_devices_connect_cubit.dart';
import '../../../common/constants.dart';
import '../../../router/route.dart';
import 'components/bluetooth_device_item.dart';
import 'components/other_devices_item.dart';

class DevicesPage extends StatefulWidget {
  const DevicesPage({Key? key}) : super(key: key);

  @override
  State<DevicesPage> createState() => _DevicesPageState();
}

class _DevicesPageState extends State<DevicesPage> with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
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
    super.build(context);
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      floatingActionButton: BlocBuilder<BluetoothDevicesConnectCubit, BluetoothDevicesConnectState>(
        builder: (context, state) {
          if (BlocProvider
              .of<BluetoothDevicesConnectCubit>(context)
          // fixed mac address of mind-link, temporary, fix later, for demo purpose only
              .devices.any((element) => element.address == Constants.mindLinkMacAddress)) {
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
            builder: (context, state) =>
                Text(
                  'Available Devices (${BlocProvider
                      .of<BluetoothDeviceScanCubit>(context)
                      .scannedDevices
                      .filter((element) => element.name.isNotEmptyAndNotNull)
                      .length})',
                  style: Theme
                      .of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(fontSize: 18),
                ),
          ),
          const Spacer(),
          BlocBuilder(
            bloc: BlocProvider.of<BluetoothDeviceScanCubit>(context),
            builder: (context, state) {
              if (state is BluetoothDeviceScanning) {
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
                  onPressed: BlocProvider
                      .of<BluetoothDeviceScanCubit>(context)
                      .stopScan,
                ).p8();
              }
              return IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: BlocProvider
                    .of<BluetoothDeviceScanCubit>(context)
                    .startScan,
              ).p8();
            },
          ),
        ],
      ),
      body: BlocBuilder<BluetoothDeviceScanCubit, BluetoothDeviceScanState>(
        builder: (context, state) {
          final List<BluetoothDeviceInfo> listFilter =
          BlocProvider
              .of<BluetoothDeviceScanCubit>(context)
              .scannedDevices
              .filter((element) => element.name.isNotEmptyAndNotNull)
              .toList();
          final List<BluetoothDeviceInfo> listOthers =
          BlocProvider
              .of<BluetoothDeviceScanCubit>(context)
              .scannedDevices
              .filter((element) => element.name.isEmptyOrNull)
              .toList();
          return SingleChildScrollView(
            // use column instead of listview to keep state of item
            child: Column(
              children: [
                for (final device in listFilter) BlocProvider(
                  create: (BuildContext context) => BluetoothDeviceConnectCubit(),
                  child: BluetoothDeviceItem(
                    info: device,
                  ).pSymmetric(v: 2),
                ),
                OtherItem(
                  icon: Icons.device_unknown_rounded,
                  label: 'Other devices (${listOthers.length})',
                  color: state is BluetoothDeviceScanning ? const Color(0xFF888888) : const Color(0xFF36A8FF),
                  onClick: () =>
                  state is BluetoothDeviceScanning ? null : context.push(Routes.nested([Routes.devices, Routes.otherDevices]), extra: listOthers.toList()),
                ),
                OtherItem(
                  icon: Icons.handyman_rounded,
                  label: 'Manual connect for non-listed devices',
                  color: state is BluetoothDeviceScanning ? const Color(0xFF888888) : const Color(0xFF36A8FF),
                  onClick: () => state is BluetoothDeviceScanning ? null : AppSettings.openAppSettings(type: AppSettingsType.bluetooth),
                ),
              ],
            ).p8(),
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
