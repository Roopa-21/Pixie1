import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

abstract class FetchStoryEvent extends Equatable {
  const FetchStoryEvent();

  @override
  List<Object?> get props => [];
}

class FetchStories extends FetchStoryEvent {
  final DocumentReference userId;

  const FetchStories(this.userId);

  @override
  List<Object?> get props => [userId];
}

class AddfilterEvent extends FetchStoryEvent {
  final String filter;

  const AddfilterEvent({required this.filter});

  @override
  List<Object?> get props => [filter];
}
