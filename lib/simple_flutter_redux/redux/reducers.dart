// Reducer
import '../state/app_state.dart';
import 'actions.dart';

AppState reducer(AppState prev, dynamic action) {
  if (action is IncrementAction) {
    AppState newAppState = AppState(prev.counter + 1, prev.quote, prev.author, prev.index);
    return newAppState;
  } else if (action is UpdateQuoteAction) {
    AppState newAppState = AppState(prev.counter, action.quote, action.author, prev.index + 1);
    return newAppState;
  }
  return prev;
}