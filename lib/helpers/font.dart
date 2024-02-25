import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FontStyles {
  static TextStyle tajawalRegular({Color color = Colors.white}) {
    return GoogleFonts.tajawal(
      fontWeight: FontWeight.w400,
      color: color,
    );
  }

  static TextStyle tajawalBold = GoogleFonts.tajawal(
    fontWeight: FontWeight.w700,
  );
}
