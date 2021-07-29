import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:git_finder/models/failure_model.dart';
import 'package:git_finder/models/user_model.dart';
import 'package:git_finder/repositories/repositories.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final UsersRepository _usersRepository;

  UsersBloc({@required UsersRepository usersRepository})
      : _usersRepository = usersRepository,
        super(UsersState.initial());

  @override
  Future<void> close() {
    _usersRepository.dispose();
    return super.close();
  }

  @override
  Stream<UsersState> mapEventToState(
    UsersEvent event,
  ) async* {
    if (event is UsersSearchUsers) {
      yield* _mapUsersSearchUsersToState(event);
    }
  }

  Stream<UsersState> _mapUsersSearchUsersToState(
      UsersSearchUsers event) async* {
    yield state.copyWith(query: event.query, status: UserStatus.loading);

    try {
      final users = await _usersRepository.searchUsers(query: event.query);
      yield state.copyWith(users: users, status: UserStatus.loaded);
    } catch (err) {
      print(err);
      yield state.copyWith(
          failure: Failure(
            message: 'Something went wrong! Please try a different search',
          ),
          status: UserStatus.error);
    }
  }
}
