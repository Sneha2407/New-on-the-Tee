import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_audio/just_audio.dart';
import 'package:new_on_the_tee/utils/colors.dart';
import 'package:new_on_the_tee/utils/textstyles.dart';
import 'package:rxdart/rxdart.dart';

class AudioPlayerWidget extends StatefulWidget {
  const AudioPlayerWidget({super.key});

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
    _audioPlayer = AudioPlayer()
      ..setUrl('https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3');
    super.initState();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 70.h,
      width: double.infinity,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: Color(0xff133D20),
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
                    Text("Guy Sebastian", style: mcLaren(Kcolors.white, 14)),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text("kenzi.lawson@example.com",
                        style: mcLaren(Kcolors.grey400, 10)),
                  ],
                ),
                const Spacer(),
                Icon(
                  Icons.favorite_border_rounded,
                  color: Kcolors.white,
                  size: 20.sp,
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

class Controls extends StatelessWidget {
  const Controls({super.key, required this.audioPlayer});
  final AudioPlayer audioPlayer;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PlayerState>(
        stream: audioPlayer.playerStateStream,
        builder: (context, snapshot) {
          final playerState = snapshot.data;
          final processingState = playerState?.processingState;
          final playing = playerState?.playing;
          if (!(playing ?? false)) {
            return IconButton(
              icon: const Icon(Icons.play_arrow_rounded),
              iconSize: 20.sp,
              onPressed: audioPlayer.play,
            );
          } else if (processingState != ProcessingState.completed) {
            return IconButton(
              icon: const Icon(Icons.pause_rounded),
              iconSize: 20.sp,
              onPressed: audioPlayer.pause,
            );
          } else {
            return Icon(
              Icons.replay_rounded,
              size: 20.sp,
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

class CustomProgressBar extends StatelessWidget {
  final Color progressBarColor;
  final Duration progress;
  final Duration buffered;
  final Duration total;

  const CustomProgressBar({
    required this.progressBarColor,
    required this.progress,
    required this.buffered,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double maxWidth = constraints.maxWidth;

        final double progressWidth =
            maxWidth * (progress.inMilliseconds / total.inMilliseconds);
        final double bufferedWidth =
            maxWidth * (buffered.inMilliseconds / total.inMilliseconds);

        return Stack(
          children: [
            Container(
              height: 5.0,
              width: maxWidth,
              color: Colors.grey.withOpacity(0.5),
            ),
            Container(
              height: 5.0,
              width: bufferedWidth,
              color: Colors.grey.withOpacity(0.7),
            ),
            Container(
              height: 5.0,
              width: progressWidth,
              color: progressBarColor,
            ),
          ],
        );
      },
    );
  }
}
