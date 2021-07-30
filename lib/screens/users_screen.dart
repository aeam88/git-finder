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
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.offset ==
                _scrollController.position.maxScrollExtent &&
            context.read<UsersBloc>().state.status != UserStatus.paginating) {
          context.read<UsersBloc>().add(UserPaginate());
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => print('cargar'),
      // onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Color(0xFFE8E8E8),
        body: SafeArea(
          child: BlocConsumer<UsersBloc, UsersState>(
            listener: (context, state) {
              if (state.status == UserStatus.paginating) {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Cargando más usuarios...'),
                    backgroundColor: Color(0xFF8696AA),
                    duration: Duration(seconds: 1),
                  ),
                );
              } else if (state.status == UserStatus.noMoreUsers) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('No hay más usuarios.'),
                    backgroundColor: Color(0xFFEF9A9A),
                    duration: Duration(milliseconds: 1500),
                  ),
                );
              } else if (state.status == UserStatus.error) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Error en la busqueda'),
                    content: Text(state.failure.message),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text('OK'),
                      ),
                    ],
                  ),
                );
              }
            },
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
                      Expanded(
                        child: state.users.isNotEmpty
                            ? ListView.builder(
                                controller: _scrollController,
                                padding: EdgeInsets.all(20.0),
                                itemCount: state.users.length,
                                itemBuilder: (BuildContext context, int index) {
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
