import 'dart:io';

import 'package:dd_review/data/review_data.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

abstract class IDataSource {
  Future<ReviewData> addData(ReviewData data);

  Future<void> init();

  Future<List<ReviewData>> getData();

  /// 存储到合适地方
  /// @return 存储路径
  Future<String> storePic(String filePath);
}

mixin FsStorage implements IDataSource {
  String storePath;
  String cachePath;

  Future<void> initFs() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    storePath = '${appDocDir.path}/cards';
    cachePath = '${appDocDir.path}/caches';
  }

  Future<String> storePic(String filePath) async {
    final newPath = "$storePath/${Uuid().v4()}.png";
    await File(newPath).create(recursive: true);
    File(filePath).copy(newPath);
    return newPath;
  }

  Future<String> saveTmpPic(String filePath) async {
    final newPath = "$cachePath/${Uuid().v4()}.png";
    await File(newPath).create(recursive: true);
    File(filePath).copy(newPath);
    return newPath;
  }
}

class DummyDataSource with FsStorage implements IDataSource {
  final cache = [
    ReviewData.text('卡片问题 1', '卡片答案 1'),
    ReviewData.text('卡片问题 2', '卡片答案 2'),
    ReviewData.text('卡片问题 3', '卡片答案 3')
  ];

  @override
  Future<void> init() {
    return Future.wait([initFs()]);
  }

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

final IDataSource dataManager = DummyDataSource();
