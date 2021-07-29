import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:git_finder/blocs/blocs.dart';
import 'package:git_finder/widgets/widgets.dart';

class UsersScreen extends StatefulWidget {
  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => print('cargar'),
      // onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Color(0xFFE8E8E8),
        body: SafeArea(
          child: BlocBuilder<UsersBloc, UsersState>(
            builder: (context, state) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  Column(
                    children: [
                      const SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextField(
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 10.0),
                            prefixIcon: Icon(
                              Icons.search,
                              color: Color(0xFF8696AA),
                            ),
                            hintText: 'Buscar usuario...',
                            hintStyle: GoogleFonts.quicksand(
                              color: Color(0xFF8696AA),
                              fontWeight: FontWeight.w600,
                            ),
                            fillColor: Color(0xFFC8CFD8),
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                          ),
                          onSubmitted: (val) {
                            if (val.trim().isNotEmpty) {
                              context.read<UsersBloc>().add(
                                    UsersSearchUsers(query: val.trim()),
                                  );
                            }
                          },
                        ),
                      ),
                      if (state.status == UserStatus.loaded)
                        Expanded(
                          child: state.users.isNotEmpty
                              ? ListView.builder(
                                  padding: EdgeInsets.all(20.0),
                                  itemCount: state.users.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final user = state.users[index];
                                    return UserCard(
                                      user: user,
                                    );
                                  },
                                )
                              : Center(
                                  child: Text('No hay resultados'),
                                ),
                        ),
                    ],
                  ),
                  if (state.status == UserStatus.loading)
                    CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Color(0xFF8696AA)),
                    )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
