import 'dart:async';
import 'package:blocSample/model/lap.dart';
import 'package:blocSample/database/db_helper.dart';

class LapController {
  static final LapController _lapCtrl = LapController._internal();
  DbHelper _dbHelper = DbHelper();

  factory LapController() {
    return _lapCtrl;
  }

  LapController._internal();
  void addLap(int minute, int second, int centisecond, int laps) async {
    // int order = await _dbHelper.getCurrentOrder() + 1;
    int id = laps + 1;
    Lap newLap =
        Lap(minute: minute, second: second, centisecond: centisecond, id: id);
    _dbHelper.insertLap(newLap);
  }

  Future<List<Lap>> getListOfLaps() async {
    List<Lap> lapsList = await _dbHelper.laps();
    return lapsList;
  }

  void clearLaps() async {
    await _dbHelper.deleteTable();
  }
}
