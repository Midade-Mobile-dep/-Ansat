/*
 * File: player_buttons.dart
 * Project: Flutter music player
 * Created Date: Thursday February 18th 2021
 * Author: Michele Volpato
 * -----
 * Copyright (c) 2021 Michele Volpato
 */

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:audiobook/presentation/resources/assets_manager.dart';
import 'package:audiobook/presentation/resources/color_manager.dart';
import 'package:audiobook/presentation/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:just_audio/just_audio.dart';

class PlayerButtons extends StatelessWidget {
  const PlayerButtons(
      {Key? key, required this.durationState, required this.audioPlayer})
      : super(key: key);

  final AudioPlayer audioPlayer;

  final Stream<DurationState> durationState;

  @override
  Widget build(BuildContext context) {
    var _labelLocation = TimeLabelLocation.sides;
    var _labelType = TimeLabelType.remainingTime;
    TextStyle? _labelStyle = getLightStyle(color: Colors.white);
    var _thumbRadius = 10.0;
    var _labelPadding = 5.0;
    var _barHeight = 5.0;
    var _barCapShape = BarCapShape.square;
    Color? _baseBarColor = Colors.white24;
    Color? _progressBarColor = Colors.white70;
    Color? _bufferedBarColor = Colors.white30;
    Color? _thumbColor = Colors.white;
    Color? _thumbGlowColor = Colors.white;
    var _thumbCanPaintOutsideBar = false;

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        StreamBuilder<DurationState>(
          stream: durationState,
          builder: (context, snapshot) {
            final durationState = snapshot.data;
            final progress = durationState?.progress ?? Duration.zero;
            final buffered = durationState?.buffered ?? Duration.zero;
            final total = durationState?.total ?? Duration.zero;
            return Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: ProgressBar(
                progress: progress,
                buffered: buffered,
                total: total,
                onSeek: (duration) {
                  audioPlayer.seek(duration);
                },
                onDragUpdate: (details) {
                  debugPrint('${details.timeStamp}, ${details.localPosition}');
                },
                barHeight: _barHeight,
                baseBarColor: _baseBarColor,
                progressBarColor: _progressBarColor,
                bufferedBarColor: _bufferedBarColor,
                thumbColor: _thumbColor,
                thumbGlowColor: _thumbGlowColor,
                barCapShape: _barCapShape,
                thumbRadius: _thumbRadius,
                thumbCanPaintOutsideBar: _thumbCanPaintOutsideBar,
                timeLabelLocation: _labelLocation,
                timeLabelType: _labelType,
                timeLabelTextStyle: _labelStyle,
                timeLabelPadding: _labelPadding,
              ),
            );
          },
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // StreamBuilder<bool>(
            //   stream: audioPlayer.shuffleModeEnabledStream,
            //   builder: (context, snapshot) {
            //     return _shuffleButton(context, snapshot.data ?? false);
            //   },
            // ),
            StreamBuilder<SequenceState?>(
              stream: audioPlayer.sequenceStateStream,
              builder: (_, __) {
                return _previousButton();
              },
            ),
            StreamBuilder<PlayerState>(
              stream: audioPlayer.playerStateStream,
              builder: (_, snapshot) {
                final playerState = snapshot.data;
                return _playPauseButton(playerState!);
              },
            ),
            StreamBuilder<SequenceState?>(
              stream: audioPlayer.sequenceStateStream,
              builder: (_, __) {
                return _nextButton();
              },
            ),
            // StreamBuilder<LoopMode>(
            //   stream: audioPlayer.loopModeStream,
            //   builder: (context, snapshot) {
            //     return _repeatButton(context, snapshot.data ?? LoopMode.off);
            //   },
            // ),
          ],
        ),
      ],
    );
  }

  Widget _playPauseButton(PlayerState playerState) {
    final processingState = playerState.processingState;
    if (processingState == ProcessingState.loading ||
        processingState == ProcessingState.buffering) {
      return Container(
        margin: EdgeInsets.all(8.0),
        width: 64.0,
        height: 64.0,
        child: CircularProgressIndicator(),
      );
    } else if (audioPlayer.playing != true) {
      return IconButton(
        icon: SvgPicture.asset(ImageAssets.play),
        iconSize: 64.0,
        onPressed: audioPlayer.play,
      );
    } else if (processingState != ProcessingState.completed) {
      return IconButton(
        icon: SvgPicture.asset(ImageAssets.pause),
        iconSize: 64.0,
        onPressed: audioPlayer.pause,
      );
    } else {
      return IconButton(
        icon: Icon(Icons.replay),
        iconSize: 64.0,
        onPressed: () => audioPlayer.seek(Duration.zero,
            index: audioPlayer.effectiveIndices!.first),
      );
    }
  }

  Widget _shuffleButton(BuildContext context, bool isEnabled) {
    return IconButton(
      icon: isEnabled
          ? Icon(Icons.shuffle, color: ColorManager.white)
          : Icon(Icons.shuffle),
      onPressed: () async {
        final enable = !isEnabled;
        if (enable) {
          await audioPlayer.shuffle();
        }
        await audioPlayer.setShuffleModeEnabled(enable);
      },
    );
  }

  Widget _previousButton() {
    return IconButton(
      icon: SvgPicture.asset(ImageAssets.forward),
      onPressed: () async {
         Duration newPosition =
            Duration(seconds: audioPlayer.position.inSeconds + 5);
         if (newPosition >audioPlayer.bufferedPosition) newPosition = audioPlayer.bufferedPosition;
        await audioPlayer
            .seek(newPosition);
      },
    );
  }

  Widget _nextButton() {
    return IconButton(
      icon: SvgPicture.asset(ImageAssets.backward),
      onPressed: () async {
        Duration newPosition =
            Duration(seconds: audioPlayer.position.inSeconds - 5);
         if (newPosition < Duration.zero) newPosition = Duration.zero;
        await audioPlayer.seek(newPosition);
      },
    );
  }

 
}

