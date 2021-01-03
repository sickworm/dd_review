class ReviewData {
  final ReviewDataFront front;
  final ReviewDataBack back;

  ReviewData(this.front, this.back);

  ReviewData.string(String front, String back)
      : this(ReviewDataFront(front), ReviewDataBack(back));

  static ReviewData getTestData(int index) {
    return ReviewData.string('card $index front', 'card $index back');
  }
}

class ReviewDataFront {
  final String content;

  ReviewDataFront(this.content);
}

class ReviewDataBack {
  final String content;

  ReviewDataBack(this.content);
}
