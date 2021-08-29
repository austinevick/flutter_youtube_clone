import 'package:flutter/material.dart';
import 'package:flutter_youtube_ui/data.dart';
import 'package:timeago/timeago.dart';

class VideoInfo extends StatelessWidget {
  final Video? video;
  const VideoInfo({Key? key, this.video}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            video!.title,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          SizedBox(height: 8),
          Text(
            '${video!.author.username} . ${video!.viewCount} views . ${format(video!.timestamp)}',
            style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 15),
          ),
          _ActionsRow(video: video),
          Divider(),
          _AuthorInfo(user: video!.author),
          Divider()
        ],
      ),
    );
  }
}

class _AuthorInfo extends StatelessWidget {
  final User? user;
  const _AuthorInfo({Key? key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: CircleAvatar(),
        ),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(user!.username),
          Text(
            user!.subscribers,
            style: Theme.of(context).textTheme.caption,
          )
        ]),
        Spacer(),
        TextButton(
            onPressed: () {},
            child: Text(
              'SUBSCRIBE',
              style: TextStyle(color: Colors.red, fontSize: 18),
            ))
      ],
    );
  }
}

class _ActionsRow extends StatelessWidget {
  final Video? video;
  const _ActionsRow({Key? key, this.video}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            IconButton(onPressed: () {}, icon: Icon(Icons.thumb_up_outlined)),
            Text(video!.likes)
          ],
        ),
        Column(
          children: [
            IconButton(onPressed: () {}, icon: Icon(Icons.thumb_down_outlined)),
            Text(video!.dislikes)
          ],
        ),
        Column(
          children: [
            IconButton(onPressed: () {}, icon: Icon(Icons.reply_outlined)),
            Text('Share')
          ],
        ),
        Column(
          children: [
            IconButton(onPressed: () {}, icon: Icon(Icons.download_outlined)),
            Text('Download')
          ],
        ),
        Column(
          children: [
            IconButton(
                onPressed: () {}, icon: Icon(Icons.library_add_outlined)),
            Text('Save')
          ],
        ),
      ],
    );
  }
}
