import 'package:bot_toast/bot_toast.dart';
import 'package:dd_review/data/data_manager.dart';
import 'package:dd_review/review/review_finish.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'l10n/localization_intl.dart';
import 'review/review_page.dart';

void main() {
  runApp(MyApp());
}

typedef MyWidgetBuilder = Widget Function(RouteSettings context);

final Map<String, MyWidgetBuilder> routes = {
  "/": (_) => new MyHomePage(),
  "/review": (settings) => new ReviewPage(settings.arguments),
  "/review_finish": (_) => new ReviewFinishPage(),
};

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: '/',
        onGenerateRoute: (RouteSettings settings) {
          final route = routes[settings.name];
          if (route != null) {
            return MaterialPageRoute(builder: (_) => route(settings));
          }

          BotToast.showText(text: l10n.pageError);
          return MaterialPageRoute(builder: (context) => MyHomePage());
        },
        localizationsDelegates: [
          L10n.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en', 'US'), // 美国英语
          const Locale('zh', 'CN'), // 中文简体
        ],
        onGenerateTitle: (context) => L10n.of(context).title,
        builder: _init,
        navigatorObservers: [BotToastNavigatorObserver()],
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ));
  }

  Widget _init(BuildContext context, Widget child) {
    child = BotToastInit()(context, child);
    L10n.init(context);
    return child;
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage() : super();

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _startReview() async {
    final data = await DataManager.getData();
    Navigator.pushNamed(context, '/review', arguments: data);
  }

  void _addCard() {
    setState(() {
      BotToast.showText(text: "_addCard");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(l10n.title),
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
        ));
  }
}
