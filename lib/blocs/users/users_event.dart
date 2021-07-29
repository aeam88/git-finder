part of 'users_bloc.dart';

abstract class UsersEvent extends Equatable {
  const UsersEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class UsersSearchUsers extends UsersEvent {
  final String query;

  const UsersSearchUsers({@required this.query});

  @override
  List<Object> get props => [query];
}
