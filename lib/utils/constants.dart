// const  = Color(0xff);
import 'dart:math';
import 'dart:ui';

import '../models/weight_model.dart';

const darkOrangeColor = Color(0xffEE2F24);
const orangeColor = Color(0xffFE9702);
const redColor = Color(0xffEE2F24);




// get random string from this function

String getRandomString(int length) {
  const chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random rnd = Random();
  return String.fromCharCodes(
    Iterable.generate(
      length,
          (_) => chars.codeUnitAt(
        rnd.nextInt(chars.length),
      ),
    ),
  );
}
