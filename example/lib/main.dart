import 'package:canyou_widget/canyou_widget.dart';
import 'package:example/cache_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CanYou Demo',
      theme: ThemeData.dark().copyWith(
        // primaryColor: Colors.blue,
        platform: TargetPlatform.iOS,
        splashFactory: InkRipple.splashFactory,
      ),
      builder: (BuildContext context, Widget? child) {
        if (child == null) {
          return const SizedBox.shrink();
        }

        /// 该处统一listTitle样式, 清除部分默认间距, 改为自定义间距
        return ListTileTheme(
          minLeadingWidth: 0.0,
          minVerticalPadding: 8.0,
          horizontalTitleGap: 8.0,
          enableFeedback: true,
          // dense: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
          // contentPadding: EdgeInsets.zero,
          child: MediaQuery(
            data: MediaQuery.of(context),
            child: child,
          ),
        );
      },
      home: const MyHomePage(
        key: Key('MyApp'),
        title: 'CanYou Demo',
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
  @override
  Widget build(BuildContext context) {
    return DoubleTapBackExitApp(
      showMessage: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Click Exit Application again'),
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
          child: ListView(
            children: <Widget>[
              ...ListTile.divideTiles(
                context: context,
                tiles: <Widget>[
                  ItemNormalWidget.item(
                    icon: const Icon(CupertinoIcons.settings),
                    title: 'Setting',
                    onTap: () {
                      Navigator.push<dynamic>(
                        context,
                        MaterialPageRoute<dynamic>(
                          builder: (BuildContext context) => const CachePage(),
                        ),
                      );
                    },
                  ),
                  ItemNormalWidget.item(
                    icon: const Icon(CupertinoIcons.info),
                    title: 'About',
                    onTap: () {
                      Navigator.push<dynamic>(
                        context,
                        MaterialPageRoute<dynamic>(
                          builder: (BuildContext context) => const CachePage(),
                        ),
                      );
                    },
                  ),
                  ItemNormalWidget.item(
                    icon: const Icon(CupertinoIcons.delete),
                    title: 'Cache management',
                    onTap: () {
                      Navigator.push<dynamic>(
                        context,
                        MaterialPageRoute<dynamic>(
                          builder: (BuildContext context) => const CachePage(),
                        ),
                      );
                    },
                  ),
                  ItemNormalWidget.selectItem(title: 'No right trailing'),
                  ListTile(
                    leading: const Icon(CupertinoIcons.settings),
                    minLeadingWidth: 0.0,
                    title: const Text('Setting'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      Navigator.push<dynamic>(
                        context,
                        MaterialPageRoute<dynamic>(
                          builder: (BuildContext context) => const CachePage(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const FlutterLogo(),
                    minLeadingWidth: 0.0,
                    title: const Text('One-line with leading widget'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      Navigator.push<dynamic>(
                        context,
                        MaterialPageRoute<dynamic>(
                          builder: (BuildContext context) => const CachePage(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {},
                      child: Container(
                        width: 50,
                        height: 50,
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        alignment: Alignment.center,
                        child: const CircleAvatar(),
                      ),
                    ),
                    title: const Text('title'),
                    dense: false,
                  ),
                  ListTile(
                    leading: const FlutterLogo(),
                    minLeadingWidth: 0.0,
                    title: const Text('Two-line ListTile'),
                    subtitle: const Text('Here is a second line'),
                    isThreeLine: false,
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      Navigator.push<dynamic>(
                        context,
                        MaterialPageRoute<dynamic>(
                          builder: (BuildContext context) => const CachePage(),
                        ),
                      );
                    },
                  ),
                  SwitchListTile(
                    // icon: const Icon(CupertinoIcons.info),
                    title: const Text('Two-line ListTile'),
                    subtitle: const Text('Here is a second line'),
                    value: true,
                    // contentPadding: EdgeInsets.zero,
                    onChanged: (bool value) {
                      print(value);
                    },
                  ),
                  ListTile(
                    leading: Container(
                      color: Colors.red,
                      child: const FlutterLogo(),
                    ),
                    title: Container(
                      color: Colors.blue,
                      child: Text('ListTile' * 18),
                    ),
                    // subtitle: const Text(
                    //     'A sufficiently long subtitle warrants three lines.'),
                    trailing: Container(
                      color: Colors.green,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 160.0),
                            child: Text('A sufficiently long.' * 7),
                          ),
                          // Text('A sufficiently long.' * 4),
                          const Icon(Icons.chevron_right),
                        ],
                      ),
                    ),
                    // minLeadingWidth: 0.0,
                    // minVerticalPadding: 0.0,
                    // horizontalTitleGap: 8.0,
                    visualDensity: VisualDensity.standard,
                    // contentPadding: EdgeInsets.zero,
                    // isThreeLine: true,
                    // dense: true,
                    onTap: () {
                      Navigator.push<dynamic>(
                        context,
                        MaterialPageRoute<dynamic>(
                          builder: (BuildContext context) => const CachePage(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: Container(
                      color: Colors.red,
                      child: const FlutterLogo(),
                    ),
                    title: Container(
                      color: Colors.blue,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              color: Colors.yellow,
                              child: Text('设置项' * 5),
                            ),
                          ),
                          Container(
                            color: Colors.red,
                            constraints: const BoxConstraints(maxWidth: 230.0),
                            child: Text('A sufficiently long.' * 2),
                          ),
                        ],
                      ),
                    ),
                    trailing: Container(
                      color: Colors.green,
                      child: const Icon(Icons.chevron_right),
                    ),
                    onTap: () {
                      Navigator.push<dynamic>(
                        context,
                        MaterialPageRoute<dynamic>(
                          builder: (BuildContext context) => const CachePage(),
                        ),
                      );
                    },
                  ),
                  ListTileTheme(
                    minLeadingWidth: 0.0,
                    minVerticalPadding: 0.0,
                    horizontalTitleGap: 0.0,
                    enableFeedback: true,
                    contentPadding: EdgeInsets.zero,
                    child: ListTile(
                      title: Row(
                        children: <Widget>[
                          Container(
                            color: Colors.red,
                            constraints: const BoxConstraints(maxWidth: 120.0),
                            child: Image.network(
                              'https://cdn.pixabay.com/photo/2020/06/29/00/26/iris-5350997_960_720.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              color: Colors.yellow,
                              child: Text('设置项' * 12),
                            ),
                          ),
                          Container(
                            color: Colors.red,
                            constraints: const BoxConstraints(maxWidth: 150.0),
                            child: Text('A sufficiently long.' * 12),
                          ),
                          Container(
                            color: Colors.green,
                            child: const Icon(Icons.chevron_right),
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.push<dynamic>(
                          context,
                          MaterialPageRoute<dynamic>(
                            builder: (BuildContext context) =>
                                const CachePage(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
