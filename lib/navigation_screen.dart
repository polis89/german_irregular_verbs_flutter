import 'package:flutter/material.dart';
import 'verbs_list.dart';
import 'game_fill_gaps.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key, required this.title});

  final String title;

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _selectedTab = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title,
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
      ),
      body: Center(
          child: switch (_selectedTab) {
        == 1 => VerbsList(),
        == 2 => const Text("Settings"),
        _ => buildMainScreen(context)
      }),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Practice',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_rounded),
            label: 'Verbs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedTab,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        backgroundColor: Theme.of(context).colorScheme.surface,
        onTap: _onItemTapped,
      ),
    );
  }

  Padding buildMainScreen(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const GameFillGaps(),
                          ),
                        );
                      },
                      child: Card(
                        color: Theme.of(context).colorScheme.surface,
                        elevation: 3,
                        child: Center(
                          child: Text(
                            "Fill the Gaps",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface,
                              fontSize: 18.0,
                            ),
                          ),
                        ), // Center the text inside the card
                      ),
                    ),
                  ),
                  Expanded(
                    child: Card(
                      color: Theme.of(context).colorScheme.surface,
                      elevation: 3,
                      child: Center(
                        child: Text(
                          "??",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface,
                            fontSize: 18.0,
                          ),
                        ),
                      ), // Center the text inside the card
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                child: Row(
                  children: [
                    Expanded(
                      child: Card(
                        color: Theme.of(context).colorScheme.surface,
                        elevation: 3,
                        child: Center(
                          child: Text(
                            "Type",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface,
                              fontSize: 18.0,
                            ),
                          ),
                        ), // Center the text inside the card
                      ),
                    ),
                    Expanded(
                      child: Card(
                        color: Theme.of(context).colorScheme.surface,
                        elevation: 3,
                        child: Center(
                          child: Text(
                            "True or False",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface,
                              fontSize: 18.0,
                            ),
                          ),
                        ), // Center the text inside the card
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
