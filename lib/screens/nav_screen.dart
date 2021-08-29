import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miniplayer/miniplayer.dart';

import '../data.dart';
import 'home_screen.dart';
import 'video_screen.dart';

final selectedVideoProvider = StateProvider<Video?>((ref) => null);
final miniPlayerControllerProvider =
    StateProvider.autoDispose<MiniplayerController>(
        (ref) => MiniplayerController());

class NavScreen extends StatefulWidget {
  const NavScreen({Key? key}) : super(key: key);

  @override
  _NavScreenState createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  static const double playerMinHeight = 60.0;
  int selectedIndex = 0;
  List<Widget> screens = [
    HomeScreen(),
    const Scaffold(
      body: Center(
        child: Text('Explore'),
      ),
    ),
    const Scaffold(
      body: Center(
        child: Text('Add'),
      ),
    ),
    const Scaffold(
      body: Center(
        child: Text('Subscriptions'),
      ),
    ),
    const Scaffold(
      body: Center(
        child: Text('Library'),
      ),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(builder: (context, watch, _) {
        final selectedVideo = watch(selectedVideoProvider).state;
        final miniplayerController = watch(miniPlayerControllerProvider).state;
        print(selectedVideo);
        return Stack(
          children: screens
              .asMap()
              .map((i, screen) => MapEntry(
                  i, Offstage(offstage: selectedIndex != i, child: screen)))
              .values
              .toList()
                ..add(Offstage(
                  offstage: selectedVideo == null,
                  child: Miniplayer(
                      controller: miniplayerController,
                      minHeight: playerMinHeight,
                      maxHeight: MediaQuery.of(context).size.height,
                      builder: (height, percentage) {
                        if (selectedVideo == null)
                          return const SizedBox.shrink();
                        if (height <= playerMinHeight + 50)
                          return Container(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8),
                                        child: Image.network(
                                          selectedVideo.thumbnailUrl,
                                          height: playerMinHeight - 4.0,
                                          width: 120.0,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(selectedVideo.title,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .caption!
                                                    .copyWith(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                overflow:
                                                    TextOverflow.ellipsis),
                                            Text(selectedVideo.author.username,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .caption!
                                                    .copyWith(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w500))
                                          ],
                                        ),
                                      ),
                                      IconButton(
                                          onPressed: () {},
                                          icon: Icon(Icons.play_arrow)),
                                      IconButton(
                                          onPressed: () {
                                            context
                                                .read(selectedVideoProvider)
                                                .state = null;
                                          },
                                          icon: Icon(Icons.close)),
                                    ],
                                  ),
                                  const LinearProgressIndicator(
                                    value: 0.4,
                                    valueColor:
                                        AlwaysStoppedAnimation(Colors.red),
                                  )
                                ],
                              ));
                        return VideoScreen();
                      }),
                )),
        );
      }),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: selectedIndex,
          onTap: (v) => setState(() => selectedIndex = v),
          selectedFontSize: 13.0,
          unselectedFontSize: 10.0,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.explore_outlined),
                activeIcon: Icon(Icons.explore),
                label: 'Explore'),
            BottomNavigationBarItem(
                icon: Icon(Icons.add_circle_outline),
                activeIcon: Icon(Icons.add_circle),
                label: 'Add'),
            BottomNavigationBarItem(
                icon: Icon(Icons.subscriptions_outlined),
                activeIcon: Icon(Icons.subscriptions),
                label: 'Subscription'),
            BottomNavigationBarItem(
                icon: Icon(Icons.video_library_outlined),
                activeIcon: Icon(Icons.video_library),
                label: 'Library')
          ]),
    );
  }
}
