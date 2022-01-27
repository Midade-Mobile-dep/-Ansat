
import 'package:flutter/material.dart';


double getwidth({context, double width=1.0}) =>
    MediaQuery.of(context).size.width * width;
double getheight({context, double height =1.0}) =>
    MediaQuery.of(context).size.width * height;

// AppConfig.height = MediaQuery.of(context).size.height;
// AppConfig.blockSize = AppConfig.width / 100;
// AppConfig.blockSizeVertical = AppConfig.height / 100;
