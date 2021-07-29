import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Follow extends StatelessWidget {
  final String texto;
  final int cantidad;

  const Follow({@required this.texto, @required this.cantidad});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          texto,
          style: GoogleFonts.quicksand(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16.0),
        ),
        const SizedBox(
          width: 5.0,
        ),
        CircleAvatar(
          radius: 10.0,
          backgroundColor: Colors.black87,
          child: Text(
            cantidad.toString(),
            style: GoogleFonts.quicksand(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 12.0),
          ),
        ),
      ],
    );
  }
}
