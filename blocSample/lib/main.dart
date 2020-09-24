import 'package:blocSample/stopwatch_bloc/stopwatch_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
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

  @override
  Widget build(BuildContext context) {
    _swBloc = BlocProvider.of<StopWatchBloc>(context);
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
                  '${state.hours.toString().padLeft(2, "0")}:${state.minutes.toString().padLeft(2, "0")}:${state.seconds.toString().padLeft(2, "0")}',
                  style: TextStyle(
                    fontSize: 90.0,
                  ),
                );
              },
            ),
            SizedBox(
              height: 100,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                RaisedButton(
                  child: Text('Add'),
                  onPressed: () {
                    print('${_swBloc.state.counter}');
                    _swBloc.add(
                      IncreasingCounter(_swBloc.state.counter),
                    );
                  },
                ),
                RaisedButton(
                  child: Text('Clear'),
                  onPressed: null,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
