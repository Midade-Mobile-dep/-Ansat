import '../resources/color_manager.dart';
import '../resources/styles_manager.dart';
import '../widget/back_arrow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'dart:io';

import 'package:webview_flutter/webview_flutter.dart';

class SoundCloudTab extends StatelessWidget {
  final String title;

  final String link;
  final String imageUrl;
  SoundCloudTab(
      {Key? key, required this.link, required this.title, required this.imageUrl}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 60,
          // backgroundColor: Colors.white,
          actions:  [
          
          
           Padding(
             padding: const EdgeInsets.all(3.0),
             child: Image.network(imageUrl,
          // scale: 2,
          // fit: BoxFit.scaleDown,
             ),
           ),
            const SizedBox(
              width: 20,
            ),
          ],

          automaticallyImplyLeading: false,
          title: Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Text(
              title,
              style: getBoldStyle(color: ColorManager.white),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          leading:const BackArrow(),
          centerTitle: true,
        ),
      
        body: WebView(
          initialUrl:
              link, //'https://soundcloud.com/salem-tech-782013788/ebrahim-p01',
          allowsInlineMediaPlayback: true,
          debuggingEnabled: true,
          gestureNavigationEnabled: true,
          initialMediaPlaybackPolicy: AutoMediaPlaybackPolicy.always_allow,
          javascriptMode: JavascriptMode.unrestricted,
          onWebResourceError: (_) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Row(
                children: const <Widget>[
                  Icon(
                    Icons.error_outline_rounded,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    'حدث خطأ',
                  )
                ],
              ),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 2),
            ));
          },
        ),
      ),
    );
  }
}
