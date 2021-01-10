import 'package:dd_review/data/review_data.dart';

abstract class IDataSource {
  Future<ReviewData> addData(ReviewData data);

  Future<List<ReviewData>> getData();
}

class DummyDataSource extends IDataSource {
  final cache = [
    ReviewData.string('卡片问题 1', '卡片答案 1'),
    ReviewData.string('卡片问题 2', '卡片答案 2'),
    ReviewData.string('卡片问题 3', '卡片答案 3')
  ];

  @override
  Future<List<ReviewData>> getData() {
    return Future.value(List.from(cache));
  }

  @override
  Future<ReviewData> addData(ReviewData data) {
    return Future.sync(() {
      cache.add(data);
      return;
    });
  }
}

final dataManager = DummyDataSource();
