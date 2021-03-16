import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class Audio extends StatefulWidget {
  String url;
  Audio({this.url});
  @override
  _AudioState createState() => _AudioState();
}

class _AudioState extends State<Audio> {
  AudioPlayer audioPlayer = new AudioPlayer();
  Duration duration = new Duration();
  Duration position = new Duration();
  bool playing = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          slider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                _printDuration(position),
                style: TextStyle(color: Colors.redAccent, fontSize: 25),
              ),
              InkWell(
                onTap: () {
                  getAudio();
                },
                child: Icon(
                  playing
                      ? Icons.pause_circle_outline
                      : Icons.play_circle_outline,
                  size: 50,
                  color: Colors.redAccent,
                ),
              ),
              Text(
                _printDuration(duration),
                style: TextStyle(color: Colors.redAccent, fontSize: 25),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget slider() {
    return Slider.adaptive(
        min: 0.0,
        value: position.inSeconds.toDouble(),
        max: duration.inSeconds.toDouble(),
        activeColor: Colors.redAccent,
        onChanged: (double value) {
          setState(() {
            audioPlayer.seek(new Duration(seconds: value.toInt()));
          });
        });
  }

  void getAudio() async {
    var url = widget.url;

    if (playing) {
      var res = await audioPlayer.pause();
      if (res == 1) {
        setState(() {
          playing = false;
        });
      }
    } else {
      var res = await audioPlayer.play(url, isLocal: true);
      if (res == 1) {
        setState(() {
          playing = true;
        });
      }
    }
    audioPlayer.onDurationChanged.listen((Duration dur) {
      setState(() {
        duration = dur;
      });
    });

    audioPlayer.onAudioPositionChanged.listen((Duration pos) {
      setState(() {
        position = pos;
      });
    });
  }

  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
}
