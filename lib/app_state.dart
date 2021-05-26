import 'package:dafluta/dafluta.dart';
import 'package:flutter/widgets.dart';

class AppState with BaseState {
  int amountOfPeople = 0;
  List<String> names = [];

  TextEditingController controllerAmountPoeple = TextEditingController();
  String? errorAmountPeople;

  final List<TextEditingController> controllersPeopleNames = [];
  List<String?> errorsPeopleNames = [];

  final List<TextEditingController> controllersPeopleAmounts = [];
  List<String?> errorsPeopleAmounts = [];

  final List<TextEditingController> controllersPeoplePreferences = [];
  List<String?> errorsPeoplePreferences = [];

  bool get hasAmountPeople => amountOfPeople > 0;

  void setErrorAmountPeople(String value) {
    errorAmountPeople = value;
    notify();
  }

  void setErrorPeopleNames(int index, String? value) {
    errorsPeopleNames[index] = value;
    notify();
  }

  void setErrorPeopleAmounts(int index, String? value) {
    errorsPeopleAmounts[index] = value;
    notify();
  }

  void setErrorPeoplePreferences(int index, String? value) {
    errorsPeoplePreferences[index] = value;
    notify();
  }

  void setAmountOfPeople(int value) {
    amountOfPeople = value;

    controllersPeopleNames.clear();
    errorsPeopleNames.clear();

    controllersPeopleAmounts.clear();
    errorsPeopleAmounts.clear();

    controllersPeoplePreferences.clear();
    errorsPeoplePreferences.clear();

    for (int i = 0; i < amountOfPeople; i++) {
      errorsPeopleNames.add(null);
      controllersPeopleNames.add(TextEditingController());

      errorsPeopleAmounts.add(null);
      controllersPeopleAmounts.add(TextEditingController());

      errorsPeoplePreferences.add(null);
      controllersPeoplePreferences.add(TextEditingController());
    }

    notify();
  }
}
