import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../blocs/bluetooth_device_scan/bluetooth_device_scan_cubit.dart';
import 'components/bluetooth_device_item.dart';

class DevicesPage extends StatefulWidget {
  const DevicesPage({Key? key}) : super(key: key);

  @override
  State<DevicesPage> createState() => _DevicesPageState();
}

class _DevicesPageState extends State<DevicesPage> with TickerProviderStateMixin {
  late AnimationController _reloadIconController;

  @override
  void initState() {
    super.initState();
    _reloadIconController = AnimationController(vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<BluetoothDeviceScanCubit>(context).startScan();
      _reloadIconController.repeat(period: const Duration(milliseconds: 1000));
    });
  }

  @override
  void dispose() {
    _reloadIconController.dispose();
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
          Text(
            'Available Devices',
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 18),
          ),
          const Spacer(),
          BlocBuilder(
            bloc: BlocProvider.of<BluetoothDeviceScanCubit>(context),
            builder: (context, state) {
              if (state is BluetoothDeviceScanning) {
                return IconButton(
                  icon: AnimatedBuilder(
                    animation: _reloadIconController,
                    builder: (context, child) {
                      return Transform.rotate(
                        angle: _reloadIconController.value * 2.0 * pi,
                        child: child,
                      );
                    },
                    child: const Icon(Icons.refresh),
                  ),
                  onPressed: null,
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
      body: ListView.builder(
        itemCount: 50,
        padding: const EdgeInsets.all(8),
        itemBuilder: (context, index) => const BluetoothDeviceItem(
          id: '12345678901234567890',
        ).pSymmetric(v: 2),
      ),
    );
  }
}
