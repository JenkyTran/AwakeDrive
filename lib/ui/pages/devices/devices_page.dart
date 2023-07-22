import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class DevicesPage extends StatelessWidget {
  const DevicesPage({Key? key}) : super(key: key);

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
          const IconButton(
            icon: SizedBox(),
            onPressed: null,
          ).p8(),
        ],
      ),
      body: ListView.builder(
        itemCount: 50,
        padding: const EdgeInsets.all(8),
        itemBuilder: (context, index) => Card(
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
                    Text('Device ${index + 1}'),
                    const Text('id123456789'),
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
        ).pSymmetric(v: 2),
      ),
    );
  }
}
