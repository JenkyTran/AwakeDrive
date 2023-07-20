import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dart_extensions/dart_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:get_it/get_it.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../common/constants.dart';
import '../../common/decorations.dart';
import '../../generated/assets.gen.dart';
import '../../locator/locator.dart';
import 'components/intro_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1C),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: Decorations.homeScaffoldDecoration,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Spacer(flex: 2),
            Text(
              'Neural of Thinks',
              style: context.bodyLarge!.copyWith(
                color: Colors.white,
              ),
            ).p16(),
            Text(
              'AWAKE DRIVES',
              style: context.headlineLarge!.copyWith(
                color: Colors.white,
              ),
            ).pOnly(left: 12, right: 12, top: 12, bottom: 44),
            CarouselSlider(
              options: CarouselOptions(
                height: context.heightPx / 2.3,
                autoPlay: true,
                autoPlayAnimationDuration: const Duration(milliseconds: 750),
                autoPlayCurve: Curves.easeInOut,
                autoPlayInterval: const Duration(milliseconds: 3000),
                viewportFraction: 0.6,
              ),
              items: Constants.homePageMapLabel.entries.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return IntroCard<String, String>(data: i);
                  },
                );
              }).toList(),
            ),
            const Spacer(flex: 2),
            ElevatedButton(
              onPressed: () {
                GetIt.I<FlutterReactiveBle>().scanForDevices(
                  withServices: [],
                  scanMode: ScanMode.lowLatency,
                ).listen(
                  (device) {
                    log(device.toString());
                  },
                  onDone: () {
                    log('Done');
                  },
                  onError: (err, stackTrace) {
                    log(err.toString());
                  },
                  cancelOnError: true,
                );
              },
              style: ButtonStyle(
                  backgroundColor: const MaterialStatePropertyAll(Color(0xFFFC5185)),
                  overlayColor: MaterialStatePropertyAll(Colors.white.withOpacity(0.1)),
                  foregroundColor: MaterialStatePropertyAll(Colors.white.withOpacity(0.1))),
              child: Row(
                children: [
                  const Spacer(flex: 2),
                  Text(
                    'Start',
                    style: context.bodyLarge!.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(flex: 2),
                  Assets.images.svg.arrowThin.svg(),
                  const Spacer(),
                ],
              ),
            ).pOnly(left: context.widthPx / 1.9, right: 24),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
