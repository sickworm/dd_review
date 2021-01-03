import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

import 'review/review.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      builder: _init(),
      navigatorObservers: [BotToastNavigatorObserver()],
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }

  TransitionBuilder _init() {
    return BotToastInit();
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  void _startReview() {
     Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ReviewPage()));
  }

  void _addCard() {
    setState(() {
      BotToast.showText(text:"_addCard");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Today you have 8 cards to review',
            ),
            RaisedButton(
              onPressed: _startReview,
              child: Text('Start Review'),
            ),
            RaisedButton(
              onPressed: _addCard,
              child: Text('Add Card'),
            )
          ],
        ),
      )
    );
  }
}