class DurationState {
  const DurationState(
      {required this.progress, required this.buffered, required this.total});
  final Duration progress;
  final Duration buffered;
  final Duration total;
}

// /*
//  * File: player_buttons.dart
//  * Project: Flutter music player
//  * Created Date: Thursday February 18th 2021
//  * Author: Michele Volpato
//  * -----
//  * Copyright (c) 2021 Michele Volpato
//  */

// import 'package:audio_service/audio_service.dart';
// import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
// import 'package:audiobook/presentation/resources/assets_manager.dart';
// import 'package:audiobook/presentation/resources/color_manager.dart';
// import 'package:audiobook/presentation/resources/styles_manager.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:just_audio/just_audio.dart';

// import '../../../../main.dart';
// import 'package:rxdart/rxdart.dart';

// class PlayerButtons extends StatelessWidget {
//   const PlayerButtons({Key? key, required}) : super(key: key);

//   // final AudioPlayer audioPlayer;

//   // final Stream<DurationState> durationState;

//   @override
//   Widget build(BuildContext context) {
//     var _labelLocation = TimeLabelLocation.sides;
//     var _labelType = TimeLabelType.remainingTime;
//     TextStyle? _labelStyle = getLightStyle(color: Colors.white);
//     var _thumbRadius = 10.0;
//     var _labelPadding = 5.0;
//     var _barHeight = 5.0;
//     var _barCapShape = BarCapShape.square;
//     Color? _baseBarColor = Colors.white24;
//     Color? _progressBarColor = Colors.white70;
//     Color? _bufferedBarColor = Colors.white30;
//     Color? _thumbColor = Colors.white;
//     Color? _thumbGlowColor = Colors.white;
//     var _thumbCanPaintOutsideBar = false;

//     return Column(mainAxisAlignment: MainAxisAlignment.end, children: [
//       StreamBuilder<MediaState>(
//         stream: _mediaStateStream,
//         builder: (context, snapshot) {
//           final mediaState = snapshot.data;
//           return ProgressBar(
//             total: mediaState?.mediaItem.duration ?? Duration.zero,
//             progress: mediaState?.position ?? Duration.zero,
//             buffered:
//                 mediaState?.playbackState.bufferedPosition ?? Duration.zero,
//             onSeek: (newPosition) {
//               audioHandler.seek(newPosition);
//             },
//             barHeight: _barHeight,
//             baseBarColor: _baseBarColor,
//             progressBarColor: _progressBarColor,
//             bufferedBarColor: _bufferedBarColor,
//             thumbColor: _thumbColor,
//             thumbGlowColor: _thumbGlowColor,
//             barCapShape: _barCapShape,
//             thumbRadius: _thumbRadius,
//             thumbCanPaintOutsideBar: _thumbCanPaintOutsideBar,
//             timeLabelLocation: _labelLocation,
//             timeLabelType: _labelType,
//             timeLabelTextStyle: _labelStyle,
//             timeLabelPadding: _labelPadding,
//           );
//         },
//       ),
//       StreamBuilder<bool>(
//           stream: audioHandler.playbackState
//               .map((state) => state.playing)
//               .distinct(),
//           builder: (context, snapshot) {
//             final playing = snapshot.data ?? false;
//             return Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 _button(
//                     SvgPicture.asset(ImageAssets.forward), audioHandler.rewind),

