import 'package:hive_benchmark/runners/runner.dart';

import '../sqlite_store.dart';

class SqfliteRunner implements BenchmarkRunner {
  late SqfliteStore store;

  @override
  String get name => 'sqflite';

  @override
  Future<void> setUp() async {
    store = SqfliteStore();
    await store.init();
  }

  @override
  Future<void> tearDown() async {
    await store.close();
  }

  @override
  Future<int> batchReadInt(List<String> keys) async {
    var s = Stopwatch()..start();
    for (var key in keys) {
      await store.getInt(key);
    }
    s.stop();
    return s.elapsedMilliseconds;
  }

  @override
  Future<int> batchReadString(List<String> keys) async {
    var s = Stopwatch()..start();
    for (var key in keys) {
      await store.getString(key);
    }
    s.stop();
    return s.elapsedMilliseconds;
  }

  @override
  Future<int> batchWriteInt(Map<String, int> entries) async {
    var s = Stopwatch()..start();
    for (var key in entries.keys) {
      await store.putInt(key, entries[key]!);
    }
    s.stop();
    return s.elapsedMilliseconds;
  }

  @override
  Future<int> batchWriteString(Map<String, String> entries) async {
    var s = Stopwatch()..start();
    for (var key in entries.keys) {
      await store.putString(key, entries[key]!);
    }
    s.stop();
    return s.elapsedMilliseconds;
  }

  @override
  Future<int> batchDeleteInt(List<String> keys) async {
    var s = Stopwatch()..start();
    for (var key in keys) {
      await store.deleteInt(key);
    }
    s.stop();
    return s.elapsedMilliseconds;
  }

  @override
  Future<int> batchDeleteString(List<String> keys) async {
    var s = Stopwatch()..start();
    for (var key in keys) {
      await store.deleteString(key);
    }
    s.stop();
    return s.elapsedMilliseconds;
  }
}
