import 'package:dd_review/l10n/localization_intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReviewFinishPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
              Text(l10n.finishReview),
              RaisedButton(
                  onPressed: () => onPressed(context),
                  child: Text(l10n.returnToMain))
            ]))));
  }

  onPressed(BuildContext context) {
    Navigator.popUntil(context, ModalRoute.withName('/main'));
  }
}
