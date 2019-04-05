import 'dart:convert';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  var wordInfo;
  var wordList;

  @override
  void initState() {
    super.initState();
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
      _counter = _counter % 3;
    });
  }

  List<Widget> chinese(chinese) {
    List<Widget> widges = List();
    if (chinese != null && chinese.length > 0)
      for (var i = 0; i < chinese.length; i++) {
        widges.add(Padding(
            padding: EdgeInsets.fromLTRB(20, 2, 20, 2),
            child: Text("${chinese[i]}", style: new TextStyle(fontSize: 20))));
      }
    return widges;
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return GestureDetector(
      child: Scaffold(
          // appBar: AppBar(
          //   // Here we take the value from the MyHomePage object that was created by
          //   // the App.build method, and use it to set our appbar title.
          //   title: Text(widget.title),
          // ),
          body: GestureDetector(
              onTap: () => _incrementCounter(), //点击
              child: FutureBuilder(
                  future: DefaultAssetBundle.of(context)
                      .loadString('lib/assets/words/cet4.json'),
                  builder: (context, snapshot) {
                    // ignore: deprecated_member_use
                    wordList = jsonDecode(snapshot.data.toString());
                    if (wordList == null) {
                      return new Container(width: 0.0, height: 0.0);
                    }
                    wordInfo = wordList[_counter];
                    return Center(
                      // Center is a layout widget. It takes a single child and positions it
                      // in the middle of the parent.
                      child: Flex(
                        // Column is also layout widget. It takes a list of children and
                        // arranges them vertically. By default, it sizes itself to fit its
                        // children horizontally, and tries to be as tall as its parent.
                        //
                        // Invoke "debug painting" (press "p" in the console, choose the
                        // "Toggle Debug Paint" action from the Flutter Inspector in Android
                        // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
                        // to see the wireframe for each widget.
                        //
                        // Column has various properties to control how it sizes itself and
                        // how it positions its children. Here we use mainAxisAlignment to
                        // center the children vertically; the main axis here is the vertical
                        // axis because Columns are vertical (the cross axis would be
                        // horizontal).
                        direction: Axis.vertical,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                              flex: 1,
                              child: Container(
                                height: 250,
                                child: Padding(
                                    padding: EdgeInsets.fromLTRB(0, 200, 0, 20),
                                    child: Text(
                                      "${wordInfo['word']}",
                                      style: new TextStyle(
                                          fontFamily: 'SansForgetica',
                                          fontSize: 50),
                                    )),
                              )),
                          Container(
                              child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    "${wordInfo['phoneticSymbol']}",
                                    style: new TextStyle(fontSize: 20),
                                  ))),
                          Container(
                              child: Padding(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 50),
                                  child: Column(
                                      children: chinese(wordInfo['chinese']))))
                        ],
                      ),
                    );
                  }))),
    );
  }
}
