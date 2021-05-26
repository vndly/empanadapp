import 'package:dafluta/dafluta.dart';
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
                        width: 100,
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
        const Text(
          'Availability',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
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
          onPressed: _onSubmit,
          child: const Padding(
            padding: EdgeInsets.fromLTRB(8, 12, 8, 12),
            child: Text('SUBMIT'),
          ),
        ),
        const VBox(20),
      ],
    );
  }

  void _onSubmit() {
    final List<String> names = [];
    final List<int> amounts = [];
    final List<String> preferences = [];

    for (int i = 0; i < state.amountOfPeople; i++) {
      final String name = state.controllersPeopleNames[i].text;

      if (name.isNotEmpty) {
        names.add(name);
        state.setErrorPeopleNames(i, null);
      } else {
        state.setErrorPeopleNames(i, 'Invalid name');
      }

      final String amount = state.controllersPeopleAmounts[i].text;

      if (amount.isNotEmpty) {
        amounts.add(int.parse(amount));
        state.setErrorPeopleAmounts(i, null);
      } else {
        state.setErrorPeopleAmounts(i, 'Invalid amount');
      }

      final String preference = state.controllersPeoplePreferences[i].text;

      if (preference.isNotEmpty) {
        preferences.add(preference);
        state.setErrorPeoplePreferences(i, null);
      } else {
        state.setErrorPeoplePreferences(i, 'Invalid preference');
      }
    }

    if ((names.length == state.amountOfPeople) &&
        (amounts.length == state.amountOfPeople) &&
        (preferences.length == state.amountOfPeople)) {
      state.submit(names, amounts, preferences);
    }
  }
}
