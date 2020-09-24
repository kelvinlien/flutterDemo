part of 'stopwatch_bloc.dart';

abstract class StopWatchState {
  final int hours, minutes, seconds, counter;
  final bool started, running;
  StopWatchState(
      {this.hours,
      this.minutes,
      this.seconds,
      this.counter,
      this.started,
      this.running});
}

class CounterInitialState extends StopWatchState {
  CounterInitialState()
      : super(
            hours: 0,
            minutes: 0,
            seconds: 0,
            counter: 0,
            started: false,
            running: false);
}

class UpdateState extends StopWatchState {
  UpdateState(StopWatchState oldState,
      {int counter, int hour, int minute, int second})
      : super(
            counter: counter ?? oldState.counter,
            hours: hour ?? oldState.hours,
            minutes: minute ?? oldState.minutes,
            seconds: second ?? oldState.seconds);
}
