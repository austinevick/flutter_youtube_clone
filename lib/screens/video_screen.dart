import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_youtube_ui/data.dart';
import 'package:flutter_youtube_ui/screens/nav_screen.dart';
import 'package:flutter_youtube_ui/widgets/video_card.dart';
import 'package:flutter_youtube_ui/widgets/video_info.dart';
import 'package:miniplayer/miniplayer.dart';

class VideoScreen extends StatelessWidget {
  const VideoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: CustomScrollView(
        shrinkWrap: true,
        slivers: [
          SliverToBoxAdapter(
            child: Consumer(
              builder: (context, watch, child) {
                final selectedVideo = watch(selectedVideoProvider).state;
                return SafeArea(
                  child: Column(
                    children: [
                      Stack(children: [
                        Image.network(
                          selectedVideo!.thumbnailUrl,
                          height: 220.0,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        IconButton(
                            onPressed: () {
                              context
                                  .read(miniPlayerControllerProvider)
                                  .state
                                  .animateToHeight(state: PanelState.MIN);
                            },
                            icon: Icon(Icons.keyboard_arrow_down, size: 30))
                      ]),
                      const LinearProgressIndicator(
                        value: 0.4,
                        valueColor: AlwaysStoppedAnimation(Colors.red),
                      ),
                      VideoInfo(video: selectedVideo)
                    ],
                  ),
                );
              },
            ),
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
            return VideoCard(video: suggestedVideos[index]);
          }, childCount: suggestedVideos.length))
        ],
      )),
    );
  }
}
