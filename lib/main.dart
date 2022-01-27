import 'package:audio_service/audio_service.dart';
import 'package:audiobook/presentation/audio_player/screens/commons/player_buttons.dart';

import 'domain/bloc_observer.dart';
import 'domain/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app/app.dart';
// late AudioHandler audioHandler;

void main() async {
    WidgetsFlutterBinding.ensureInitialized();

  // audioHandler = await AudioService.init(
  //   builder: () => AudioPlayerHandler(),
  //   config: const AudioServiceConfig(
  //     androidNotificationChannelId: 'com.ryanheise.myapp.channel.audio',
  //     androidNotificationChannelName: 'Audio playback',
  //     androidNotificationOngoing: true,
  //   ),
  // );
  Bloc.observer = MyBlocObserver();

  DioHelper.init();

  runApp(MyApp());
}

