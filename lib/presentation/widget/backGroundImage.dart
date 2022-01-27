import '../resources/assets_manager.dart';
import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({
    Key? key,required this.child,
  }) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection:TextDirection.rtl ,
      child: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
          image: AssetImage(
            ImageAssets.splashLogo,
            
          ),
        )),
        child: child
      ),
    );
  }
}
