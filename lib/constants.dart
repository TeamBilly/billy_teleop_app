import 'package:flutter/material.dart';

final String robotIP_global = "10.188.27.70";
final String deviceIP_global = "10.188.145.139";
final String streamUrl = 'http:/'+ robotIP_global +':8080/stream?topic=/camera/rgb/image_raw&type=mjpeg&quality=80&width=350&height=350';

final kHintTextStyle = TextStyle(
  color: Colors.white54,
  fontFamily: 'OpenSans',
);

final kLabelStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

final kBoxDecorationStyle = BoxDecoration(
  color: Color(0xFF6CA8F1),
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);

final kBoxDecorationArrowControllerStyle = BoxDecoration(
  color: Colors.black12,
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);



final kBoxDecorationNavigationMapStyle = BoxDecoration(
  color: Colors.black12,
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);