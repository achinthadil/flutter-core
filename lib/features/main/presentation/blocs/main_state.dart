part of 'main_bloc.dart';

@immutable
sealed class MainState {}

final class MainInitial extends MainState {}

class TabState extends MainState {
  final int currentIndex;

  TabState(this.currentIndex);
}
