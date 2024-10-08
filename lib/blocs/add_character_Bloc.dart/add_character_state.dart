import 'package:equatable/equatable.dart';
import 'package:pixieapp/models/Child_data_model.dart';
import 'package:pixieapp/models/story_model.dart';

class AddCharacterState extends Equatable {
  final int currentPageIndex;
  final Language language;
  final Lovedonces? lovedOnce;
  final String? lessons;
  final int? selectedindexlesson;
  final int selectedindex;
  final String genre;
  final String musicAndSpeed;

  const AddCharacterState(
      {required this.currentPageIndex,
      required this.language,
      required this.selectedindex,
      required this.selectedindexlesson,
      required this.genre,
      required this.musicAndSpeed,
      this.lessons,
      this.lovedOnce});

  // Create a copyWith method to update specific parts of the state
  AddCharacterState copyWith(
      {int? currentPageIndex,
      Language? language,
      Lovedonces? lovedOnce,
      String? lessons,
      int? selectedindex,
      int? selectedindexlesson,
      String? genre,
      String? musicAndSpeed}) {
    return AddCharacterState(
        currentPageIndex: currentPageIndex ?? this.currentPageIndex,
        language: language ?? this.language,
        lovedOnce: lovedOnce ?? this.lovedOnce,
        selectedindex: selectedindex ?? this.selectedindex,
        lessons: lessons ?? this.lessons,
        selectedindexlesson: selectedindexlesson ?? this.selectedindexlesson,
        genre: genre ?? this.genre,
        musicAndSpeed: musicAndSpeed ?? this.musicAndSpeed);
  }

  @override
  List<Object?> get props => [
        currentPageIndex,
        language,
        lovedOnce,
        lessons,
        selectedindex,
        selectedindexlesson,
        genre,
        musicAndSpeed
      ];
}
