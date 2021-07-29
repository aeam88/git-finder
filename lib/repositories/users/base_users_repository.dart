import '../repositories.dart';
import 'package:git_finder/models/user_model.dart';

abstract class BaseUserRepository extends BaseRepository {
  Future<List<User>> searchUsers({String query, int page});
  Future<User> findUser({String name});
}
