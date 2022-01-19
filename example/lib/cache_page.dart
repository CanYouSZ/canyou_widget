import 'package:canyou_widget/cache_util.dart';
import 'package:flutter/material.dart';

class CachePage extends StatefulWidget {
  const CachePage({Key? key}) : super(key: key);

  @override
  _CachePageState createState() => _CachePageState();
}

class _CachePageState extends State<CachePage> {
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cache management'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Clean up cache space:',
            ),
            Text(
              _cache,
              style: Theme.of(context).textTheme.headline4,
            ),
            ElevatedButton(
              onPressed: _clearCache,
              child: const Text('clear cache'),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _loadCache,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
