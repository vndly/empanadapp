import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:empanadas/app_state.dart';

class ViewResult extends StatelessWidget {
  final AppState state;

  const ViewResult(this.state);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final MapEntry<String, String> entry in state.personsOrder.entries)
          Padding(
            padding: const EdgeInsets.all(3),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${entry.key}:   ',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  entry.value,
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
        const VBox(20),
        for (final MapEntry<String, int> entry in state.finalOrder.entries)
          Padding(
            padding: const EdgeInsets.all(3),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 120,
                  child: Text(
                    '${AppState.EMPANADAS[entry.key]}:  ',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                Text(
                  '${entry.value}',
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
        const VBox(20),
      ],
    );
  }
}
