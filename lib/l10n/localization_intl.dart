import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'messages_all.dart';

L10n l10n;

class L10n {
  static AppLocalizationsDelegate delegate = AppLocalizationsDelegate();

  static init(BuildContext context) {
    l10n = L10n.of(context);
  }

  static Future<L10n> load(Locale locale) {
    final String name =
        locale.countryCode == null ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((bool _) {
      Intl.defaultLocale = localeName;
      return new L10n();
    });
  }

  static L10n of(BuildContext context) {
    return Localizations.of<L10n>(context, L10n);
  }

  String get title => Intl.message('DD Flashcards', name: 'title');

  String get easy => Intl.message('Easy', name: 'easy');

  String get normal => Intl.message('Normal', name: 'normal');

  String get hard => Intl.message('Hard', name: 'hard');

  String get clickToSeeAnswer =>
      Intl.message('点击查看答案', name: 'clickToSeeAnswer');

  String get finishReview => Intl.message('恭喜你完成今天复习！', name: 'finishReview');

  String get returnToMain => Intl.message('返回主界面', name: 'returnToMain');

  String get pageError => Intl.message('页面出错啦', name: 'pageError');
}

class AppLocalizationsDelegate extends LocalizationsDelegate<L10n> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'zh'].contains(locale.languageCode);
  }

  @override
  Future<L10n> load(Locale locale) {
    return L10n.load(locale);
  }

  @override
  bool shouldReload(LocalizationsDelegate<L10n> old) {
    return false;
  }
}
