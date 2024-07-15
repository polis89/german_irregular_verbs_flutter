import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/verbs.dart';
import 'verbs_list.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
        create: (context) => VerbsModel(), child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'German Irregular Verbs',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      home: const MainPage(title: 'German Irregular Verbs'),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
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

// @override
// void initState() {
//   refreshVerbs();
//   super.initState();
// }
//
