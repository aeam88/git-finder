import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class User extends Equatable {
  final int id;
  final String username;
  final String photo;
  final String url;
  final bool siteAdmin;
  final int following;
  final int followers;
  final String name;
  final String email;
  final String bio;
  final int repos;

  User({
    @required this.id,
    @required this.username,
    @required this.photo,
    @required this.url,
    @required this.siteAdmin,
    @required this.following,
    @required this.followers,
    @required this.name,
    @required this.email,
    @required this.bio,
    @required this.repos,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return User(
      id: map['id'],
      username: map['login'],
      photo: map['avatar_url'],
      url: map['html_url'],
      siteAdmin: map['site_admin'],
      following: map['following'] ?? 0,
      followers: map['followers'] ?? 0,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      bio: map['bio'] ?? '',
      repos: map['repos'] ?? 0,
    );
  }

  @override
  List<Object> get props => [
        id,
        username,
        photo,
        url,
        siteAdmin,
        following,
        followers,
        name,
        email,
        bio,
        repos,
      ];

  @override
  bool get stringify => true;
}
