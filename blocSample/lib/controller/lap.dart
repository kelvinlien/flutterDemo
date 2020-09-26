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
    int order = laps + 1;
    print("order " +
        order.toString() +
        " minute " +
        minute.toString() +
        " second " +
        second.toString() +
        " minisecond " +
        centisecond.toString());
    Lap newLap = Lap(
        minute: minute, second: second, centisecond: centisecond, order: order);
    _dbHelper.insertLap(newLap);
  }

  void clearLaps() async {
    await _dbHelper.deleteTable();
  }
}
