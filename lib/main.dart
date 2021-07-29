import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:git_finder/repositories/repositories.dart';

import 'blocs/blocs.dart';
import 'screens/screens.dart';

void main() {
  EquatableConfig.stringify = kDebugMode;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => UsersRepository(),
      child: BlocProvider(
        create: (context) =>
            UsersBloc(usersRepository: context.read<UsersRepository>())
              ..add(UsersSearchUsers(query: 'jeam')),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Git Finder',
          theme: ThemeData(
            appBarTheme: AppBarTheme(
              iconTheme: IconThemeData(color: Colors.black), // 1
            ),
            primarySwatch: Colors.blue,
          ),
          home: UsersScreen(),
        ),
      ),
    );
  }
}
