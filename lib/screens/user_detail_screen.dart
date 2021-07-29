import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:git_finder/widgets/widgets.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:git_finder/models/user_model.dart';
import 'package:git_finder/repositories/repositories.dart';

class UserDetailScreen extends StatefulWidget {
  final String userName;

  const UserDetailScreen({@required this.userName});

  @override
  _UserDetailScreenState createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  User _usuario;

  double _deviceHeight;
  double _deviceWidth;

  @override
  void initState() {
    super.initState();

    _getUsuario();
  }

  Future<void> _getUsuario() async {
    final usu = await UsersRepository().findUser(name: widget.userName);
    if (mounted) {
      setState(() {
        _usuario = usu;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Color(0xFFE8E8E8),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: _usuario != null
          ? Stack(
              children: [
                Container(
                  height: _deviceHeight,
                  width: _deviceWidth,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(
                        _usuario.photo,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 17.0,
                      sigmaY: 17.0,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.2),
                      ),
                    ),
                  ),
                ),
                SafeArea(
                  child: Container(
                    height: _deviceHeight,
                    width: _deviceWidth,
                    padding: EdgeInsets.only(bottom: _deviceHeight * 0.1),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: _deviceWidth * 0.40,
                          height: 220.0,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                _usuario.photo,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          _usuario.name,
                          style: GoogleFonts.quicksand(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 22.0),
                        ),
                        const SizedBox(
                          height: 2.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            _usuario.bio,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.quicksand(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 18.0),
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Follow(
                                texto: 'Following',
                                cantidad: _usuario.following),
                            const SizedBox(
                              width: 12.0,
                            ),
                            Follow(
                                texto: 'Followers',
                                cantidad: _usuario.followers),
                          ],
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(horizontal: 40.0),
                          child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.black,
                              primary: Colors.white,
                            ),
                            onPressed: () => _lanzarUrl(url: _usuario.url),
                            child: Text(
                              'Visitar perfíl',
                              style: GoogleFonts.quicksand(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )
          : Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF8696AA)),
              ),
            ),
    );
  }

  Future<void> _lanzarUrl({String url}) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }
}
