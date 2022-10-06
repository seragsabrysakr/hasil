part of 'intro_cubit.dart';

@immutable
abstract class IntroState {}

class IntroInitial extends IntroState {}
class IntroNextItem extends IntroState {}
class IntroFinish extends IntroState {}
class IntroSkip extends IntroState {}
