part of 'stopwatch_bloc.dart';

abstract class StopWatchState {
  final int minutes, seconds, centiseconds, counter, laps;
  final bool started, running;
  StopWatchState(
      {this.minutes,
      this.seconds,
      this.centiseconds,
      this.counter,
      this.laps,
      this.started,
      this.running});
}

class CounterInitialState extends StopWatchState {
  CounterInitialState()
      : super(
            minutes: 0,
            seconds: 0,
            centiseconds: 0,
            counter: 0,
            laps: 0,
            started: false,
            running: false);
}

class UpdateState extends StopWatchState {
  UpdateState(StopWatchState oldState,
      {int counter,
      int minute,
      int second,
      int centisecond,
      int laps,
      bool started,
      bool running})
      : super(
            counter: counter ?? oldState.counter,
            minutes: minute ?? oldState.minutes,
            seconds: second ?? oldState.seconds,
            centiseconds: centisecond ?? oldState.centiseconds,
            laps: laps ?? oldState.laps,
            started: started ?? oldState.started,
            running: running ?? oldState.running);
}
