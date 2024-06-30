import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'db_verbs.dart';
import 'model/verbs.dart';

class VerbsList extends StatelessWidget {
  const VerbsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<VerbsModel>(
        builder: (context, verbsModel, child) {
          String language = "en";
          return ListView.builder(
              itemCount: verbsModel.allVerbs.length,
              itemBuilder: (BuildContext context, int index) {
                Verb verb = verbsModel.allVerbs[index];
                return CheckboxListTile(
                    title: Text("${verb.infinitive} - ${verb.simplePast} - ${verb.pastParticiple}"),
                    subtitle: Text(verb.translations?[language]),
                    value: verb.isActive,
                    onChanged: (bool? isSelected) {
                      if (isSelected != null) {
                        verbsModel.toggleVerb(verb, isSelected);
                      }
                    },
                    controlAffinity: ListTileControlAffinity.leading
                );
              }
          );
        }
    );
  }
}