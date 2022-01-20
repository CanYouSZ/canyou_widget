import 'package:flutter/material.dart';

/// Android双击返回键,退出App
/// Android double-click the back button to exit the app
class DoubleTapBackExitApp extends StatefulWidget {
  const DoubleTapBackExitApp({
    Key? key,
    required this.child,
    required this.showMessage,
    this.duration = const Duration(milliseconds: 2500),
  }) : super(key: key);

  final Widget child;
  final Function showMessage;

  /// 两次点击返回按钮的时间间隔
  /// Click the time lapse of the return button
  final Duration duration;

  @override
  _DoubleTapBackExitAppState createState() => _DoubleTapBackExitAppState();
}

class _DoubleTapBackExitAppState extends State<DoubleTapBackExitApp> {
  DateTime? _lastTime;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _isExit,
      child: widget.child,
    );
  }

  /// [duration] 间隔时间内双击关闭App
  /// Double-click to close the app during interval
  Future<bool> _isExit() {
    if (_lastTime == null ||
        DateTime.now().difference(_lastTime!) > widget.duration) {
      _lastTime = DateTime.now();
      widget.showMessage();
      return Future<bool>.value(false);
    }
    return Future<bool>.value(true);
  }
}
