import 'package:audiobook/presentation/audio_player/audio_player.dart';
import 'package:audiobook/presentation/resources/assets_manager.dart';
import 'package:audiobook/presentation/resources/color_manager.dart';
import 'package:audiobook/presentation/widget/back_arrow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import '../azkar_data/all_azkar_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'zekr_screen.dart';

class FavScreen extends StatefulWidget {
  // final List<Map<String, dynamic>> subCategs;
// {required this.subCategs}
  const FavScreen();
  @override
  State<FavScreen> createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  List<String> _favsList = [];
  List<String> _linkList = [];

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      if (prefs.getStringList("favs") != null) {
        setState(() {
          _favsList = prefs.getStringList("favs")!;
          print('You have ' + _favsList.length.toString() + ' favs!');
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('المفضلة'),
          leading: BackArrow(),
        ),
        body: AnimationLimiter(
          child: ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 5),
              itemCount: _favsList.length,
              itemBuilder: (context, index) {
                // int subIndex = widget.subCategs.indexWhere(
                //     (element) => element["title"] == _favsList[index]);
                // Map<String, dynamic> subCategFav = widget.subCategs[subIndex];
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: Duration(milliseconds: 375),
                  delay: Duration(milliseconds: 200),
                  key: Key('$index'),
                  child: SlideAnimation(
                    horizontalOffset: 50,
                    child: FadeInAnimation(
                      child: Card(
                        margin: const EdgeInsets.all(5),
                        elevation: 5,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => SoundCloudTab(
                                          imageUrl:
                                              'http://islamicaudio.net/assets/media/podcast-1672_smallThumb.png',
                                          link:
                                              "https://soundcloud.com/user-66672465/n9aydhqpu3xp?in=user-66672465/sets/ufm2niw1aggf",
                                          title: _favsList[index],
                                        )));
                              },
                              title: Text("${_favsList[index]}"),
                              leading: SvgPicture.asset(
                                ImageAssets.iconListen,
                                fit: BoxFit.fitHeight,
                              ),
                              trailing: IconButton(
                                onPressed: () async {
                                  SharedPreferences.getInstance().then((prefs) {
                                    List<String>? _updatedFavs =
                                        prefs.getStringList("favs");
                                    _updatedFavs!.remove(_favsList[index]);
                                    prefs.setStringList("favs", _updatedFavs);
                                    setState(() {
                                      _favsList = _updatedFavs;
                                    });
                                  });
                                },
                                icon: Icon(
                                  Icons.favorite,
                                  color: Colors.pink[300],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
        ),
      ),
    );
    
  }

  /// The function of this method is to obtain the [id] of the [subCateg] for scheduling the notification of this [subCateg]
  // getAllSubCategs() {
  //   List<Map<String, dynamic>> _tempItems = [];
  //   List<Map<String, dynamic>> __tempSubCategories = [];
  //   List<String> _tempMainCategs = [];

  //   for (Map<String, dynamic> categZero in allAzkarData["data"]) {
  //     if (categZero['childrenCount'] != 0) {
  //       for (Map<String, dynamic> subCategory in categZero["children"]
  //           ["data"]) {
  //         __tempSubCategories.add(subCategory);
  //       }
  //     }
  //   }
  //   setState(() {
  //     _subCategsToShow = __tempSubCategories;
  //   });
  // }
}
