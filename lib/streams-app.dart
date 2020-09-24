import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  StreamController<int> apples = StreamController();
  apples.add(0);
  StreamController<int> oranges = StreamController();
  oranges.add(0);

  runApp(AppState(
      appleCountController: apples,
      orangeCountController: oranges,
      child: StreamsApp()));
}

class AppState extends InheritedWidget {
  final StreamController<int> _appleCountController;
  final StreamController<int> _orangeCountController;

  final Stream<int> appleCount;
  final Stream<int> orangeCount;

  AppState(
      {StreamController<int> appleCountController,
      StreamController<int> orangeCountController,
      Widget child})
      : _appleCountController = appleCountController,
        _orangeCountController = orangeCountController,
        appleCount = appleCountController.stream.asBroadcastStream(),
        orangeCount = orangeCountController.stream.asBroadcastStream(),
        super(child: child);

  static AppState of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppState>();
  }

  @override
  bool updateShouldNotify(AppState old) {
    print('UPDATED!!!');
    return true;
  }

  void setOrangeCount(int newValue) {
    _orangeCountController.add(newValue);
  }

  void setAppleCount(int newValue) {
    _appleCountController.add(newValue);
  }
}

class StreamsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('app is being built');

    return MaterialApp(
      theme: ThemeData.dark(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          "Comparing Apples To Oranges",
          style: TextStyle(fontSize: 24),
        ),
        WinningFruitIndicator(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [AppleCountWidget(), OrangeCountWidget()],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [AddAppleButton(), AddOrangeButton()],
        )
      ],
    ));
  }
}

class WinningFruitIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: AppState.of(context).appleCount,
        builder: (ctx1, snap1) => StreamBuilder(
            stream: AppState.of(context).orangeCount,
            builder: (ctx2, snap2) {
              int appleCount = snap1.data;
              int orangeCount = snap2.data;
              if (appleCount > orangeCount) {
                return Text("There are currently more apples");
              } else if (orangeCount > appleCount) {
                return Text("There are currently more oranges");
              } else {
                return Text("There are the same number of apples and oranges");
              }
            }));
  }
}

class AppleCountWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: AppState.of(context).appleCount,
        builder: (context, snapshot) {
          print('build apples');
          return FruitCountWidget(
            networkImg:
                "http://www.pngmart.com/files/1/Apple-Fruit-PNG-Transparent-Image.png",
            count: snapshot.data,
          );
        });
  }
}

class OrangeCountWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('build oranges');
    return StreamBuilder(
        stream: AppState.of(context).orangeCount,
        builder: (context, snapshot) {
          print('orange');
          return FruitCountWidget(
            networkImg:
                "https://www.boeschbodenspies.com/wp-content/uploads/2017/08/orange.png",
            count: snapshot.data, // need to get this from app state
          );
        });
  }
}

class FruitCountWidget extends StatelessWidget {
  final String networkImg;
  final int count;

  const FruitCountWidget({Key key, this.networkImg, this.count})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Column(
          children: [
            Image.network(
              networkImg,
              height: 160,
              width: 160,
              fit: BoxFit.contain,
            ),
            Text(
              "$count",
              style: TextStyle(color: Colors.black, fontSize: 36),
            )
          ],
        ),
      );
}

class AddAppleButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) => StreamBuilder(
      stream: AppState.of(context).appleCount,
      builder: (context, snapshot) => RaisedButton(
            child: Text("Add Apple"),
            onPressed: () {
              AppState.of(context).setAppleCount(snapshot.data + 1);
            },
          ));
}

class AddOrangeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) => StreamBuilder(
      stream: AppState.of(context).orangeCount,
      builder: (context, snapshot) => RaisedButton(
            child: Text("Add Orange"),
            onPressed: () {
              AppState.of(context).setOrangeCount(snapshot.data + 1);
            },
          ));
}
