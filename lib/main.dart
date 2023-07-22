import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'blocs/bluetooth_connection/bluetooth_connection_cubit.dart';
import 'locator/locator.dart';
import 'router/route.dart';
import 'ui/pages/begin/begin_page.dart';

void main() {
  setUp();
  runApp(const Application());
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BluetoothConnectionCubit(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 739),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp.router(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: FlexThemeData.light(scheme: FlexScheme.purpleM3, useMaterial3: true),
            darkTheme: FlexThemeData.light(scheme: FlexScheme.purpleM3, useMaterial3: true),
            routerConfig: router,
          );
        },
        child: const BeginPage(),
      ),
    );
  }
}
