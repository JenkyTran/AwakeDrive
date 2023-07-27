import 'package:flutter/material.dart';
import 'user_brain_index.dart';
import 'eeg_graph_widget.dart';

class Brainwave extends StatefulWidget {
  @override
  _BrainwaveState createState() => _BrainwaveState();
}

class _BrainwaveState extends State<Brainwave> {
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 9 / 10, // Width occupies 2/3 of the screen width
      child: ClipRRect(
        child: Container(
          height: MediaQuery.of(context).size.height * 2 / 5 +
              120, // Height occupies 2/5 of the screen
          padding: EdgeInsets.symmetric(
              horizontal: 5.0), // Add horizontal padding of 5
          margin: EdgeInsets.symmetric(vertical: 10.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1.0),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
              topLeft: Radius.circular(20.0),
              bottomLeft: Radius.circular(20.0),
            ),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Brainwave Index',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Nunito',
                            ),
                          ),
                          Text(
                            brainIndex.toString(),
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Nunito',
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          brainIndex < 80 ? "Sleepy" : "Good",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: brainIndex < 80 ? Colors.red : Colors.blue,
                            fontFamily: 'Nunito',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 4,
                child: Row(
                  children: [
                    Expanded(
                      child:
                          EEGGraphWidget(), // Wrap EEGGraphWidget with Expanded
                    ), // Add other widgets for the second row here
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
