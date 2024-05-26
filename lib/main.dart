import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'db_verbs.dart';

void main() {
  runApp(
      ChangeNotifierProvider(
        create: (context) => VerbsModel(),
        child: const MyApp()
      ),
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

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

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
        title: Text(widget.title, style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
      ),
      body: Center(
        child: switch (_selectedTab) {
          == 1 => VerbsList(),
          == 2 => const Text("Settings"),
          _ => const Text("Practice"),
        }
      ),
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
        onTap: _onItemTapped,
      ),
    );
  }
}

class VerbsModel extends ChangeNotifier {
  VerbsDB verbsDatabase = VerbsDB.instance;
  List<Verb> allVerbs = [];

  /// An unmodifiable view of the items in the cart.
  UnmodifiableListView<Verb> get verbs => UnmodifiableListView(allVerbs);

  VerbsModel() {
    refreshVerbs();
  }

  void add(Verb verb) {
    allVerbs.add(verb);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  @override
  void dispose() {
    verbsDatabase.close();
    print("close");
    super.dispose();
  }

  refreshVerbs() {
    verbsDatabase.getAllVerbs().then((value) {
      allVerbs = value;
      print("open");
      notifyListeners();
    });
  }
}

// @override
// void initState() {
//   refreshVerbs();
//   super.initState();
// }
//

class VerbsList extends StatelessWidget {
  const VerbsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<VerbsModel>(
      builder: (context, verbs, child) {
        String language = "en";
        return ListView.builder(
            itemCount: verbs.allVerbs.length,
            itemBuilder: (BuildContext context, int index) {
              Verb verb = verbs.allVerbs[index];
              return CheckboxListTile(
                title: Text("${verb.infinitive} - ${verb.simplePast} - ${verb.pastParticiple}"),
                subtitle: Text(verb.translations?[language]),
                value: verb.isActive,
                onChanged: (bool? value) {
                  print("Clicked value: $value, verb: $verb");
                },
                controlAffinity: ListTileControlAffinity.leading
              );
            }
        );
      }
    );
  }
}