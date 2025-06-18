import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/time_tracking.dart';
import '../data/time_tracking_repository.dart';

final timeTrackingControllerProvider =
StateNotifierProvider<TimeTrackingController, List<TimeTracking>>(
      (ref) => TimeTrackingController(TimeTrackingRepository()),
);

class TimeTrackingController extends StateNotifier<List<TimeTracking>> {
  final TimeTrackingRepository _repository;

  TimeTrackingController(this._repository) : super([]) {
    _loadRecords();
  }

  Future<void> _loadRecords() async {
    final records = await _repository.getRecords();
    state = records;
  }

  Future<void> checkIn(TimeTracking record) async {
    await _repository.addRecord(record);
    await _loadRecords();
  }

  Future<void> checkOut(String recordId, DateTime checkOutTime) async {
    await _repository.updateRecordCheckOut(recordId, checkOutTime);
    await _loadRecords();
  }
}
