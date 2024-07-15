import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:vogue_gen/presentation/videoPage.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final List<String> _categories = [
    'Dresses',
    'Tops',
    'Bottoms',
    'Shoes',
    'Accessories'
  ];
  final List<String> _videos = [
    'assets/videos/nancy_1.mp4',
    'assets/videos/nancy_2.mp4',
    'assets/videos/nancy_3.mp4',
    'assets/videos/nancy_4.mp4',
    'assets/videos/nancy_5.mp4',
  ];

  int _selectedIndex = -1; // No chip selected initially

  final List<VideoPlayerController> _controllers = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 5; i++) {
      final controller =
      VideoPlayerController.asset(_videos[i % _videos.length]);
      _controllers.add(controller);
      controller.initialize().then((_) {
        setState(
                () {});
      });
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              delegate: _SliverAppBarDelegate(
                minHeight: 120.0,
                maxHeight: 120.0,
                child: Container(
                  color: Material.of(context).color,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Wrap(
                      spacing: 5.0, // Space between chips horizontally
                      runSpacing: 5.0, // Space between rows
                      children: List<Widget>.generate(
                        _categories.length,
                            (int index) {
                          return ChoiceChip(
                            label: Text(_categories[index]),
                            selected: _selectedIndex == index,
                            onSelected: (bool selected) {
                              setState(() {
                                _selectedIndex = selected ? index : -1;
                              });
                            },
                            elevation: 4.0,
                            shadowColor: Colors.grey,
                            selectedColor: Colors.blue.withOpacity(0.5),
                            backgroundColor: Colors.white,
                            labelStyle: TextStyle(
                              color: _selectedIndex == index
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: const SizedBox(height: 16),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  final controller = _controllers[index];
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.primaries[index % Colors.primaries.length],
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    width: double.infinity,
                    child: controller.value.isInitialized
                        ? Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.primaries[index % Colors.primaries.length],
                      ),
                      margin: const EdgeInsets.only(top: 5),
                      width: double.infinity,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: AspectRatio(
                              aspectRatio: 9.0 / 16.0,
                              child: VideoPlayer(controller),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => VideoPage(controller: controller),
                                ),
                              );
                            },
                            child: Icon(
                              Icons.play_arrow,
                              size: 64.0,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    )

                        : Center(child: CircularProgressIndicator()),
                  );
                },
                childCount: _controllers.length,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            for (var controller in _controllers) {
              if (controller.value.isPlaying) {
                controller.pause();
              } else {
                controller.play();
              }
            }
          });
        },
        child: Icon(
          _controllers.isNotEmpty && _controllers[0].value.isPlaying
              ? Icons.pause
              : Icons.play_arrow,
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(covariant _SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}

void main() {
  runApp(const MaterialApp(home: ExplorePage()));
}
