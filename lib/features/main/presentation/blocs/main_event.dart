part of 'main_bloc.dart';

@immutable
sealed class MainEvent {}

class TabUpdated extends MainEvent {
  final int tabIndex;

  TabUpdated(this.tabIndex);
}
