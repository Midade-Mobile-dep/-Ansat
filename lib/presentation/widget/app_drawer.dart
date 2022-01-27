import 'package:audiobook/presentation/favorit/fav_screen.dart';

import '../about/about.dart';
import '../contact/contact_screen.dart';
import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import 'slide_page_transitions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:share/share.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  // final List<Map<String, dynamic>> subCategs;

  // required this.subCategs

  @override
  Widget build(BuildContext context) {
    var _tileStyle = Theme.of(context)
        .textTheme
        .bodyText2!
        .copyWith(fontSize: 19, color: Colors.white);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        // padding: EdgeInsets.,
        decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              image: AssetImage(ImageAssets.splashLogo), fit: BoxFit.cover),
        ),
        child: Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.65,
              child: Container(
                alignment: Alignment.centerLeft,
                //color: Colors.red,
                child: Material(
                  color: Colors.transparent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      // Container(
                      //   // height: 100 + MediaQuery.of(context).padding.top,
                      //   width: double.infinity,
                      //   padding: EdgeInsets.only(
                      //       top: MediaQuery.of(context).padding.top),
                      //   child:
                      //    Image.asset(
                      //     ImageAssets.drawerheader,
                      //     fit: BoxFit.scaleDown,
                      //     scale: 3.5,
                      //   ),
                      // ),
                   const   SizedBox(
                        height: 150,
                      ),
                      Expanded(
                        child: ListView(
                          children: [
                            ListTile(
                              leading: Icon(
                                Icons.home,
                                color: ColorManager.white,
                              ),
                              // Image.asset(
                              //   'assets/img/home.png',
                              // ),
                              title: Text("الرئيسية", style: _tileStyle),
                              onTap: () => ZoomDrawer.of(context)!.toggle(),
                            ),
                            ListTile(
                              leading: Icon(
                                Icons.call,
                                color: ColorManager.white,
                              ),
                              // Image.asset(
                              //   'assets/img/2x/mesbaha.png',
                              //   scale: 2.0,
                              // ),
                              title: Text("اتصل بنا", style: _tileStyle),
                              onTap: () => pushSlide(context,
                                  screen: const ContactScreen()),
                            ),
                            ListTile( 
                               leading: Icon(
                                Icons.favorite,
                                color: ColorManager.white,
                              ),
                            title: Text("المفضلة", style: _tileStyle),
                              onTap: () => pushSlide(context,
                                  screen: FavScreen(
                                    // subCategs: subCategs
                                    )),
                            
                            ),
                           
                            ListTile(
                              leading: Icon(
                                Icons.ac_unit,
                                color: ColorManager.white,
                              ),
                              // Image.asset(
                              //   'assets/img/2x/settings.png',
                              //   scale: 1.5,
                              // ),
                              title: Text("عن التطبيق", style: _tileStyle),
                              onTap: () =>
                                  pushSlide(context, screen:const Aboutscreen()),
                            ),
                            ListTile(
                                leading: Icon(
                                  Icons.share,
                                  color: ColorManager.white,
                                ),
                                // Image.asset(
                                //   'assets/img/2x/settings.png',
                                //   scale: 1.5,
                                // ),
                                title: Text("مشاركه التطبيق ",
                                    style: _tileStyle),
                                onTap: () async {
                                  await Share.share(
                                      'تطبيق انصات للكتب الصوتيه');
                                }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
                child: Container(
              color: Colors.transparent,
            ))
          ],
        ),
      ),
    );
  }
}
