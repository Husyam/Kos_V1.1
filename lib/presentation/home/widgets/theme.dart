import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color blackColor = const Color(0XFF000000);
Color primaryColor = const Color(0XFF1C88C5);
Color secondaryColor = const Color(0XFFACECFE);
Color greyColor = const Color(0XFF6D6D6D);
Color redColor = const Color(0XFFF92929);
//Color greyColor2 = const Color(0XFFEBF0FF);
Color bgColor = const Color(0XFFFAFAFA);
Color whiteColor = const Color(0XFFFFFFFF);
Color kTransparentColor = Colors.transparent;

double defaultMargin = 24.0;
double defaultRadius = 8;

//create TextStyle blackColor fontweight bold
TextStyle blackBoldTextStyle = GoogleFonts.poppins(
  fontWeight: FontWeight.w700,
  color: blackColor,
);

//create TextStyle blackColor fontweight medium
TextStyle blackMediumTextStyle = GoogleFonts.poppins(
  fontWeight: FontWeight.w500,
  color: blackColor,
);

//create TextStyle primaryColor fontweight regular
TextStyle primaryRegularTextStyle = GoogleFonts.poppins(
  fontWeight: FontWeight.w400,
  color: primaryColor,
);

//create TextStyle primaryColor fontweight medium
TextStyle primaryMediumTextStyle = GoogleFonts.poppins(
  fontWeight: FontWeight.w500,
  color: primaryColor,
);

//create TextStyle greyColor fontweight medium
TextStyle greyMediumTextStyle = GoogleFonts.poppins(
  fontWeight: FontWeight.w500,
  color: greyColor,
);

//create TextStyle greyColor fontweight regular
TextStyle greyRegularTextStyle = GoogleFonts.poppins(
  fontWeight: FontWeight.w400,
  color: greyColor,
);

//create TextStyle greyColor fontweight light
TextStyle greyLightTextStyle = GoogleFonts.poppins(
  fontWeight: FontWeight.w400,
  color: greyColor,
);

//create TextStyle redColor fontweight medium
TextStyle redMediumTextStyle = GoogleFonts.poppins(
  fontWeight: FontWeight.w500,
  color: redColor,
);

//create TextStyle whiteColor fontweight medium
TextStyle whiteMediumTextStyle = GoogleFonts.poppins(
  fontWeight: FontWeight.w500,
  color: whiteColor,
);
