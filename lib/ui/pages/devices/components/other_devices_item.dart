import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class OtherItem extends StatelessWidget {
  const OtherItem({
    super.key,
    required this.icon,
    required this.onClick,
    this.label = 'Other Devices',
    this.color,
  });

  final String label;
  final IconData icon;
  final Color? color;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: const Color(0xFFF5F5F5),
      child: InkWell(
        onTap: onClick,
        borderRadius: BorderRadius.circular(16),
        child: Row(
          children: [
            Icon(
              icon,
              color: color,
            ).pOnly(right: 16),
            Text(
              label,
              style: context.textTheme.bodyLarge!.copyWith(
                color: color,
              ),
            ),
            const Spacer(),
            SizedBox(
              width: 24,
              height: 24,
              child: Icon(
                Icons.keyboard_arrow_right,
                color: color,
              ),
            ),
          ],
        ).pOnly(left: 16, right: 8, top: 20, bottom: 20),
      ),
    );
  }
}
