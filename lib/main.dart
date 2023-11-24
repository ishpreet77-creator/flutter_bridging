import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var bridgitext;
  static const platformChannel = MethodChannel('flutter_bridging');
  @override
  void initState() {
    setState(() {
      bridgitext = "pta nhi button click kro";
    });
  }

  Future<void> _getDeviceModel() async {
    String _model;
    try {
      final String result = await platformChannel.invokeMethod('getDeviceModel');

      _model = result;
    } catch (e) {
      _model = "Can't fetch the method: '$e'.";
    }
    setState(() {
      bridgitext = _model;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "device model :- $bridgitext",
            ),
            ElevatedButton(
                onPressed: () {
                  _getDeviceModel();
                },
                child: Text("get device model with bridging"))
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
