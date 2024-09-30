import 'package:equatable/equatable.dart';

class AddCharacterState extends Equatable {
  final int currentpageindex;

  const AddCharacterState({required this.currentpageindex});

  @override
  List<Object?> get props => [currentpageindex];
}
