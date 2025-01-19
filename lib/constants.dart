// const k...

import 'package:flutter/material.dart';

const Color kPrimaryColor1 = Color(0xff013032);
const Color kPrimaryColor2 = Color(0xff0F5252);
const Color kPrimaryColor3 = Color(0xff0C6363);
const Color kPrimaryColor4 = Color(0xff087D7B);
const Color kPrimaryColor5 = Color(0xff04ACA7);
const Color kPrimaryColor6 = Color(0xff09C3BA);
const Color kPrimaryColor7 = Color(0xff21E0D3);
const Color kPrimaryColor8 = Color(0xff54F4E4);
const Color kPrimaryColor9 = Color(0xff93FCEE);
const Color kPrimaryColor10 = Color(0xffC9FEF6);
// ignore: constant_identifier_names
const Color KBackgroundColor = Color(0xffEFFEFB);

// ignore: constant_identifier_names
const KTransitionDuration = Duration(milliseconds: 250);
const String base = "http://127.0.0.1:8000";
const String baseurl = "$base" "/api/";
const String baseurlImg = '$base/storage/project/';

class SharedPrefKeys {
  static const String userToken = 'userToken';
}

Future<void> showCustomDialog({
  required BuildContext context,
  required String title,
  required String content,
}) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Close'),
        ),
      ],
    ),
  );
}
