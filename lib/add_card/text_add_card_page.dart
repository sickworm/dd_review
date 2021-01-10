import 'package:bot_toast/bot_toast.dart';
import 'package:dd_review/data/review_data.dart';
import 'package:dd_review/scheduler/scheduler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TextAddCardPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TextAddCardPageState();
  }
}

class _TextAddCardPageState extends State<TextAddCardPage> {
  final frontController = TextEditingController();
  final backController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: Center(
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(hintText: 'test add title'),
                controller: frontController,
              ),
              TextField(
                decoration: InputDecoration(hintText: 'test add answer'),
                controller: backController,
              ),
              RaisedButton(onPressed: _onPressed, child: Text('add')),
              RaisedButton(onPressed: _onFinish, child: Text('finish')),
            ],
          ),
        )));
  }

  _onPressed() async {
    final data = ReviewData.text(frontController.text, backController.text);
    await reviewScheduler.addReviewData(data);
    BotToast.showText(text: 'add success');
  }

  _onFinish() async {
    Navigator.popUntil(context, ModalRoute.withName('/main'));
  }
}
