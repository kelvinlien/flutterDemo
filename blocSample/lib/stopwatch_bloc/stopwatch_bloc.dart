import 'package:bloc/bloc.dart';
part 'stopwatch_event.dart';
part 'stopwatch_state.dart';

class StopWatchBloc extends Bloc<StopWatchEvent, StopWatchState> {
  StopWatchBloc() : super(CounterInitialState());

  @override
  Stream<StopWatchState> mapEventToState(StopWatchEvent event) async* {
    if (event is IncreasingCounter) {
      int counter = event.payload + 1;
      int seconds = counter ~/ 100;
      int m = seconds ~/ 60;
      int s = seconds - (m * 60);
      int cs = counter - (seconds * 100);
      yield UpdateState(state,
          counter: counter,
          minute: m,
          second: s,
          centisecond: cs,
          running: true,
          started: true);
    } else if (event is ResetCounter) {
      yield UpdateState(state,
          counter: 0,
          minute: 0,
          second: 0,
          centisecond: 0,
          laps: 0,
          running: false,
          started: false);
    } else if (event is StopCounter) {
      yield UpdateState(state, running: false, started: true);
    } else if (event is AddLap) {
      yield UpdateState(state, laps: event.payload + 1);
    }
  }
}
