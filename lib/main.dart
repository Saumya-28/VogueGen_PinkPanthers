import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:vogue_gen/Theme/appTheme.dart';
import 'package:vogue_gen/presentation/build_with_me.dart';
import 'package:vogue_gen/presentation/explore_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: appTheme(),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    ExplorePage(),
    BuildWithMe()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Icon(
          Icons.menu,
          color: Theme.of(context).primaryColor,
        ),
        title: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: const TextField(
            decoration: InputDecoration(
              hintText: "Search",
              border: InputBorder.none,
              hintStyle: TextStyle(color: Colors.grey),
            ),
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search, color: Theme.of(context).primaryColor),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.notifications, color: Theme.of(context).primaryColor),
            onPressed: () {},
          )
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 24.0, right: 24),
        child: Container(
          height: 56,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.8),
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).primaryColor.withOpacity(0.3),
                offset: const Offset(0, 20),
                blurRadius: 20,
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom, top: 8, left: 12, right: 12),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedIndex = 0;
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        'Made With Scratch',
                        style: TextStyle(
                          color: _selectedIndex == 0 ? Colors.white : Colors.white70,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16), // Adjust spacing between buttons as needed
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedIndex = 1;
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        'Create',
                        style: TextStyle(
                          color: _selectedIndex == 1 ? Colors.white : Colors.white70,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}

class CustomBottomNavigationBar extends StatefulWidget {
  @override
  _CustomBottomNavigationBarState createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int selectedIndex = 0; // Track the selected index, default to the first button

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(bottom: 16), // Replace with your bottomPad value
        child: Container(
          height: 56,
          padding: const EdgeInsets.only(left: 12, top: 8, right: 12, bottom: 8),
          margin: const EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.8),
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).primaryColor.withOpacity(0.3),
                offset: const Offset(0, 20),
                blurRadius: 20,
              ),
            ],
          ),
          child: Row(
            children: [
              buildNavItem(0, 'Explore'),
              SizedBox(width: 16), // Adjust spacing between buttons as needed
              buildNavItem(1, 'Made with Scratch'),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildNavItem(int index, String title) {
    bool isSelected = index == selectedIndex;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedIndex = index;
          });
          // Handle button tap as needed
          if (isSelected) {
            // Perform actions when selected
            print('$title is selected');
            // Example: Navigate to a screen or perform other actions
          }
        },
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Theme.of(context).primaryColor.withOpacity(0.8),
            borderRadius: const BorderRadius.all(Radius.circular(16)),
          ),
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Text(
            title,
            style: TextStyle(
              color: isSelected ? Theme.of(context).primaryColor : Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
