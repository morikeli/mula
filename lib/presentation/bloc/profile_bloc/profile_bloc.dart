import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repositories/profile_repo.dart';


part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository _profileRepository;

  ProfileBloc(this._profileRepository) : super(ProfileInitial()) {
    on<UpdateProfileRequested>(_updateProfile);
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
