import 'package:dafluta/dafluta.dart';
import 'package:empanadas/person.dart';
import 'package:flutter/material.dart';
import 'package:empanadas/app_state.dart';

class ViewPeopleNames extends StatelessWidget {
  final AppState state;

  const ViewPeopleNames(this.state);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Form(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const VBox(15),
              for (int i = 0; i < state.amountOfPeople; i++)
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 200,
                        child: TextField(
                          autofocus: true,
                          maxLines: 1,
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () =>
                              FocusScope.of(context).nextFocus(),
                          textCapitalization: TextCapitalization.sentences,
                          controller: state.controllersPeopleNames[i],
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            hintText: 'Name',
                            errorText: state.errorsPeopleNames[i],
                          ),
                        ),
                      ),
                      const HBox(20),
                      Container(
                        width: 120,
                        child: TextField(
                          autofocus: true,
                          maxLines: 1,
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () =>
                              FocusScope.of(context).nextFocus(),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.right,
                          controller: state.controllersPeopleAmounts[i],
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            hintText: 'Amount',
                            errorText: state.errorsPeopleAmounts[i],
                          ),
                        ),
                      ),
                      const HBox(20),
                      Container(
                        width: 500,
                        child: TextField(
                          autofocus: true,
                          maxLines: 1,
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () =>
                              FocusScope.of(context).nextFocus(),
                          textCapitalization: TextCapitalization.sentences,
                          controller: state.controllersPeoplePreferences[i],
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            hintText: 'Preference',
                            errorText: state.errorsPeoplePreferences[i],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const VBox(20),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final String key in AppState.EMPANADAS.keys)
              Padding(
                padding: const EdgeInsets.all(3),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 200,
                      child: Text(
                        '($key) ${AppState.EMPANADAS[key]}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    Checkbox(
                        value: state.selectedEmpanadas[key],
                        onChanged: (value) =>
                            state.selectEmpanadaAvailability(key, value!)),
                  ],
                ),
              ),
          ],
        ),
        const VBox(20),
        ElevatedButton(
          onPressed: () => _onSubmit(context),
          child: const Padding(
            padding: EdgeInsets.fromLTRB(8, 12, 8, 12),
            child: Text('SUBMIT'),
          ),
        ),
        const VBox(20),
      ],
    );
  }

  void _onSubmit(BuildContext context) {
    final List<Person> persons = [];

    for (int i = 0; i < state.amountOfPeople; i++) {
      final String name = state.controllersPeopleNames[i].text;

      if (name.isNotEmpty) {
        state.setErrorPeopleNames(i, null);
      } else {
        state.setErrorPeopleNames(i, 'Invalid name');
      }

      final String amount = state.controllersPeopleAmounts[i].text;

      if (amount.isNotEmpty && (int.parse(amount) >= 1)) {
        state.setErrorPeopleAmounts(i, null);
      } else {
        state.setErrorPeopleAmounts(i, 'Invalid amount');
      }

      final List<String> preference =
          state.controllersPeoplePreferences[i].text.split(',');
      final bool wrongPreferences = preference.any((element) =>
          !AppState.EMPANADAS.keys.contains(element.toUpperCase()));

      if (preference.isNotEmpty && !wrongPreferences) {
        state.setErrorPeoplePreferences(i, null);
      } else {
        state.setErrorPeoplePreferences(i, 'Invalid preference');
      }

      persons.add(Person(name, int.parse(amount),
          preference.map((e) => e.toUpperCase()).toList(), []));
    }

    if (persons.length == state.amountOfPeople) {
      final String message = state.submit(persons);

      if (message.isNotEmpty) {
        _showError(context, message);
      }
    }
  }

  void _showError(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: Text(message),
        actions: [
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ),
        ],
      ),
    );
  }
}
