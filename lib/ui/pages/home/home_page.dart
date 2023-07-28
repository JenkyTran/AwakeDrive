import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../blocs/graph_data/graph_data_cubit.dart';
import 'components/graph_show_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    BlocProvider.of<GraphDataCubit>(context).mockData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => GoRouter.of(context).pop(),
          ).p8(),
          const Spacer(),
          Text(
            'Attention And Meditation',
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 18),
          ),
          const Spacer(),
          const IconButton(
            icon: SizedBox(),
            onPressed: null,
          ).p8(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: false,
        showSelectedLabels: false,
        selectedLabelStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black),
        unselectedLabelStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.black,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.music_note,
              color: Colors.black,
            ),
            label: 'Music Player',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.history,
              color: Colors.black,
            ),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: Colors.black,
            ),
            label: 'About Us',
          ),
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        child: const MindLinkDataGraph(),
      ),
    );
  }
}
