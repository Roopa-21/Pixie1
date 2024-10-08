abstract class IntroductionEvent {}

class TextChanged extends IntroductionEvent {
  final String name;
  TextChanged({required this.name});
}



class GenderChanged extends IntroductionEvent {
  final Enum gender;
  GenderChanged({required this.gender});
}


