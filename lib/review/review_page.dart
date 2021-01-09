import 'package:dd_review/data/review_data.dart';
import 'package:dd_review/l10n/localization_intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ReviewPage extends StatefulWidget {
  final List<ReviewData> data;

  ReviewPage(this.data);

  @override
  State<StatefulWidget> createState() {
    return ReviewPageState();
  }
}

class ReviewPageState extends State<ReviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: Stack(
          children: [ReviewCardsWidget(widget.data), ConfirmButtonWidget()],
        )));
  }
}

class ConfirmButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(bottom: 8.0),
        child: Align(
            alignment: Alignment.bottomCenter,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              button(l10n.easy),
              button(l10n.normal),
              button(l10n.hard)
            ])));
  }

  Widget button(String text) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: RaisedButton(onPressed: () => {}, child: Text(text)));
  }
}

class ReviewCardsWidget extends StatefulWidget {
  final List<ReviewData> data;

  ReviewCardsWidget(this.data);

  @override
  State<StatefulWidget> createState() {
    return ReviewCardsWidgetState();
  }
}

class ReviewCardsWidgetState extends State<ReviewCardsWidget> {
  PageController _controller =
      PageController(initialPage: 0, viewportFraction: 0.8);

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return pageView();
  }

  Widget pageView() {
    return PageView(
        controller: _controller,
        children: List.from(widget.data.map((data) => card(data))));
  }

  Widget card(ReviewData data) {
    return Card(
        elevation: 5,
        child: Center(
            child: Text(data.front.content +
                '\n--------------\n' +
                data.back.content)));
  }
}