//                 if (playing)
//                   _button(
//                       SvgPicture.asset(ImageAssets.pause), audioHandler.pause)
//                 else
//                   _button(
//                       SvgPicture.asset(ImageAssets.play), audioHandler.play),
//                 // _button(SvgPicture.asset(ImageAssets.pause), audioHandler.stop),
//                 _button(SvgPicture.asset(ImageAssets.backward),
//                     audioHandler.fastForward),
//               ],
//             );
//           })
//     ]);
//   }

//   Stream<MediaState> get _mediaStateStream =>
//       Rx.combineLatest3<MediaItem?, Duration, PlaybackState, MediaState>(
//           audioHandler.mediaItem,
//           AudioService.position,
//           audioHandler.playbackState,
//           (mediaItem, position, playbackState) =>
//               MediaState(mediaItem!, position, playbackState));

//   // Widget _playPauseButton(PlayerState playerState) {
//   //   final processingState = playerState.processingState;
//   //   if (processingState == ProcessingState.loading ||
//   //       processingState == ProcessingState.buffering) {
//   //     return Container(
//   //       margin: EdgeInsets.all(8.0),
//   //       width: 64.0,
//   //       height: 64.0,
//   //       child: CircularProgressIndicator(),
//   //     );
//   //   } else if (audioPlayer.playing != true) {
//   //     return IconButton(
//   //       icon: SvgPicture.asset(ImageAssets.play),
//   //       iconSize: 64.0,
//   //       onPressed: audioPlayer.play,
//   //     );
//   //   } else if (processingState != ProcessingState.completed) {
//   //     return IconButton(
//   //       icon: SvgPicture.asset(ImageAssets.pause),
//   //       iconSize: 64.0,
//   //       onPressed: audioPlayer.pause,
//   //     );
//   //   } else {
//   //     return IconButton(
//   //       icon: Icon(Icons.replay),
//   //       iconSize: 64.0,
//   //       onPressed: () => audioPlayer.seek(Duration.zero,
//   //           index: audioPlayer.effectiveIndices!.first),
//   //     );
//   //   }
//   // }

//   IconButton _button(Widget iconData, VoidCallback onPressed) => IconButton(
//         icon: iconData,
//         iconSize: 64.0,
//         onPressed: onPressed,
//       );

  
// }



// /// An [AudioHandler] for playing a single item.
// class AudioPlayerHandler extends BaseAudioHandler with SeekHandler {
//   static final _item = MediaItem(
//     id: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3',
//     album: "Science Friday",
//     title: "A Salute To Head-Scratching Science",
//     artist: "Science Friday and WNYC Studios",
//     duration:const Duration(milliseconds: 103456) ,
//     artUri: Uri.parse(
//         'https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg'),
//   );
// // AudioPlayerHandler._item.Duration
//   final AudioPlayer _player = AudioPlayer();

//   /// Initialise our audio handler.
//   AudioPlayerHandler() {

//     _player.playbackEventStream.map(_transformEvent).pipe(playbackState);
//     mediaItem.add(_item);

//     _player.setAudioSource(AudioSource.uri(Uri.parse(_item.id)));
//   }

 

//   @override
//   Future<void> play() => _player.play();

//   @override
//   Future<void> pause() => _player.pause();

//   @override
//   Future<void> seek(Duration position) => _player.seek(position);

//   @override
//   Future<void> stop() => _player.stop();

//   PlaybackState _transformEvent(PlaybackEvent event) {
//     return PlaybackState(
//       controls: [
//         MediaControl.rewind,
//         if (_player.playing) MediaControl.pause else MediaControl.play,
//         MediaControl.stop,
//         MediaControl.fastForward,
//       ],
//       systemActions: const {
//         MediaAction.seek,
//         MediaAction.seekForward,
//         MediaAction.seekBackward,
//       },
//       androidCompactActionIndices: const [0, 1, 3],
//       processingState: const {
//         ProcessingState.idle: AudioProcessingState.idle,
//         ProcessingState.loading: AudioProcessingState.loading,
//         ProcessingState.buffering: AudioProcessingState.buffering,
//         ProcessingState.ready: AudioProcessingState.ready,
//         ProcessingState.completed: AudioProcessingState.completed,
//       }[_player.processingState]!,
//       playing: _player.playing,
//       updatePosition: _player.position,
//       bufferedPosition: _player.bufferedPosition,
//       speed: _player.speed,
//       queueIndex: event.currentIndex,
//     );
//   }
// }

// class MediaState {
//   final MediaItem mediaItem;
//   final Duration position;
//   final PlaybackState playbackState;

//   MediaState(this.mediaItem, this.position, this.playbackState);
// }
