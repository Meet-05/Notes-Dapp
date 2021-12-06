// @dart=2.9
import 'package:flutter/material.dart';

class RefreshWidget extends StatefulWidget {
  final Widget child;
  final Future<void> Function() onRefresh;
  RefreshWidget({this.child, this.onRefresh});
  @override
  _RefreshWidgetState createState() => _RefreshWidgetState();
}

class _RefreshWidgetState extends State<RefreshWidget> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: widget.onRefresh,
      child: widget.child,
    );
  }
}
