import 'package:dafluta/dafluta.dart';
import 'package:empanadas/view_people_names.dart';
import 'package:empanadas/view_result.dart';
import 'package:flutter/material.dart';
import 'package:empanadas/app_state.dart';
import 'package:empanadas/view_amount_people.dart';

class EmpanadasApp extends StatelessWidget {
  final AppState state = AppState();

  @override
  Widget build(BuildContext context) {
    const int color = 0xffcd7023;

    return MaterialApp(
      title: 'Empanadapp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: const MaterialColor(
          color,
          {
            50: Color(color),
            100: Color(color),
            200: Color(color),
            300: Color(color),
            400: Color(color),
            500: Color(color),
            600: Color(color),
            700: Color(color),
            800: Color(color),
            900: Color(color)
          },
        ),
      ),
      home: StateProvider<AppState>(
        state: state,
        builder: (context, state) => Scaffold(
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (!state.hasAmountPeople) ViewAmountPeople(state),
                  if (state.hasAmountPeople) ViewPeopleNames(state),
                  if (state.hasOrder) ViewResult(state)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
