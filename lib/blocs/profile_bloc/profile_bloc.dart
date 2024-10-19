import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixieapp/blocs/profile_bloc/profile_event.dart';
import 'package:pixieapp/blocs/profile_bloc/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final FirebaseFirestore firestore;
  final String userId;

  ProfileBloc(this.firestore, this.userId) : super(ProfileInitial()) {
    on<FetchChildName>(_onFetchChildName);
    on<UpdateChildName>(_onUpdateChildName);
  }

  Future<void> _onFetchChildName(FetchChildName event, Emitter<ProfileState> emit) async {
    try {
      emit(ProfileLoading());
      final doc = await firestore.collection('users').doc(userId).get();
      final name = doc['child_name'];
      emit(ProfileLoaded(name));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> _onUpdateChildName(UpdateChildName event, Emitter<ProfileState> emit) async {
    try {
      await firestore.collection('users').doc(userId).update({
        'child_name': event.newName,
      });
      emit(ProfileLoaded(event.newName));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}
