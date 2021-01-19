import 'package:flutter/material.dart';
import 'package:flutter_app_state_management/simple_flutter_redux/redux/actions.dart';
import 'package:flutter_app_state_management/simple_flutter_redux/redux/reducers.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import 'state/app_state.dart';

void main() {
  // store that hold our current appstate
  final store = new Store<AppState>(
      reducer,
      initialState: new AppState(0, "", "", 0),
      middleware: [thunkMiddleware]
  );
  runApp(new MyApp(
    store: store,
  ));
}

class MyApp extends StatelessWidget {
  final store;

  const MyApp({Key key, this.store}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: new MaterialApp(
        title: 'Flutter Demo',
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: new MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'You have pushed the button this many times:',
            ),
            StoreConnector<AppState, int>(
              converter: (store) => store.state.counter,
              builder: (_, counter) {
                return new Text(
                  '$counter',
                  style: Theme.of(context).textTheme.display1,
                );
              },
            ),

            // display random quote and its author
            StoreConnector<AppState, AppState>(
              converter: (store) => store.state,
              builder: (_, state) {
                return new Text(
                  ' ${state.quote} \n -${state.author}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 20.0),
                );
              },
            ),

            // generate quote button
            StoreConnector<AppState, VoidCallback>(
              converter: (store) => () => store.dispatch(getRandomQuote()),
              builder: (_, generateQuoteCallback) {
                return new FlatButton(
                    color: Colors.lightBlue,
                    onPressed: generateQuoteCallback,
                    child: new Text("generate random quote"));
              },
            )
          ],
        ),
      ),
      floatingActionButton: StoreConnector<AppState, VoidCallback>(
        converter: (store) => () => store.dispatch(IncrementAction()),
        builder: (_, incrementCallback) {
          return new FloatingActionButton(
            onPressed: incrementCallback,
            tooltip: 'Increment',
            child: new Icon(Icons.add),
          );
        },
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
