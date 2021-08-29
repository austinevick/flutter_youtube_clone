import 'package:flutter/material.dart';
import 'package:flutter_youtube_ui/screens/nav_screen.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:timeago/timeago.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data.dart';

class VideoCard extends StatelessWidget {
  final Video? video;
  const VideoCard({Key? key, this.video}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read(selectedVideoProvider).state = video;
        context
            .read(miniPlayerControllerProvider)
            .state
            .animateToHeight(state: PanelState.MAX);
      },
      child: Column(
        children: [
          Stack(
            children: [
              Image.network(
                video!.thumbnailUrl,
                height: 220,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Positioned(
                  bottom: 8.0,
                  right: 8.0,
                  child: Container(
                    margin: EdgeInsets.all(4.0),
                    color: Colors.black,
                    child: Text(
                      video!.duration,
                      style: Theme.of(context)
                          .textTheme
                          .caption!
                          .copyWith(color: Colors.white),
                    ),
                  ))
            ],
          ),
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            GestureDetector(
              child: CircleAvatar(
                foregroundImage: NetworkImage(video!.author.profileImageUrl),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(video!.title),
                  Text(
                      '${video!.author.username} . ${video!.viewCount} views . ${format(video!.timestamp)}')
                ],
              ),
            ),
            IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))
          ])
        ],
      ),
    );
  }
}
