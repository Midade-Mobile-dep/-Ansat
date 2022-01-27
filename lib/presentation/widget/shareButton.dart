import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share/share.dart';

class ShareButton extends StatelessWidget {
  const ShareButton({Key? key, required this.shareTitle}) : super(key: key);

  final String shareTitle;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await Share.share(shareTitle);
      },
      child:Icon(Icons.share , size: 30,)
      //  SvgPicture.asset(
      //   'assets/Images/Home/share.svg',
      //   fit: BoxFit.scaleDown,
      // ),
    );
  }
}
