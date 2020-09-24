import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(AppStateWrapper(child: InheritedModelApp()));
}

enum FruitType { apples, oranges }

class AppState extends InheritedModel<FruitType> {
  final int appleCount;
  final int orangeCount;

  final void Function() incrementApples;
  final void Function() incrementOranges;

  const AppState(
      {this.appleCount,
      this.orangeCount,
      this.incrementApples,
      this.incrementOranges,
      Widget child})
      : super(child: child);

  static AppState of(BuildContext context, FruitType type) {
    return InheritedModel.inheritFrom(context, aspect: type);
  }

  @override
  bool updateShouldNotify(AppState old) {
    return old.appleCount != appleCount || old.orangeCount != orangeCount;
  }

  @override
  bool updateShouldNotifyDependent(AppState old, Set<FruitType> dependencies) {
    if (dependencies.contains(FruitType.apples) &&
        old.appleCount != appleCount) {
      return true;
    }
    if (dependencies.contains(FruitType.oranges) &&
        old.orangeCount != orangeCount) {
      return true;
    }
    return false;
  }
}

class AppStateWrapper extends StatefulWidget {
  final Widget child;

  const AppStateWrapper({Key key, this.child}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AppStateWrapperState();
}

class _AppStateWrapperState extends State<AppStateWrapper> {
  int appleCount = 0;
  int orangeCount = 0;

  @override
  Widget build(BuildContext context) {
    return AppState(
        appleCount: appleCount,
        orangeCount: orangeCount,
        incrementApples: this.incrementAppleCount,
        incrementOranges: this.incrementOrangeCount,
        child: this.widget.child);
  }

  void incrementAppleCount() {
    Timer(Duration(milliseconds: 50), () {
      setState(() {
        appleCount++;
      });
    });
  }

  void incrementOrangeCount() {
    Timer(Duration(milliseconds: 50), () {
      setState(() {
        orangeCount++;
      });
    });
  }
}

class InheritedModelApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('app is being built');
    return MaterialApp(
      theme: ThemeData.dark(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('home is being built');
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
    AppState state = AppState.of(context, FruitType.apples);
    int appleCount = state.appleCount;
    int orangeCount = state.orangeCount;
    print('updating winning fruit indicator');
    if (appleCount > orangeCount) {
      return Text("there are more apples");
    } else if (orangeCount > appleCount) {
      return Text("there are more oranges");
    } else {
      return Text("They are equal");
    }
  }
}

class AddAppleButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppState state = AppState.of(context, FruitType.apples);
    return RaisedButton(
      child: Text("Add Apple"),
      onPressed: () {
        state.incrementApples();
      },
    );
  }
}

class AddOrangeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppState state = AppState.of(context, FruitType.apples);
    return RaisedButton(
      child: Text("Add Orange"),
      onPressed: () {
        state.incrementOranges();
      },
    );
  }
}

class AppleCountWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AppState state = AppState.of(context, FruitType.apples);
    print('build apples');
    return FruitCountWidget(
      networkImg:
          "http://www.pngmart.com/files/1/Apple-Fruit-PNG-Transparent-Image.png",
      count: state.appleCount, // need to get this from app state
    );
  }
}

class OrangeCountWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AppState state = AppState.of(context, FruitType.oranges);
    print('build oranges');
    return FruitCountWidget(
      networkImg:
          "https://www.boeschbodenspies.com/wp-content/uploads/2017/08/orange.png",
      count: state.orangeCount, // need to get this from app state
    );
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
