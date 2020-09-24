import 'package:flutter/material.dart';

void main() {
  print('redux app');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
    return Text("This will show which fruit is more plentiful");
  }
}

class AppleCountWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('build apples');
    return FruitCountWidget(
      networkImg:
          "http://www.pngmart.com/files/1/Apple-Fruit-PNG-Transparent-Image.png",
      count: 0, // need to get this from app state
    );
  }
}

class OrangeCountWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('build oranges');
    return FruitCountWidget(
      networkImg:
          "https://www.boeschbodenspies.com/wp-content/uploads/2017/08/orange.png",
      count: 0, // need to get this from app state
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

class AddAppleButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) => RaisedButton(
        child: Text("Add Apple"),
        onPressed: () {},
      );
}

class AddOrangeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) => RaisedButton(
        child: Text("Add Orange"),
        onPressed: () {},
      );
}
