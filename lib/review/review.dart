import 'package:dd_review/data/review_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ReviewPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ReviewPageState();
  }
}

class ReviewPageState extends State<ReviewCardsWidget> {
  @override
  Widget build(BuildContext context) {
    return ReviewCardsWidget();
  }
}

class ReviewCardsWidget extends StatefulWidget {
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
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: pageView(),
        ));
  }

  Widget pageView() {
    return PageView(
      controller: _controller,
      children: [
        card(ReviewData.getTestData(0)),
        card(ReviewData.getTestData(1)),
        card(ReviewData.getTestData(2)),
      ],
    );
  }

  Widget card(ReviewData data) {
    return Card(elevation: 5, child: Center(child: Text(data.front.content + '\n--------------\n' + data.back.content)));
  }
}
