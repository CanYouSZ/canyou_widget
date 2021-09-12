import 'package:canyou_widget/cache_util.dart';
import 'package:canyou_widget/canyou_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(
        key: Key('MyApp'),
        title: 'Flutter Demo Home Page',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _cache = '';

  void _loadCache() {
    loadCache().then((String value) {
      setState(() {
        _cache = value;
      });
    });
  }

  void _clearCache() {
    clearCache().then((bool value) {
      setState(() {
        _cache = '0.00B';
      });
    });
  }

  @override
  void initState() {
    super.initState();

    // 单次Frame绘制回调(addPostFrameCallback)
    WidgetsBinding.instance!.addPostFrameCallback((_) => _loadCache());

    // WidgetsBinding 与 SchedulerBinding 没有啥区别, 前者继承后者, 后者属于数据调度, 前者属于帧调度;
    // SchedulerBinding.instance!.addPostFrameCallback((Duration timestamp) {
    //   loadCache().then((String value) {
    //     setState(() {
    //       _cache = value;
    //     });
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return DoubleTapBackExitApp(
      showMessage: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('再次点击退出应用'),
            duration: Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
          ),
        );
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                '清理缓存空间:',
              ),
              Text(
                _cache,
                style: Theme.of(context).textTheme.headline4,
              ),
              ElevatedButton(
                onPressed: _clearCache,
                child: const Text('清除缓存'),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _loadCache,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
