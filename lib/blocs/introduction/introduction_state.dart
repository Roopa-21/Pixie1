import 'package:pixieapp/models/Child_data_model.dart';

abstract class IntroductionState {}

class TextInitial extends IntroductionState {}

class TextUpdated extends IntroductionState {
  final String name;
  TextUpdated({required this.name});
}


class GenderInitial extends IntroductionState {}

class GenderUpdated extends IntroductionState {
  final Gender gender;
  GenderUpdated({required this.gender});
}
