import 'dart:developer';
import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:dd_review/data/data_manager.dart';
import 'package:dd_review/data/review_data.dart';
import 'package:dd_review/l10n/localization_intl.dart';
import 'package:dd_review/scheduler/scheduler.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PicAddCardPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PicAddCardPageState();
  }
}

class _PicAddCardPageState extends State<PicAddCardPage> {
  final _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RaisedButton(onPressed: _onSelectPic, child: Text('test select pic')),
          RaisedButton(
              onPressed: _onSelectCamera, child: Text('test select camera')),
        ],
      )),
    ));
  }

  _onSelectPic() async {
    await _addReviewData(ImageSource.gallery);
  }

  _onSelectCamera() async {
    await _addReviewData(ImageSource.camera);
  }

  _addReviewData(ImageSource source) async {
    String path;
    try {
      final file = await _picker.getImage(source: source);
      path = file.path;
    } catch (e) {
      log('$e');
      BotToast.showText(text: l10n.getFailed);
      return;
    }

    String processPath;
    try {
      processPath = await _processPic(path);
      await File(path).delete(); // image picker 总是会复制图片，所以删掉比较好
    } catch (e) {
      log('$e');
      BotToast.showText(text: l10n.processPicFailed);
      return;
    }

    try {
      String storePath = await dataManager.storePic(processPath);
      await File(processPath).delete();
      final data = ReviewData.textPic('test front', storePath);
      await reviewScheduler.addReviewData(data);
      BotToast.showText(text: 'test success $storePath');
    } catch (e) {
      log('$e');
      BotToast.showText(text: l10n.saveFailed);
      return;
    }
  }

  Future<String> _processPic(String path) async {
    String tmpPath = await dataManager.storePic(path);
    return tmpPath;
  }
}
