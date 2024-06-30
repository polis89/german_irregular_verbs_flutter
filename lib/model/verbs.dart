
import 'dart:collection';

import 'package:flutter/material.dart';

import '../db_verbs.dart';

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
      notifyListeners();
    });
  }

  toggleVerb(Verb verb, bool isSelected) {
    verbsDatabase.setVerbSelection(verb, isSelected).then((updateCount) {
      if (updateCount == 1) {
        verb.isActive = isSelected;
        print("UPDATED: ${isSelected}");
        notifyListeners();
      } else {
        print("NOT UPDATED");
        // TODO: handle error?
      }
    });
  }
}