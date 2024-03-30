import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:nthiendev_flutter_tiktok/models/video_model.dart';
import 'package:nthiendev_flutter_tiktok/view-models/feed_viewmodel.dart';
import 'package:nthiendev_flutter_tiktok/views/messages_screen.dart';
import 'package:nthiendev_flutter_tiktok/views/profile_screen.dart';
import 'package:nthiendev_flutter_tiktok/views/search_screen.dart';
import 'package:nthiendev_flutter_tiktok/widgets/actions_toolbar.dart';
import 'package:nthiendev_flutter_tiktok/widgets/bottom_bar.dart';
import 'package:nthiendev_flutter_tiktok/widgets/video_description.dart';
import 'package:stacked/stacked.dart';
import 'package:video_player/video_player.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final locator = GetIt.instance;
  final feedViewModel = GetIt.instance<FeedViewModel>();

  @override
  void initState() {
    super.initState();
    feedViewModel.loadVideo(0);
    feedViewModel.loadVideo(1);
    feedViewModel.loadVideo(2);
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        disposeViewModel: false,
        viewModelBuilder: () => feedViewModel,
        builder: ((context, viewModel, child) => videoScreen()));
  }

  Widget videoScreen() {
    return Scaffold(
      backgroundColor: GetIt.instance<FeedViewModel>().actualScreen == 0
          ? Colors.black
          : Colors.white,
      body: Stack(
        children: [scrollFeed()],
      ),
    );
  }

  Widget scrollFeed() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(child: currentScreen()),
        BottomBar(),
      ],
    );
  }

  Widget currentScreen() {
    switch (feedViewModel.actualScreen) {
      case 0:
        return feedVideos();
      case 1:
        return SearchScreen();
      case 2:
        return MessagesScreen();
      case 3:
        return ProfileScreen();
      default:
        return feedVideos();
    }
  }

  Widget feedVideos() {
    return Stack(
      children: [
        PageView.builder(
          controller: PageController(
            initialPage: 0,
            viewportFraction: 1,
          ),
          itemCount: feedViewModel.videoSource?.listVideos.length,
          onPageChanged: (index) {
            index = index % (feedViewModel.videoSource!.listVideos.length);
            feedViewModel.changeVideo(index);
          },
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            index = index % (feedViewModel.videoSource!.listVideos.length);
            return videoCard(feedViewModel.videoSource!.listVideos[index]);
          },
        )
      ],
    );
  }

  Widget videoCard(Video video) {
    return Stack(
      children: [
        video.controller != null
            ? GestureDetector(
                child: SizedBox.expand(
                    child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: video.controller?.value.size.width ?? 0,
                    height: video.controller?.value.size.height ?? 0,
                    child: VideoPlayer(video.controller!),
                  ),
                )),
              )
            : Container(
                color: Colors.black,
                child: const Center(
                  child: Text("Loading"),
                ),
              ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                VideoDescription(video.user, video.videoTitle, video.songName),
                ActionsToolbar(video.likes, video.comments,
                    "https://scontent.fsgn8-2.fna.fbcdn.net/v/t39.30808-6/434356614_3322802478012413_8040528507933242027_n.jpg?stp=cp6_dst-jpg&_nc_cat=110&ccb=1-7&_nc_sid=5f2048&_nc_eui2=AeFgJ06AazulSA6eKA-V0hJMq8Y-LHi7N-Orxj4seLs340QDyY2P8V0rmZhExZsb07BQjZiu9PDufIix9xtsoBvZ&_nc_ohc=yIXJVYbVMCAAX8U0HSg&_nc_zt=23&_nc_ht=scontent.fsgn8-2.fna&oh=00_AfAu7iba3WqE5wGCL-2CNlYHIZtxfDSCFZjOOOd9HhnMwg&oe=660E07BA"),
              ],
            ),
            SizedBox(height: 20)
          ],
        )
      ],
    );
  }

  @override
  void dispose() {
    feedViewModel.controller?.dispose();
    print("=============: ${feedViewModel.controller}");
    super.dispose();
  }
}
