import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../generated/assets.gen.dart';

class IntroCard<K, V> extends StatelessWidget {
  const IntroCard({
    super.key,
    required this.data,
  });

  final MapEntry<K, V> data;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.transparent),
      child: Stack(
        alignment: Alignment.bottomLeft,
        fit: StackFit.passthrough,
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Assets.images.png.demo.image().pOnly(left: 36, right: 36, bottom: 36),
          ).pOnly(bottom: 20),
          Column(
            children: [
              const Spacer(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${data.key}',
                    style: context.headlineLarge!.copyWith(
                      color: const Color(0xFFFC5185),
                      fontSize: 60,
                    ),
                  ).pOnly(left: 8),
                  Text(
                    '${data.value}',
                    style: context.bodyMedium!.copyWith(
                      color: const Color(0xFFFC5185),
                    ),
                  ).pOnly(top: 2),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
