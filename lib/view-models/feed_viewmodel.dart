import 'package:flutter/services.dart';
import 'package:nthiendev_flutter_tiktok/repos/video_repo.dart';
import 'package:stacked/stacked.dart';
import 'package:video_player/video_player.dart';

class FeedViewModel extends BaseViewModel {
  VideoPlayerController? controller;
  VideosAPI? videoSource;

  int prevVideo = 0;
  int actualScreen = 0;

  FeedViewModel() {
    videoSource = VideosAPI();
  }

  changeVideo(index) async {
    print("index====: $index, ${videoSource!.listVideos[index].controller}");
    if (videoSource!.listVideos[index].controller == null) {
      await videoSource!.listVideos[index].loadController();
    }

    videoSource!.listVideos[index].controller!.play();
    videoSource!.listVideos[prevVideo].controller?.removeListener(() {});

    if (videoSource!.listVideos[prevVideo].controller != null) {
      videoSource!.listVideos[prevVideo].controller!.pause();
    }

    prevVideo = index;

    notifyListeners();

    print(index);
  }

  loadVideo(int index) async {
    if (videoSource!.listVideos.length > index) {
      await videoSource!.listVideos[index].loadController();
      videoSource!.listVideos[index].controller?.play();

      notifyListeners();
    }
  }

  setActualScreen(index) {
    actualScreen = index;

    if (index == 0) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    } else {
      videoSource!.listVideos[prevVideo].controller?.pause();
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    }
    notifyListeners();
  }
}
