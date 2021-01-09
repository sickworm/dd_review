
import 'package:dd_review/data/data_manager.dart';
import 'package:dd_review/data/review_data.dart';

abstract class IScheduler {
  Future<void> init();
  Future<List<ReviewData>> getData();
  Future<void> onReview(ReviewData data);
}

class StartUpScheduler implements IScheduler {
  List<ReviewData> _cache;
  Future _initJob;

  @override
  Future<void> init() async {
    _initJob = DataManager.getData();
    _cache = await _initJob;
  }

  @override
  Future<List<ReviewData>> getData() async {
    await _initJob;
    return _cache;
  }

  @override
  Future<void> onReview(ReviewData data) async {
    await _initJob;
    _cache.remove(data);
  }
}

