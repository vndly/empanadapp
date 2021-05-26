import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:empanadas/app_state.dart';

class ViewAmountPeople extends StatelessWidget {
  final AppState state;

  const ViewAmountPeople(this.state);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 160,
            child: TextField(
              autofocus: true,
              controller: state.controllerAmountPoeple,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: 'Number of people',
                errorText: state.errorAmountPeople,
              ),
            ),
          ),
          const HBox(20),
          ElevatedButton(
            onPressed: _onSubmit,
            child: const Padding(
              padding: EdgeInsets.fromLTRB(8, 12, 8, 12),
              child: Text('CREATE'),
            ),
          ),
        ],
      ),
    );
  }

  void _onSubmit() {
    final String value = state.controllerAmountPoeple.text;

    if (value.isNotEmpty) {
      try {
        final int amount = int.parse(value);

        if (amount > 1) {
          state.setAmountOfPeople(amount);
        } else {
          state.setErrorAmountPeople('Invalid amount');
        }
      } catch (e) {
        state.setErrorAmountPeople('Invalid amount');
      }
    } else {
      state.setErrorAmountPeople('Invalid amount');
    }
  }
}
