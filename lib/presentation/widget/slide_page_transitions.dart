import 'package:flutter/material.dart';


pushSlide(BuildContext context,
    {Widget? screen, Object? args, bool fromLeft = false}) {
  Navigator.of(context).push(PageRouteBuilder(
    settings: RouteSettings(arguments: args),
    pageBuilder: (context, animation, secondaryAnimation) => screen!,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(!fromLeft ? 1.0 : -1.0, 0.0);
      var end = Offset.zero;
      var curve = Curves.easeOut;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  ));
}

pushReplacementSlide(BuildContext context,
    {Widget? screen, Object? args, bool fromLeft = false}) {
  Navigator.of(context).push(PageRouteBuilder(
    settings: RouteSettings(arguments: args),
    pageBuilder: (context, animation, secondaryAnimation) => screen!,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(!fromLeft ? 1.0 : -1.0, 0.0);
      var end = Offset.zero;
      var curve = Curves.easeOut;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  ));
}
