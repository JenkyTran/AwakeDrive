import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../blocs/bluetooth_devices_connect/bluetooth_devices_connect_cubit.dart';
import '../../../blocs/graph_data/graph_data_cubit.dart';
import '../../../common/constants.dart';
import 'graph_show_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final List<MindLinkData> data = [];

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GraphDataCubit>(
      create: (context) => GraphDataCubit(),
      child: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () {
                  final mindLink = BlocProvider.of<BluetoothDevicesConnectCubit>(context).devices.firstWhere((e) => e.id == Constants.mindLinkMacAddress);
                  final mindLinkConnection = BlocProvider.of<BluetoothDevicesConnectCubit>(context).classicConnections[Constants.mindLinkMacAddress];
                  if (mindLink == null || mindLinkConnection == null) {
                    return;
                  }
                  BlocProvider.of<GraphDataCubit>(context).subscribeData(mindLink, classicConnection: mindLinkConnection);
                },
                icon: const Icon(Icons.data_exploration),
              ).p8(),
            ],
          ),
          body: Container(
            alignment: Alignment.center,
            // child: BlocBuilder<GraphDataCubit, GraphDataState>(
            //   builder: (context, state) {
            //     if (state is GraphDataAdded) {
            //       if (data.length > 1000) {
            //         data.removeWhere((element) => true);
            //       }
            //       data.add(state.data);
            //       return SingleChildScrollView(
            //         child: Wrap(
            //           children: [
            //             for (final d in data) Text('m: ${d.meditation} a: ${d.attention}').p8()
            //           ],
            //         ),
            //       );
            //     }
            //     return const SizedBox();
            //   },
            // )
            child: MindLinkDataGraph(
              mindLinkDataStream: BlocProvider.of<GraphDataCubit>(context).dataStream,
            ),
          ),
        ),
      ),
    );
  }
}
