import 'dart:async';
import 'dart:io' as io;

import 'package:audioplayers/audioplayers.dart';
import 'package:file/file.dart';
import 'package:file/local.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sout/Screens/home/audio.dart';

class RecorderExample extends StatefulWidget {
  final LocalFileSystem localFileSystem;
  Function filePath;

  RecorderExample({localFileSystem, this.filePath})
      : this.localFileSystem = localFileSystem ?? LocalFileSystem();

  @override
  State<StatefulWidget> createState() => new RecorderExampleState();
}

class RecorderExampleState extends State<RecorderExample> {
  FlutterAudioRecorder _recorder;
  Recording _current;
  RecordingStatus _currentStatus = RecordingStatus.Unset;
  bool isRecDone = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Padding(
        padding: new EdgeInsets.all(8.0),
        child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new FlatButton(
                      onPressed: () {
                        switch (_currentStatus) {
                          case RecordingStatus.Initialized:
                            {
                              _start();
                              break;
                            }
                          case RecordingStatus.Recording:
                            {
                              _pause();
                              break;
                            }
                          case RecordingStatus.Paused:
                            {
                              _resume();
                              break;
                            }
                          case RecordingStatus.Stopped:
                            {
                              _init();
                              break;
                            }
                          default:
                            break;
                        }
                      },
                      child: _buildText(_currentStatus),
                      color: Colors.redAccent,
                    ),
                  ),
                  new FlatButton(
                    onPressed:
                        _currentStatus != RecordingStatus.Unset ? _stop : null,
                    child:
                        new Text("Stop", style: TextStyle(color: Colors.white)),
                    color: Colors.redAccent,
                  ),
                  // SizedBox(
                  //   width: 8,
                  // ),
                  // new FlatButton(
                  //   onPressed: onPlayAudio,
                  //   child:
                  //       new Text("Play", style: TextStyle(color: Colors.white)),
                  //   color: Colors.redAccent,
                  // ),
                ],
              ),
              _currentStatusBuilder(),
              // new Text('Avg Power: ${_current?.metering?.averagePower}'),
              // new Text('Peak Power: ${_current?.metering?.peakPower}'),
              // new Text("File path of the record: ${_current?.path}"),
              // new Text("Format: ${_current?.audioFormat}"),
              // new Text(
              //     "isMeteringEnabled: ${_current?.metering?.isMeteringEnabled}"),
              // new Text("Extension : ${_current?.extension}"),
              new Text(
                _current?.duration.toString(),
                style: TextStyle(fontSize: 25),
              ),
              isRecDone ? Audio(url: _current.path) : SizedBox()
            ]),
      ),
    );
  }

  _currentStatusBuilder() {
    var text = "";
    switch (_currentStatus) {
      // case RecordingStatus.Initialized:
      //   {
      //     text = 'Initialized';
      //     break;
      //   }
      case RecordingStatus.Recording:
        {
          text = 'Recording';
          break;
        }
      case RecordingStatus.Paused:
        {
          text = 'Paused';
          break;
        }
      case RecordingStatus.Stopped:
        {
          text = 'Stopped';
          break;
        }
      default:
        break;
    }
    return Text(text, style: TextStyle(fontSize: 25));
  }

  _init() async {
    try {
      if (await FlutterAudioRecorder.hasPermissions) {
        String customPath = '/flutter_audio_recorder_';
        io.Directory appDocDirectory;
//        io.Directory appDocDirectory = await getApplicationDocumentsDirectory();
        if (io.Platform.isIOS) {
          appDocDirectory = await getApplicationDocumentsDirectory();
        } else {
          appDocDirectory = await getExternalStorageDirectory();
        }

        // can add extension like ".mp4" ".wav" ".m4a" ".aac"
        customPath = appDocDirectory.path +
            customPath +
            DateTime.now().millisecondsSinceEpoch.toString();

        // .wav <---> AudioFormat.WAV
        // .mp4 .m4a .aac <---> AudioFormat.AAC
        // AudioFormat is optional, if given value, will overwrite path extension when there is conflicts.
        _recorder =
            FlutterAudioRecorder(customPath, audioFormat: AudioFormat.WAV);

        await _recorder.initialized;
        // after initialization
        var current = await _recorder.current(channel: 0);
        print(current);
        // should be "Initialized", if all working fine
        setState(() {
          _current = current;
          _currentStatus = current.status;
          print(_currentStatus);
        });
      } else {
        Scaffold.of(context).showSnackBar(
            new SnackBar(content: new Text("You must accept permissions")));
      }
    } catch (e) {
      print(e);
    }
  }

  _start() async {
    setState(() {
      isRecDone = false;
    });
    try {
      await _recorder.start();
      var recording = await _recorder.current(channel: 0);
      setState(() {
        _current = recording;
      });

      const tick = const Duration(milliseconds: 50);
      new Timer.periodic(tick, (Timer t) async {
        if (_currentStatus == RecordingStatus.Stopped) {
          t.cancel();
        }

        var current = await _recorder.current(channel: 0);
        // print(current.status);
        setState(() {
          _current = current;
          _currentStatus = _current.status;
        });
      });
    } catch (e) {
      print(e);
    }
  }

  _resume() async {
    await _recorder.resume();
    setState(() {});
  }

  _pause() async {
    await _recorder.pause();
    setState(() {});
  }

  _stop() async {
    setState(() {
      isRecDone = true;
    });
    var result = await _recorder.stop();
    widget.filePath(result.path);
    print("Stop recording: ${result.path}");
    print("Stop recording: ${result.duration}");
    File file = widget.localFileSystem.file(result.path);
    print("File length: ${await file.length()}");
    setState(() {
      _current = result;
      _currentStatus = _current.status;
    });
  }

  Widget _buildText(RecordingStatus status) {
    var text = "";
    switch (_currentStatus) {
      case RecordingStatus.Initialized:
        {
          text = 'Start';
          break;
        }
      case RecordingStatus.Recording:
        {
          text = 'Pause';
          break;
        }
      case RecordingStatus.Paused:
        {
          text = 'Resume';
          break;
        }
      case RecordingStatus.Stopped:
        {
          text = 'Init Recorder';
          break;
        }
      default:
        break;
    }
    return Text(text, style: TextStyle(color: Colors.white));
  }

  void onPlayAudio() async {
    AudioPlayer audioPlayer = AudioPlayer();
    await audioPlayer.play(_current.path, isLocal: true);
  }
}
