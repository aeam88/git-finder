part of 'users_bloc.dart';

enum UserStatus { initial, loading, loaded, paginating, noMoreUsers, error }

class UsersState extends Equatable {
  final String query;
  final List<User> users;
  final UserStatus status;
  final Failure failure;

  const UsersState(
      {@required this.query,
      @required this.users,
      @required this.status,
      @required this.failure});

  factory UsersState.initial() {
    return UsersState(
      query: '',
      users: [],
      status: UserStatus.initial,
      failure: null,
    );
  }

  @override
  List<Object> get props => [query, users, status, failure];

  @override
  bool get stringify => true;

  UsersState copyWith({
    String query,
    List<User> users,
    UserStatus status,
    Failure failure,
  }) {
    return UsersState(
      query: query ?? this.query,
      users: users ?? this.users,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }
}
