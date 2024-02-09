import 'package:flutter/material.dart';

const kDark = Color(0xff666666);

OutlineInputBorder outlineBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(8),
  borderSide: const BorderSide(
    color: Colors.white24,
    width: 1,
  ),
);
UnderlineInputBorder inputBorder = const UnderlineInputBorder(
  borderSide: BorderSide(
    color: kDark,
    width: 1,
  ),
);

OutlineInputBorder focusedBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(8),
  borderSide: const BorderSide(
    color: kDark,
    width: 1,
  ),
);

OutlineInputBorder errorBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(8),
  borderSide: const BorderSide(
    color: Colors.red,
    width: 1,
  ),
);

//Transparent border
OutlineInputBorder transparentBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(8),
  borderSide: const BorderSide(
    color: Colors.transparent,
    width: 1,
  ),
);
String APP_ID = 'BC823AD1-FBEA-4F08-8F41-CF0D9D280FBF';
String CHANNEL_URL =
    'sendbird_open_channel_14092_bf4075fbb8f12dc0df3ccc5c653f027186ac9211';
