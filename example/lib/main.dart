import 'package:flutter/material.dart';
import 'package:whiteboardkit/whiteboardkit.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(useMaterial3: true),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DrawingController? controller;

  @override
  void initState() {
    controller = new DrawingController();
    controller?.onChange().listen((draw) {
      setState(() {});
      //do something with it
    });
    super.initState();
  }

  Map<String, dynamic>? map;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton.extended(
            onPressed: () {
              setState(() {
                controller!.draw = WhiteboardDraw.fromJson(map ?? {});
                // print(map);
              });
            },
            label: Text("Import"),
          ),
          SizedBox(height: 10.0),
          FloatingActionButton.extended(
            onPressed: () {
              setState(() {
                map = controller?.draw?.toJson();
              });
              // Clipboard.setData(ClipboardData(text: map.toString()));

              // print(map);
            },
            label: Text("Export"),
          ),
        ],
      ),
      appBar: AppBar(
        title: Text(widget.title ?? ""),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width,
              child: Card(
                child: Whiteboard(
                  controller: controller,
                  // style: WhiteboardStyle(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller?.close();
    super.dispose();
  }
}
