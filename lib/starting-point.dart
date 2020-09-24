import 'package:flutter/material.dart';

void main() {
  runApp(StreamsApp());
}

class StreamsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('app is being built');

    return MaterialApp(
      theme: ThemeData.dark(),
      home: ApplesAndOranges(),
    );
  }
}

class ApplesAndOranges extends StatefulWidget {
  @override
  _ApplesAndOrangesState createState() => _ApplesAndOrangesState();
}

class _ApplesAndOrangesState extends State<ApplesAndOranges> {
  @override
  Widget build(BuildContext context) {
    print('building main content');
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
    print('building winning fruit indicator');
    int appleCount = 0;
    int orangeCount = 0;
    if (appleCount > orangeCount) {
      return Text("There are currently more apples");
    } else if (orangeCount > appleCount) {
      return Text("There are currently more oranges");
    } else {
      return Text("There are the same number of apples and oranges");
    }
  }
}

class AppleCountWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('building apple count widget');
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
    print('building orange count widget');
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
  Widget build(BuildContext context) {
    print('building add apple button');
    return RaisedButton(
      child: Text("Add Apple"),
      onPressed: () {
        // Do something here?
      },
    );
  }
}

class AddOrangeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('building add orange button');
    return RaisedButton(
      child: Text("Add Orange"),
      onPressed: () {
        // Do something here?
      },
    );
  }
}
