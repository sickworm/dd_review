class ReviewData {
  final ReviewDataFront front;
  final ReviewDataBack back;
  final DateTime nextReviewTime = DateTime.now();

  ReviewData(this.front, this.back);

  ReviewData.text(String front, String back)
      : this(ReviewDataFront(ReviewContent(ReviewContentType.TEXT, front)),
            ReviewDataBack(ReviewContent(ReviewContentType.TEXT, back)));

  ReviewData.pic(String front, String back)
      : this(ReviewDataFront(ReviewContent(ReviewContentType.PIC, front)),
            ReviewDataBack(ReviewContent(ReviewContentType.PIC, back)));

  ReviewData.textPic(String front, String back)
      : this(ReviewDataFront(ReviewContent(ReviewContentType.TEXT, front)),
            ReviewDataBack(ReviewContent(ReviewContentType.PIC, back)));
}

class ReviewDataFront {
  final ReviewContent content;

  ReviewDataFront(this.content);
}

class ReviewDataBack {
  final ReviewContent content;

  ReviewDataBack(this.content);
}

/// Uri
class ReviewContent {
  final ReviewContentType type;
  final String value;

  ReviewContent(this.type, this.value);
}

enum ReviewContentType { TEXT, PIC }

enum ReviewLevel { Easy, Normal, Hard }
