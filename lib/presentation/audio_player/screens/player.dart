/*
 * File: player.dart
 * Project: Flutter music player
 * Created Date: Wednesday February 17th 2021
 * Author: Michele Volpato
 * -----
 * Copyright (c) 2021 Michele Volpato
 */

import 'dart:ui';

import 'package:audiobook/domain/cubit/ansat_cubit.dart';
import 'package:audiobook/domain/models/Get_category_items.dart';
import 'package:audiobook/presentation/audio_player/screens/commons/player_buttons.dart';
import 'package:audiobook/presentation/resources/color_manager.dart';
import 'package:audiobook/presentation/resources/styles_manager.dart';
import 'package:audiobook/presentation/widget/back_arrow.dart';
import 'package:audiobook/presentation/widget/shareButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rxdart/rxdart.dart';

class Player extends StatefulWidget {
  const Player({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.audioImage,
    required this.file,
    required this.items,
  }) : super(key: key);

  @override
  _audioPlayerState createState() => _audioPlayerState();
  final String? imageUrl;
  final String? title;
  final String? audioImage;
  final String? file;
  final GetCategoryItems items;
}

class _audioPlayerState extends State<Player> {
  bool _isFav = false;
  List<String>? _favs;
  List<int>? reserveRepeats = [];
  late Stream<DurationState> _durationState;
  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _durationState = Rx.combineLatest2<Duration, PlaybackEvent, DurationState>(
        _audioPlayer.positionStream,
        _audioPlayer.playbackEventStream,
        (position, playbackEvent) => DurationState(
              progress: position,
              buffered: playbackEvent.bufferedPosition,
              total: playbackEvent.duration!,
            ));
    for (int c = 0; c < widget.items.data!.length; c++) {
      reserveRepeats!.add(0);
      SharedPreferences.getInstance().then((prefs) {
        if (prefs.getStringList("favs") != null) {
          setState(() {
            _isFav = prefs.getStringList("favs")!.contains(widget.title);
          });
        }
      });
    }
    _init();
  }

  Future<void> _init() async {
    try {
      await _audioPlayer.setUrl(widget.file!);
    } catch (e) {
      debugPrint('An error occured $e');
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AnsatCubit, AnsatState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
                appBar: AppBar(
                  toolbarHeight: 60,
                  // backgroundColor: Colors.white,
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Image.network(
                        widget.imageUrl!,
                        // scale: 2,
                        // fit: BoxFit.scaleDown,
                      ),
                    ),
                  ],

                  automaticallyImplyLeading: false,
                  title: Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Text(
                      widget.title!,
                      style: getBoldStyle(color: ColorManager.white),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  leading: const BackArrow(),
                  centerTitle: true,
                ),
                body: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            widget.audioImage!,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                        child: Container(
                            padding: EdgeInsets.only(bottom: 80),
                            alignment: Alignment.bottomCenter,
                            color: Colors.black.withOpacity(0.2),
                            child: PlayerButtons(
                              audioPlayer: _audioPlayer,
                              durationState: _durationState,
                            )),
                      ),
                    ),
                    Positioned(
                        bottom: 380,
                        right: 110,
                        left: 110,
                        top: 250,
                        child: Container(
                          // alignment: Alignment.center,
                          // height: 50,
                          // width: 50,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset.fromDirection(10),
                                  color: Colors.black.withOpacity(0.9),
                                  blurRadius: 20,
                                  spreadRadius: 30)
                            ],
                            borderRadius: BorderRadius.circular(10.0),
                            image: DecorationImage(
                              image: NetworkImage(
                                widget.audioImage!,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        )),
                    // Positioned(
                    //   bottom: 95,
                    //   // right: 200,
                    //   right: 10,
                    // child: IconButton(
                    //     onPressed: () {
                    //       AnsatCubit.get(context).changeFavorit(widget.index!);
                    //     },
                    //     icon: Icon(
                    //       AnsatCubit.get(context).favoritColor[widget.index!]
                    //           ? Icons.favorite_border
                    //           : Icons.favorite,
                    //       color: Colors.white,
                    //       size: 35,
                    //     )),
                    // ),
                  ],

                  // Container(

                  //   child: PlayerButtons(_audioPlayer)),
                ),
                floatingActionButton: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 30.0),
                        child: FloatingActionButton(
                          onPressed: () async {
                            SharedPreferences.getInstance().then((prefs) {
                              if (prefs.getStringList("favs") == null) {
                                prefs.setStringList("favs",
                                    ["${widget.title}"]);
                              } else {
                                _favs = prefs.getStringList("favs");

                                if (_favs!.contains(widget.title)) {
                                  _favs!.remove(widget.items);
                                  prefs.setStringList("favs", _favs!);
                                  setState(() {
                                    _isFav = false;
                                  });
                                } else {
                                  _favs!.add(widget.title!);
                                  prefs.setStringList("favs", _favs!);
                                  setState(() {
                                    _isFav = true;
                                  });
                                }
                              }
                            });
                          },
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                          child: Icon(
                            _isFav ? Icons.favorite : Icons.favorite_border,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      FloatingActionButton(
                        onPressed: () async {
                          await Share.share(" ${widget.title},/n ${widget.file}");
                        },
                        child: Icon(
                          Icons.share,
                          size: 30,
                        ),
                        heroTag: "share",
                      ),
                    ])),
          );
        });
  }
}
