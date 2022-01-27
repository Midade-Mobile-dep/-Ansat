import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../search/serach_Screen.dart';
import '../widget/app_drawer.dart';
import '../widget/categoryGridView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final ZoomDrawerController zoomDrawerController = ZoomDrawerController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ZoomDrawer(
        controller: zoomDrawerController,
        isRtl: true,
        showShadow: true,
        angle: -10.0,
        borderRadius: 24.0,
        slideWidth: MediaQuery.of(context).size.width * 0.45,
        openCurve: Curves.fastOutSlowIn,
        closeCurve: Curves.easeOut,
        menuScreen:const AppDrawer(),
        mainScreen: Scaffold(
          body: Stack(
            children: [
              Column(
                children: [
                  ///Header
                  Stack(
                    children: [
                      Container(
                        height: 200,
                        child: Align(
                            // alignment: Alignment(0, -0.3),
                            child: Image.asset(
                          ImageAssets.logo,
                          fit: BoxFit.scaleDown,
                          scale: 8.2,
                        )),
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            image: DecorationImage(
                                image: AssetImage(ImageAssets.drawerheader),
                                fit: BoxFit.cover)),
                      ),
                      Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                              onPressed: () {
                                zoomDrawerController.toggle!();
                              },
                              icon: SvgPicture.asset(ImageAssets.menu))),
                      Align(
                          alignment: Alignment.topLeft,
                          child: IconButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => SearchScreen()));
                              },
                              icon: Icon(
                                Icons.search,
                                color: ColorManager.white,
                              ))),
                    ],
                  ),
                  Expanded(child: Container(color: ColorManager.darkGrey)),
                ],
              ),

              ///The content List
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: MediaQuery.of(context).size.height - 220,
                  padding: const EdgeInsets.only(top: 10, bottom: 20),
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                        image: AssetImage(
                          ImageAssets.splashLogo,
                        ),
                        fit: BoxFit.cover),
                    color: ColorManager.primary,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                  ),
                  child: const ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    child: CategoryGridView(
                        // height: MediaQuery.of(context).size.height -100,
                        ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}