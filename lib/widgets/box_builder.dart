import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:rxdart/rxdart.dart';

class BoxBuilder<T> extends StatefulWidget {
  const BoxBuilder({
    Key? key,
    required this.box,
    required this.builder,
  }) : super(key: key);

  final Box<T> box;
  final Widget Function(BuildContext context, Iterable<T> values) builder;

  @override
  State<BoxBuilder<T>> createState() => _BoxBuilderState<T>();
}

class _BoxBuilderState<T> extends State<BoxBuilder<T>> {
  late Stream<Iterable<T>> _stream;

  @override
  void initState() {
    _stream = widget.box
        .watch()
        .debounceTime(const Duration(milliseconds: 200))
        .map((_) => widget.box.values);
    super.initState();
  }

  Widget _builder(BuildContext context, AsyncSnapshot<Iterable<T>> snapshot) =>
      widget.builder(context, snapshot.data ?? []);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Iterable<T>>(
      initialData: widget.box.values,
      stream: _stream,
      builder: _builder,
    );
  }
}

class BoxItemBuilder<T> extends StatefulWidget {
  const BoxItemBuilder({
    Key? key,
    required this.box,
    required this.boxKey,
    required this.builder,
  }) : super(key: key);

  final Box<T> box;
  final String? boxKey;
  final Widget Function(BuildContext context, T? value) builder;

  @override
  State<BoxItemBuilder<T>> createState() => _BoxItemBuilderState<T>();
}

class _BoxItemBuilderState<T> extends State<BoxItemBuilder<T>> {
  late Stream<T?> _stream;

  @override
  void initState() {
    _stream = widget.box
        .watch(key: widget.boxKey)
        .debounceTime(const Duration(milliseconds: 200))
        .map((_) => widget.box.get(widget.boxKey));
    super.initState();
  }

  Widget _builder(BuildContext context, AsyncSnapshot<T?> snapshot) =>
      widget.builder(context, snapshot.data);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T?>(
      initialData: widget.box.get(widget.boxKey),
      stream: _stream,
      builder: _builder,
    );
  }
}
