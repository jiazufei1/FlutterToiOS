import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PushFirstApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QD',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: PushFirstPage(),
    );
  }
}

const pushMainPlatform = const MethodChannel('qd.flutter.io/qd_push_main');

class PushFirstPage extends StatefulWidget {
  @override
  PushFirstPageState createState() => PushFirstPageState();
}

class PushFirstPageState extends State<PushFirstPage> {
//  static const pushMainPlatform = const MethodChannel('qd.flutter.io/qd_push_main');

  // Native调用原生监听
  Future<dynamic> handelPushCall(MethodCall methodCall) {
    print(methodCall.toString());
    String backResult = "gobackSuccess";
    if (methodCall.method == "goback") {
      if (Navigator.of(this.context).canPop()) {
        Navigator.of(this.context).pop();
      } else {
        backResult = "gobackError";
      }
    }
    return Future.value(backResult);
  }

  void pushNativePage() {
    pushMainPlatform.invokeMethod('pushNativePage', {'key1': 'value1'});
  }

  @override
  Widget build(BuildContext context) {
    pushMainPlatform.setMethodCallHandler(handelPushCall);

    return Scaffold(
        // push 过来的页面，原生没隐藏导航栏，所以把flutter页面的导航栏隐藏
//      appBar: new AppBar(
//        title: Text('First'),
//      ),
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text('First Page Content'),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => PushSecondPage(),
                  ),
                );
              },
              child: Text('Go to Flutter Second Page')),
          ElevatedButton(
              onPressed: () {
                SystemNavigator.pop();
              },
              child: Text('Close Flutter Page')),
          ElevatedButton(
              onPressed: () {
                pushNativePage();
              },
              child: Text('Go to Native Page')),
        ],
      ),
    ));
  }
}

class PushSecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 同上
//      appBar: new AppBar(
//        title: Text('SecondPage'),
//      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('Second Flutter Page Content'),
            ElevatedButton(
              onPressed: () {
                SystemNavigator.pop();
              },
              child: Text('Close All Flutter Page'),
            ),
            ElevatedButton(
              onPressed: () {
                pushMainPlatform
                    .invokeMethod('pushNativePage', {'key1': 'value1'});
              },
              child: Text('Go To Native Page'),
            ),
          ],
        ),
      ),
    );
  }
}
