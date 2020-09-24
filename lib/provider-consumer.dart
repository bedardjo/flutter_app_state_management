import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  print('provider consumer');
  AppleCountModel appleModel = AppleCountModel();
  OrangeCountModel orangeModel = OrangeCountModel();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider.value(value: appleModel),
      ChangeNotifierProvider.value(value: orangeModel)
    ],
    builder: (context, child) => ProviderConsumerApp(),
  ));
}

class AppleCountModel extends ChangeNotifier {
  int appleCount = 0;

  void incrementAppleCount() {
    appleCount++;
    notifyListeners();
  }
}

class OrangeCountModel extends ChangeNotifier {
  int orangeCount = 0;

  void incrementOrangeCount() {
    orangeCount++;
    notifyListeners();
  }
}

class ProviderConsumerApp extends StatelessWidget {
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
          children: [
            AddAppleButton(),
            AddOrangeButton(),
          ],
        )
      ],
    ));
  }
}

class WinningFruitIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer2<AppleCountModel, OrangeCountModel>(
      builder: (context, appleModel, orangeModel, child) {
        if (appleModel.appleCount > orangeModel.orangeCount) {
          return Text("there are more apples");
        } else if (orangeModel.orangeCount > appleModel.appleCount) {
          return Text("there are more oranges");
        } else {
          return Text("They are equal");
        }
      },
    );
  }
}

class AppleCountWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('build apples');
    return Consumer<AppleCountModel>(
        builder: (context, model, child) => FruitCountWidget(
              networkImg:
                  "http://www.pngmart.com/files/1/Apple-Fruit-PNG-Transparent-Image.png",
              count: model.appleCount,
            ));
  }
}

class OrangeCountWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('build oranges');
    return Consumer<OrangeCountModel>(
        builder: (context, model, child) => FruitCountWidget(
              networkImg:
                  "https://www.boeschbodenspies.com/wp-content/uploads/2017/08/orange.png",
              count: model.orangeCount,
            ));
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
  Widget build(BuildContext context) => Consumer<AppleCountModel>(
      builder: (context, model, child) => RaisedButton(
            child: Text("Add Apple"),
            onPressed: () {
              model.incrementAppleCount();
            },
          ));
}

class AddOrangeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Consumer<OrangeCountModel>(
      builder: (context, model, child) => RaisedButton(
            child: Text("Add Orange"),
            onPressed: () {
              model.incrementOrangeCount();
            },
          ));
}
