import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const String kApiKey = '72f1b2d35fbd17796607a4d989ae6476';
const String kOWMBaseUrl = 'https://api.openweathermap.org/data/2.5/weather';


const kLightColor = Colors.white10;
const kMidlightColor = Colors.white60;
const kOverlayColor = Colors.white10;
const kDarkColor = Colors.white24;
var kLocationTextStyle = GoogleFonts.monda(
  fontSize: 20,
  color: kMidlightColor,
);
var kTempTextStyle = GoogleFonts.daysOne(
  fontSize: 80,
  color: kMidlightColor,
);
const kTextFieldTestStyle = TextStyle(
  fontSize: 16,
  color: kMidlightColor,
);
var kDetailesTextStyle = GoogleFonts.monda(
    fontSize: 20, color: kMidlightColor, fontWeight: FontWeight.bold);
var kDetailsTitleTextStyle = GoogleFonts.monda(
  fontSize: 16,
  color: kDarkColor,

);
var kDetailsSuffixTextStyle =GoogleFonts.monda(
  fontSize: 12,
  color: kMidlightColor
);
const kTextFieldDecotation = InputDecoration(
  fillColor: kOverlayColor,
  filled: true,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
    borderSide: BorderSide.none,
  ),
  hintText: 'Enter City Name',
  hintStyle: kTextFieldTestStyle,
  prefixIcon: Icon(
    Icons.search,
    color: Colors.white30,
  ),
);
