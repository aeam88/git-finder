import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:git_finder/models/failure_model.dart';
import 'package:http/http.dart' as http;

import 'package:git_finder/models/user_model.dart';
import 'package:git_finder/repositories/repositories.dart';

class UsersRepository extends BaseUserRepository {
  static const String _gitBaseUrl = 'https://api.github.com';
  static const int numPerPage = 10;

  String followers = '0';

  final http.Client _httpClient;

  UsersRepository({http.Client httpClient})
      : _httpClient = httpClient ?? http.Client();

  @override
  void dispose() {
    _httpClient.close();
  }

  @override
  Future<List<User>> searchUsers({@required String query, int page = 1}) async {
    final url =
        '$_gitBaseUrl/search/users?q=$query&page=$page&per_page=$numPerPage';

    final response = await _httpClient.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List results = data['items'];
      final List<User> users = results.map((e) => User.fromMap(e)).toList();

      return users;
    }
    throw Failure();
  }

  @override
  Future<User> findUser({@required String name}) async {
    final url = '$_gitBaseUrl/users/$name';

    final resp = await _httpClient.get(url);

    if (resp.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(resp.body);
      final User usuario = User.fromMap(data);

      return usuario;
    }

    final User usua = User(
      id: 0,
      username: '',
      photo: '',
      url: '',
      siteAdmin: false,
      following: 0,
      followers: 0,
      name: '',
      email: '',
      bio: '',
      repos: 0,
    );
    return usua;
  }
}
