import 'package:dd_review/data/review_data.dart';

abstract class IDataSource {
  Future<List<ReviewData>> getData();
}

class MockDataSource implements IDataSource {
  @override
  Future<List<ReviewData>> getData() {
    return Future.value([
      ReviewData.string('card 1 front', 'card 1 back'),
      ReviewData.string('card 2 front', 'card 2 back'),
      ReviewData.string('card 3 front', 'card 3back')
    ]);
  }
}

// ignore: non_constant_identifier_names
final DataManager = MockDataSource();
