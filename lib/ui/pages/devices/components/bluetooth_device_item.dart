import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../blocs/bluetooth_device_scan/bluetooth_device_scan_cubit.dart';

class BluetoothDeviceItem extends StatelessWidget {
  BluetoothDeviceItem({
    super.key,
    required this.info,
    this.reactive = true,
  });

  final BluetoothDeviceInfo info;
  final bool reactive;
  final ExpandableController _controller = ExpandableController(initialExpanded: false);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: const Color(0xFFF5F5F5),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(16),
        child: ExpandablePanel(
          controller: _controller,
          collapsed: Row(
            children: [
              const Icon(Icons.bluetooth).pOnly(right: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    info.name.isEmptyOrNull ? 'Unnamed Device' : info.name!,
                    overflow: TextOverflow.fade,
                  ),
                  Text(
                    info.id,
                    overflow: TextOverflow.fade,
                    style: context.theme.textTheme.bodyMedium!.copyWith(
                      fontSize: 12,
                      color: const Color(0xFF999999),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              SizedBox(
                width: 24,
                height: 24,
                child: BlocBuilder<BluetoothDeviceScanCubit, BluetoothDeviceScanState>(
                  builder: (context, state) {
                    return IconButton(
                      onPressed: state is BluetoothDeviceScanning || state is BluetoothDeviceScanned ? null : _controller.toggle,
                      padding: EdgeInsets.zero,
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Color(0xFFE8E8E8)),
                      ),
                      icon: const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: Color(0xFF888888),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          expanded: Row(
            children: [
              const Icon(Icons.bluetooth).pOnly(right: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    info.name.isEmptyOrNull ? 'Unnamed Device' : info.name!,
                    overflow: TextOverflow.fade,
                  ),
                  Text(
                    'ID: ${info.id}',
                    overflow: TextOverflow.fade,
                    style: context.theme.textTheme.bodyMedium!.copyWith(
                      fontSize: 12,
                      color: const Color(0xFF999999),
                    ),
                  ),
                  Text(
                    'ADDRESS: ${info.address}',
                    overflow: TextOverflow.fade,
                    style: context.theme.textTheme.bodyMedium!.copyWith(
                      fontSize: 12,
                      color: const Color(0xFF999999),
                    ),
                  ),
                  for (final uid in info.uuids ?? [])
                    Text(
                      'UUID${info.uuids?.indexOf(uid)}: $uid',
                      overflow: TextOverflow.fade,
                      style: context.theme.textTheme.bodyMedium!.copyWith(
                        fontSize: 12,
                        color: const Color(0xFF999999),
                      ),
                    ),
                  Text(
                    'RSSI: ${info.rssi}',
                    overflow: TextOverflow.fade,
                    style: context.theme.textTheme.bodyMedium!.copyWith(
                      fontSize: 12,
                      color: const Color(0xFF999999),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              SizedBox(
                width: 24,
                height: 24,
                child: reactive
                    ? BlocBuilder<BluetoothDeviceScanCubit, BluetoothDeviceScanState>(builder: (context, state) {
                        return IconButton(
                          onPressed: state is BluetoothDeviceScanning || state is BluetoothDeviceScanned ? null : _controller.toggle,
                          padding: EdgeInsets.zero,
                          style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(Color(0xFFE8E8E8)),
                          ),
                          icon: const Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: Color(0xFF888888),
                          ),
                        );
                      })
                    : IconButton(
                        onPressed: _controller.toggle,
                        padding: EdgeInsets.zero,
                        style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(Color(0xFFE8E8E8)),
                        ),
                        icon: const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: Color(0xFF888888),
                        ),
                      ),
              ),
            ],
          ),
          theme: const ExpandableThemeData(alignment: Alignment.center),
        ).pOnly(left: 16, right: 8, top: 20, bottom: 20),
      ),
    );
  }
}
