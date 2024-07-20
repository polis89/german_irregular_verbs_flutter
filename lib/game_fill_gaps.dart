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
          title: Text("TEST",
              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
        ),
        body: Text("GAME 1"));
  }
}
