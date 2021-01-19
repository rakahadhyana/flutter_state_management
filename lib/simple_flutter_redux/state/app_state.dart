// AppState
class AppState {
  int _counter;
  String _quote;
  String _author;
  int _index;

  int get counter => _counter;
  String get quote => _quote;
  String get author => _author;
  int get index => _index;

  AppState(this._counter, this._quote, this._author, this._index);
}