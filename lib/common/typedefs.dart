typedef VarArgsCallback = void Function(List<dynamic> args, Map<String, dynamic> kwargs);

class VarArgsFunction {
  VarArgsFunction(this.callback);

  final VarArgsCallback callback;

  static const _offset = 'Symbol("'.length;

  void call() => callback([], {});

  @override
  dynamic noSuchMethod(Invocation invocation) {
    return callback(
      invocation.positionalArguments,
      invocation.namedArguments.map(
        (rk, v) {
          final k = rk.toString();
          return MapEntry(k.substring(_offset, k.length - 2), v);
        },
      ),
    );
  }
}
