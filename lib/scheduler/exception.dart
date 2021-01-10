import 'package:dd_review/l10n/localization_intl.dart';

class ReviewException implements Exception {
  ReviewException(this.code, this.message);

  final int code;
  final String message;

  static Exception get saveFailed => ReviewException(1, l10n.saveFailed);

  static Exception get processPicFailed =>
      ReviewException(1, l10n.processPicFailed);
}
