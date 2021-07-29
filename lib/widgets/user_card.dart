import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:git_finder/models/user_model.dart';
import 'package:git_finder/screens/screens.dart';
import 'package:google_fonts/google_fonts.dart';

class UserCard extends StatelessWidget {
  final User user;

  const UserCard({@required this.user});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => UserDetailScreen(
            userName: user.username,
          ),
        ),
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        elevation: 0,
        margin: EdgeInsets.only(bottom: 10.0),
        color: Color(0xFFDFE0E2),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 35.0,
                    backgroundColor: Color(0xFFC8CFD8),
                    backgroundImage: CachedNetworkImageProvider(user.photo),
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.username.toLowerCase(),
                        style: GoogleFonts.quicksand(
                            color: Color(0xFF8696AA),
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0),
                      ),
                      Text(
                        user.siteAdmin ? 'Administrador' : 'Usuario',
                        style: GoogleFonts.quicksand(
                            color: Color(0xFF8696AA), fontSize: 14.0),
                      ),
                    ],
                  ),
                ],
              ),
              Icon(
                Icons.chevron_right,
                color: Color(0xFF8696AA),
              ),
              //
            ],
          ),
        ),
      ),
    );
  }
}
