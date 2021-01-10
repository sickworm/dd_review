import 'package:dd_review/data/data_manager.dart';
import 'package:dd_review/data/review_data.dart';

abstract class ReviewStatusUpdateCallback {
  onUpdate(List<ReviewData> data);
}

mixin _CallbackServer {
  Set<ReviewStatusUpdateCallback> _callbacks = Set();

  registerCallback(ReviewStatusUpdateCallback callback) {
    _callbacks.add(callback);
  }

  unregisterCallback(ReviewStatusUpdateCallback callback) {
    _callbacks.remove(callback);
  }

  _dispatch(List<ReviewData> data) {
    _callbacks.forEach((element) {
      element.onUpdate(List.from(data));
    });
  }
}

abstract class IReviewScheduler {
  Future<void> init();

  Future<List<ReviewData>> getReviewData();

  Future<void> addReviewData(ReviewData data);

  Future<void> onReviewed(ReviewLevel level, ReviewData data);

  registerCallback(ReviewStatusUpdateCallback callback);

  unregisterCallback(ReviewStatusUpdateCallback callback);
}

/// 每次启动全量读取数据进行复习，复习后删除
class DummyReviewScheduler with _CallbackServer implements IReviewScheduler {
  List<ReviewData> _cache = [];
  Future _initJob;

  @override
  Future<void> init() async {
    _initJob = dataManager
        .init()
        .then((value) => dataManager.getData())
        .then((value) => _cache = value);
    return _initJob;
  }

  @override
  Future<List<ReviewData>> getReviewData() async {
    await _initJob;
    return List.from(_cache);
  }

  @override
  Future<void> addReviewData(ReviewData data) async {
    await _initJob;
    await dataManager.addData(data);
    _cache.add(data);
    _dispatch(_cache);
  }

  @override
  Future<void> onReviewed(ReviewLevel level, ReviewData data) async {
    await _initJob;
    _cache.remove(data);
    _dispatch(_cache);
  }
}

final IReviewScheduler reviewScheduler = DummyReviewScheduler();
