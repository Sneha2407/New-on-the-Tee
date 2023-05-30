import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

TextStyle mcLaren(Color color, int size) {
  return GoogleFonts.mcLaren(
    fontWeight: FontWeight.w400,
    fontSize: size.sp,
    color: color,
  );
}

TextStyle montserrat(Color color, int size) {
  return GoogleFonts.montserrat(
    fontWeight: FontWeight.w400,
    fontSize: size.sp,
    color: color,
  );
}

TextStyle regularBrush() {
  return TextStyle(
      fontFamily: 'Regular Brush',
      fontSize: 30.sp,
      color: Kcolors.white,
      fontWeight: FontWeight.w400);
}
