import 'package:blocSample/stopwatch_bloc/stopwatch_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';
import 'package:blocSample/database/db_helper.dart';
import 'package:blocSample/controller/lap.dart';

// get instance of DbHelper
DbHelper _dbHelper = DbHelper();
LapController _lapCtrl = LapController();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // open Db before running app
  await _dbHelper.openDb();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<StopWatchBloc>(
            create: (context) => StopWatchBloc(),
          ),
        ],
        child: MaterialApp(
          home: MyHomePage(),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  StopWatchBloc _swBloc;
  Timer timer;
  final onesec = Duration(milliseconds: 10);

  @override
  Widget build(BuildContext context) {
    _swBloc = BlocProvider.of<StopWatchBloc>(context);

    FlatButton increaseCounter = FlatButton(
        child: Icon(Icons.exposure_plus_1),
        onPressed: () =>
            {_swBloc.add(IncreasingCounter(_swBloc.state.counter))});

    RaisedButton resumeButton = RaisedButton(
      child: Text('Resume'),
      onPressed: () {
        timer =
            Timer.periodic(onesec, (timer) => {increaseCounter.onPressed()});
      },
    );

    RaisedButton startButton = RaisedButton(
      child: Text('Start'),
      onPressed: () {
        timer =
            Timer.periodic(onesec, (timer) => {increaseCounter.onPressed()});
      },
    );

    RaisedButton stopButton = RaisedButton(
      child: Text('Stop'),
      onPressed: () {
        timer.cancel();
        _swBloc.add(
          StopCounter(_swBloc.state.counter),
        );
      },
    );

    RaisedButton resetButton = RaisedButton(
      child: Text('Reset'),
      onPressed: () {
        timer.cancel();
        _swBloc.add(
          ResetCounter(_swBloc.state.counter),
        );
        _lapCtrl.clearLaps();
      },
    );

    RaisedButton disabledResetButton = RaisedButton(
      child: Text('Reset'),
      onPressed: null,
    );

    RaisedButton lapButton = RaisedButton(
      child: Text("Lap"),
      onPressed: () {
        _swBloc.add(
          AddLap(_swBloc.state.counter),
        );
        _lapCtrl.addLap(_swBloc.state.minutes, _swBloc.state.seconds,
            _swBloc.state.centiseconds, _swBloc.state.laps);
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Stop watch'),
      ),
      body: Container(
        child: Column(
          children: [
            BlocBuilder<StopWatchBloc, StopWatchState>(
              builder: (context, state) {
                return Text(
                  '${state.minutes.toString().padLeft(2, "0")}:${state.seconds.toString().padLeft(2, "0")}:${state.centiseconds.toString().padLeft(2, "0")}',
                  style: TextStyle(
                    fontSize: 90.0,
                  ),
                );
              },
            ),
            SizedBox(
              height: 100,
            ),
            BlocBuilder<StopWatchBloc, StopWatchState>(
              builder: (context, state) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    !state.started
                        ? startButton
                        : state.running ? stopButton : resumeButton,
                    !state.started
                        ? disabledResetButton
                        : state.running ? lapButton : resetButton
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
