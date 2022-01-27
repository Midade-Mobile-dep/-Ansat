import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BackArrow extends StatelessWidget {
  const BackArrow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return
       Tooltip(
        message: 'رجوع',
        child: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const RotatedBox(
              quarterTurns: 2, child: Icon(Icons.arrow_back_ios_new)),
        ),
      );
    
    });
  }
}
