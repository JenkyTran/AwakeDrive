import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:bluetooth_manager/bluetooth_manager.dart';
import 'package:bluetooth_manager/models/bluetooth_models.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dart_extensions/dart_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_elves/flutter_blue_elves.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:velocity_x/velocity_x.dart';

import './components/intro_card.dart';
import '../../../common/constants.dart';
import '../../../common/decorations.dart';
import '../../../common/functions.dart';
import '../../../generated/assets.gen.dart';
import '../../../permissions/permission_handler.dart';
import '../../../router/route.dart';

class BeginPage extends StatelessWidget {
  const BeginPage({Key? key}) : super(key: key);

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
                height: context.heightPx / 2.2,
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
              onPressed: () => handleStartClicked(context),
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

  Future<void> handleStartClicked(BuildContext context) async {
    if (!Platform.isAndroid) {
      Fluttertoast.showToast(
        msg: 'Device not support, only Android',
      );
      await exitApp(const Duration(milliseconds: 1000));
    }
    if (!await PermissionHandler.requestPermission()) {
      Fluttertoast.showToast(
        msg: 'You must allow bluetooth and location permissions for the app to work properly. Please allow them in setting',
      );
      if (!await openAppSettings()) {
        Fluttertoast.showToast(
          msg: 'Can not open setting, exit after 1s',
        );
        await exitApp(const Duration(milliseconds: 1000));
      } else {
        return;
      }
    }
    if (Platform.isAndroid) {
      FlutterBlueElves.instance.androidCheckBlueLackWhat().then((values) async {
        if (values.contains(AndroidBluetoothLack.bluetoothPermission)) {
          FlutterBlueElves.instance.androidApplyBluetoothPermission((isOk) async {
            if (isOk) {
              Fluttertoast.showToast(
                msg: 'Bluetooth permission allowed',
              );
            } else {
              Fluttertoast.showToast(
                msg: 'Can not grant bluetooth permission, exit after 1s',
              );
              await exitApp(const Duration(milliseconds: 1000));
            }
          });
        }
        if (values.contains(AndroidBluetoothLack.locationPermission)) {
          FlutterBlueElves.instance.androidApplyLocationPermission((isOk) async {
            if (isOk) {
              Fluttertoast.showToast(
                msg: 'Location permission allowed',
              );
            } else {
              Fluttertoast.showToast(
                msg: 'Can not grant location permission, exit after 1s',
              );
              await exitApp(const Duration(milliseconds: 1000));
            }
          });
        }
        if (values.contains(AndroidBluetoothLack.locationFunction)) {
          Fluttertoast.showToast(
            msg: 'Location not enable, trying to enable location',
          );
          FlutterBlueElves.instance.androidOpenLocationService((isOk) async {
            if (isOk) {
              Fluttertoast.showToast(
                msg: 'Location enabled',
              );
            } else {
              Fluttertoast.showToast(
                msg: 'Can not enable location, exit after 1s',
              );
              await exitApp(const Duration(milliseconds: 1000));
            }
          });
        }
        if (values.contains(AndroidBluetoothLack.bluetoothFunction)) {
          Fluttertoast.showToast(
            msg: 'Bluetooth not enable, trying to enable bluetooth',
          );
          await GetIt.I<BluetoothManager>().enableBluetooth().then((ActionResponse result) {
            if (result == ActionResponse.bluetoothAlreadyOn || result == ActionResponse.bluetoothIsOn) {
              Fluttertoast.showToast(
                msg: 'Bluetooth enabled',
              );
              if (context.mounted) {
                GoRouter.of(context).push(Routes.devices);
              }
            } else {
              FlutterBlueElves.instance.androidOpenBluetoothService((isOk) {
                if (isOk) {
                  Fluttertoast.showToast(
                    msg: 'Bluetooth enabled',
                  );
                  if (context.mounted) {
                    GoRouter.of(context).push(Routes.devices);
                  }
                } else {
                  Fluttertoast.showToast(
                    msg: 'Can not auto turn on bluetooth, please enable it in setting',
                  );
                  AppSettings.openAppSettings(type: AppSettingsType.bluetooth);
                }
              });
            }
          });
        }
        if (values.isEmptyOrNull) {
          if (context.mounted) {
            GoRouter.of(context).push(Routes.devices);
          }
        }
      });
    }
    if (Platform.isIOS) {
      FlutterBlueElves.instance.iosCheckBluetoothState().then((value) {
        // todo
        if (value == IosBluetoothState.unKnown) {
          ///Bluetooth is not initialized
        } else if (value == IosBluetoothState.resetting) {
          ///Bluetooth is resetting
        } else if (value == IosBluetoothState.unSupport) {
          ///Bluetooth not support
        } else if (value == IosBluetoothState.unAuthorized) {
          ///No give bluetooth permission
        } else if (value == IosBluetoothState.poweredOff) {
          ///bluetooth powerOff
        } else {
          ///bluetooth is ok
        }
      });
    }
  }
}
