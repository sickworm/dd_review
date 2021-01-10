import 'dart:developer';
import 'dart:io';

import 'package:dd_review/data/review_data.dart';
import 'package:dd_review/l10n/localization_intl.dart';
import 'package:dd_review/scheduler/scheduler.dart';
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
  ReviewCardsController controller = ReviewCardsController();
  int farthestPageIndex = -1;

  bool get isShowButton => controller.currentPage <= farthestPageIndex;

  bool get isLastPage => controller.currentPage >= widget.data.length - 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: Stack(
          children: [
            Container(
                margin: EdgeInsets.only(top: 40, bottom: 60),
                child: ReviewPageWidget(
                    data: widget.data,
                    controller: controller,
                    onClickAnswer: onClickAnswer)),
            if (isShowButton) ConfirmButtonWidget(onReviewed)
          ],
        )));
  }

  onClickAnswer() {
    log("onClickAnswer");
    if (isShowButton) {
      return;
    }

    setState(() {
      farthestPageIndex = controller.currentPage;
    });
  }

  onReviewed(ReviewLevel level) {
    log("onClickConfirm $level ${widget.data.length}");

    reviewScheduler.onReviewed(level, widget.data[controller.currentPage]);

    if (isLastPage) {
      setState(() {
        finishReview();
      });
      return;
    }

    setState(() {
      controller.nextPage();
    });
  }

  finishReview() {
    log("finishReview");
    Navigator.pushNamed(context, '/review_finish');
  }
}

typedef ConfirmButtonCallback = void Function(ReviewLevel level);

class ConfirmButtonWidget extends StatelessWidget {
  final ConfirmButtonCallback onConfirm;

  ConfirmButtonWidget(this.onConfirm);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(bottom: 8.0),
        child: Align(
            alignment: Alignment.bottomCenter,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              button(l10n.easy, () => onConfirm(ReviewLevel.Easy)),
              button(l10n.normal, () => onConfirm(ReviewLevel.Normal)),
              button(l10n.hard, () => onConfirm(ReviewLevel.Hard))
            ])));
  }

  Widget button(String text, VoidCallback onPressed) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: RaisedButton(onPressed: onPressed, child: Text(text)));
  }
}

class ReviewCardsController {
  ReviewPageWidgetState _state;
  int _currentPage = 0;

  /// 当前页面，点击时增加，所以会比 PageView 先 +1
  int get currentPage => _currentPage;

  attach(ReviewPageWidgetState state) {
    _state = state;
  }

  nextPage() {
    log("nextPage");
    _state?.nextPage();
    _currentPage = (_state.pageController.page.toInt() ?? 0) + 1;
  }
}

class ReviewPageWidget extends StatefulWidget {
  final List<ReviewData> data;
  final ReviewCardsController controller;
  final VoidCallback onClickAnswer;

  ReviewPageWidget({this.data, this.controller, this.onClickAnswer});

  @override
  State<StatefulWidget> createState() {
    final state = ReviewPageWidgetState();
    controller.attach(state);
    return state;
  }
}

class ReviewPageWidgetState extends State<ReviewPageWidget> {
  final PageController pageController =
      PageController(initialPage: 0, viewportFraction: 0.8);

  nextPage() {
    pageController.nextPage(
        duration: Duration(milliseconds: 200), curve: Curves.ease);
  }

  @override
  Widget build(BuildContext context) {
    return pageView();
  }

  @override
  dispose() {
    super.dispose();
    pageController.dispose();
  }

  Widget pageView() {
    return PageView(
        controller: pageController,
        physics: NeverScrollableScrollPhysics(),
        children: List.from(
            widget.data.map((data) => ReviewCard(data, widget.onClickAnswer))));
  }
}

class ReviewCard extends StatefulWidget {
  final ReviewData data;
  final VoidCallback onClickAnswer;

  ReviewCard(this.data, this.onClickAnswer);

  @override
  State<StatefulWidget> createState() {
    return ReviewCardState();
  }
}

class ReviewCardState extends State<ReviewCard> {
  bool _isShowBack = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(bottom: 8),
        child: new InkWell(
            onTap: onClick,
            child: Card(
                elevation: 5,
                child: Column(children: [
                  Flexible(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Card(
                            elevation: 1,
                            child: Center(
                                child: Text(widget.data.front.content.value))),
                      )),
                  Flexible(
                      flex: 1,
                      child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Card(
                              elevation: 1,
                              child:
                                  Center(child: backView(widget.data.back)))))
                ]))));
  }

  onClick() {
    setState(() {
      _isShowBack = !_isShowBack;
      widget.onClickAnswer();
    });
  }

  backView(ReviewDataBack data) {
    if (!_isShowBack) {
      return Text(l10n.clickToSeeAnswer);
    }

    if (data.content.type == ReviewContentType.PIC) {
      return Image.file(File(data.content.value));
    } else {
      return Text(data.content.value);
    }
  }
}
