import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_audio/just_audio.dart';
import 'package:new_on_the_tee/screens/providers/auth_provider.dart';
import 'package:new_on_the_tee/utils/colors.dart';
import 'package:new_on_the_tee/utils/textstyles.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

import '../screens/providers/dashboard_provider.dart';

class AudioPlayerWidget extends StatefulWidget {
  final String url;
  final int index;
  const AudioPlayerWidget({super.key, required this.url, required this.index});

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  late AudioPlayer _audioPlayer;

  Stream<PositionData> get positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
        _audioPlayer.positionStream,
        _audioPlayer.bufferedPositionStream,
        _audioPlayer.durationStream,
        (position, bufferedPosition, duration) =>
            PositionData(position, bufferedPosition, duration ?? Duration.zero),
      );

  @override
  void initState() {
    _audioPlayer = AudioPlayer()..setUrl(widget.url);
    _audioPlayer.play(); // Start playing the audio on initialization
    super.initState();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dashProvider = Provider.of<DashboardProvider>(context);
    final authProvider = Provider.of<RegisterProvider>(context);
    return Container(
      // height: 70.h,
      width: double.infinity,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: const Color(0xff133D20),
      ),
      // padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 15.h),
      child: Padding(
        padding: EdgeInsets.symmetric(
          // vertical: 10.h,
          horizontal: 12.w,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              height: 10.h,
            ),
            Row(
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10.r),
                    image: const DecorationImage(
                      image: NetworkImage(
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRsynwv-5qtogtOwJbIjaPFJUmHpzhxgqIAug&usqp=CAU"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(dashProvider.dashboard!.data[widget.index].name ?? "",
                        style: mcLaren(Kcolors.white, 14)),
                    SizedBox(
                      height: 2.h,
                    ),
                    Text(dashProvider.dashboard!.data[widget.index].email ?? "",
                        style: mcLaren(Kcolors.grey400, 10)),
                  ],
                ),
                const Spacer(),
                IconButton(
                  icon:
                      dashProvider.dashboard!.data[widget.index].favourite == 0
                          ? Icon(
                              Icons.favorite_border_rounded,
                              color: Kcolors.white,
                              size: 20.sp,
                            )
                          : Icon(
                              Icons.favorite_rounded,
                              color: Kcolors.white,
                              size: 20.sp,
                            ),
                  onPressed: () {
                    dashProvider
                        .updateFavourite(authProvider.accessToken!,
                            dashProvider.dashboard!.data[widget.index].id)
                        .then((value) {
                      setState(() {
                        dashProvider.dashboard!.data[widget.index].favourite ==
                                0
                            ? dashProvider
                                .dashboard!.data[widget.index].favourite = 1
                            : dashProvider
                                .dashboard!.data[widget.index].favourite = 0;
                      });
                    }).onError((error, stackTrace) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red.withOpacity(0.5),
                          content: Text(
                            'Error! Failed to update Favourite',
                            style: mcLaren(Kcolors.white, 15),
                          ),
                        ),
                      );
                    });
                  },
                ),
                SizedBox(
                  width: 10.w,
                ),
                Controls(
                  audioPlayer: _audioPlayer,
                )
              ],
            ),
            SizedBox(
              height: 5.h,
            ),
            StreamBuilder<PositionData>(
              stream: positionDataStream,
              builder: (context, snapshot) {
                final positionData = snapshot.data;
                return
                    // Text(
                    //   positionData != null
                    //       ? '${positionData.position.inMinutes}:${(positionData.position.inSeconds % 60).toString().padLeft(2, '0')}'
                    //       : '',
                    //   style: mcLaren(Kcolors.white, 12),
                    // );
                    ProgressBar(
                  thumbRadius: 0.r,
                  timeLabelLocation: TimeLabelLocation.none,
                  progressBarColor: Kcolors.lightGreen,
                  progress: positionData?.position ?? Duration.zero,
                  buffered: positionData?.bufferedPosition ?? Duration.zero,
                  total: positionData?.duration ?? Duration.zero,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Controls extends StatefulWidget {
  const Controls({super.key, required this.audioPlayer});
  final AudioPlayer audioPlayer;

  @override
  State<Controls> createState() => _ControlsState();
}

class _ControlsState extends State<Controls> {
  @override
  Widget build(BuildContext context) {
    final dashProvider = Provider.of<DashboardProvider>(context);
    return StreamBuilder<PlayerState>(
        stream: widget.audioPlayer.playerStateStream,
        builder: (context, snapshot) {
          final playerState = snapshot.data;
          final processingState = playerState?.processingState;
          final playing = playerState?.playing;
          if (!(playing ?? false)) {
            return IconButton(
              icon: const Icon(Icons.play_arrow_rounded),
              iconSize: 20.sp,
              color: Colors.white,
              onPressed: widget.audioPlayer.play,
            );
          } else if (processingState != ProcessingState.completed) {
            return IconButton(
              icon: const Icon(Icons.pause_rounded),
              iconSize: 20.sp,
              color: Colors.white,
              onPressed: widget.audioPlayer.pause,
            );
          } else {
            return IconButton(
              icon: Icon(
                Icons.close_rounded,
                size: 20.sp,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  // stop the audio
                  dashProvider.setPlay(false);
                });
              },
            );
          }
        });
  }
}

class PositionData {
  PositionData(this.position, this.bufferedPosition, this.duration);
  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;
}
