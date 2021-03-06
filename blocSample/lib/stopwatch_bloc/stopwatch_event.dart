part of 'stopwatch_bloc.dart';

abstract class StopWatchEvent {
  final dynamic payload;
  StopWatchEvent({this.payload});
}

class IncreasingCounter extends StopWatchEvent {
  IncreasingCounter(int counter) : super(payload: counter);
}

class StopCounter extends StopWatchEvent {
  StopCounter(int counter) : super(payload: counter);
}

class ResetCounter extends StopWatchEvent {
  ResetCounter(int counter) : super(payload: counter);
}

class AddLap extends StopWatchEvent {
  AddLap(int counter) : super(payload: counter);
}
