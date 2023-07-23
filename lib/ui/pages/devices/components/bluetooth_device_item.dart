

import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class BluetoothDeviceItem extends StatelessWidget {
  const BluetoothDeviceItem({
    super.key, required this.id, this.name = 'Unnamed Device',
  });

  final String id;
  final String name;

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
        child: Row(
          children: [
            const Icon(Icons.bluetooth).pOnly(right: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name),
                Text(
                  id,
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
              child: IconButton(
                onPressed: () {},
                padding: EdgeInsets.zero,
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Color(0xFFE8E8E8)),
                ),
                icon: const Icon(
                  Icons.keyboard_arrow_right_rounded,
                  color: Color(0xFF888888),
                ),
              ),
            ),
          ],
        ).pOnly(left: 16, right: 8, top: 20, bottom: 20),
      ),
    );
  }
}
