import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GameFillGaps extends StatefulWidget {
  const GameFillGaps({super.key});

  @override
  State<GameFillGaps> createState() => _GameFillGapsState();
}

class _GameFillGapsState extends State<GameFillGaps> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          title: Text("Fill the Gaps",
              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
        ),
        body: Column(
          children: [
            Expanded(child: Center(child: Text("test"))),
            GridView.count(
              shrinkWrap: true,
              primary: false,
              padding: const EdgeInsets.all(4),
              crossAxisSpacing: 0,
              mainAxisSpacing: 0,
              crossAxisCount: 2,
              children: <Widget>[
                Card(
                  color: Theme.of(context).colorScheme.surface,
                  child: Center(child: Text("First")),
                  elevation: 3,
                ),
                Card(
                  color: Theme.of(context).colorScheme.surface,
                  child: Center(child: const Text('Second')),
                  elevation: 3,
                ),
                Card(
                  color: Theme.of(context).colorScheme.surface,
                  child: Center(child: const Text('Third')),
                  elevation: 3,
                ),
                Card(
                  color: Theme.of(context).colorScheme.surface,
                  child: Center(child: const Text('Fourth')),
                  elevation: 3,
                ),
              ],
            ),
          ],
        ));
  }
}
