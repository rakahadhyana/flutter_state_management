// Sync Action
import 'dart:convert';

import 'package:flutter_app_state_management/simple_flutter_redux/state/app_state.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux/redux.dart';
import 'package:http/http.dart' as http;

class IncrementAction {}

class UpdateQuoteAction {
  String _quote;
  String _author;

  String get quote => this._quote;
  String get author => this._author;

  UpdateQuoteAction(this._quote, this._author);
}

// ThunkAction
ThunkAction<AppState> getRandomQuote() {
  return (Store<AppState> store) async {
    http.Response response = await http.get(
      Uri.encodeFull(
          'https://quotesondesign.com/wp-json/wp/v2/posts/?orderby=rand'),
    );
    print(response.body);
    List<dynamic> result = json.decode(response.body);

    String quote = result[store.state.index]['content']['rendered']
        .replaceAll(new RegExp('[(<p>)(</p>)]'), '')
        .replaceAll(new RegExp('&#8217;'), '\'');
    String author = result[store.state.index]['title']['rendered'];

    store.dispatch(new UpdateQuoteAction(quote, author));
  };
}