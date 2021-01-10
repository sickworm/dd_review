import 'package:dd_review/data/review_data.dart';

abstract class IDataSource {
  Future<List<ReviewData>> getData();
}

class DummyDataSource extends IDataSource {
  @override
  Future<List<ReviewData>> getData() {
    return Future.value([
      ReviewData.string('卡片问题 1', '卡片答案 1'),
      ReviewData.string('卡片问题 2', '卡片答案 2'),
      ReviewData.string('卡片问题 3', '卡片答案 3')
    ]);
  }
}

final dataManager = DummyDataSource();
