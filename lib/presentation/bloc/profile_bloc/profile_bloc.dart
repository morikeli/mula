import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../../data/models/user_model.dart';
import '../../../data/repositories/profile_repo.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository _profileRepository;

  ProfileBloc(this._profileRepository) : super(ProfileInitial()) {
    on<UpdateProfileRequested>(_updateProfile);
    on<SearchUsers>(
      _onSearch,
      transformer: _debounce(const Duration(milliseconds: 300)),
    );
  }

  /// Trigger event after user stops typing for 300ms to avoid excessive read to the database
  EventTransformer<T> _debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).switchMap(mapper);
  }

  Future<void> _onSearch(SearchUsers event, Emitter<ProfileState> emit) async {
    emit(UserSearchLoading());

    try {
      final users = await _profileRepository.searchUsers(event.query);
      emit(UserSearchLoaded(users));
    } catch (e) {
      emit(UserSearchError(e.toString()));
    }
  }

  Future<void> _updateProfile(
    UpdateProfileRequested event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      emit(ProfileLoading());

      await _profileRepository.updateUserProfile(
        username: event.username,
        firstName: event.firstName,
        lastName: event.lastName,
        profileImage: event.profileImage,
      );

      emit(ProfileSuccess());
    } catch (e) {
      emit(ProfileFailure(e.toString()));
    }
  }
}
