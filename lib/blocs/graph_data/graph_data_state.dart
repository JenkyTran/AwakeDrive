import 'package:flutter/cupertino.dart';

import '../../services/mindlink_data_analyzer.dart';

@immutable
abstract class GraphDataState {}

class GraphDataInitial extends GraphDataState {}

class GraphDataAdded extends GraphDataState {
  GraphDataAdded({required this.data});

  final MindLinkData data;
}
