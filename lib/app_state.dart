import 'package:dafluta/dafluta.dart';
import 'package:empanadas/person.dart';
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

  final Map<String, bool> selectedEmpanadas = {};

  final Map<String, String> personsOrder = {};
  final Map<String, int> finalOrder = {};

  static const EMPANADAS = {
    'AT': 'Atún',
    'BA': 'Bacalao',
    'BE': 'Bechamel',
    'CA': 'Carne',
    'CE': 'Cebolla',
    'CH': 'Chorizo',
    'JA': 'Jamón',
    'MA': 'Manzana',
    'PO': 'Pollo',
    'VE': 'Vegetariana',
    'ES': 'Especial'
  };

  bool get hasAmountPeople => amountOfPeople > 0;

  bool get hasOrder => personsOrder.isNotEmpty && finalOrder.isNotEmpty;

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

    selectedEmpanadas.clear();

    for (final String key in EMPANADAS.keys) {
      selectedEmpanadas[key] = false;
    }

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

  void selectEmpanadaAvailability(String key, bool value) {
    selectedEmpanadas[key] = value;
    notify();
  }

  String submit(List<Person> persons) {
    final List<String> availableEmpanadas = [];

    for (final String key in selectedEmpanadas.keys) {
      if (selectedEmpanadas[key]!) {
        availableEmpanadas.add(key);
      }
    }

    if (availableEmpanadas.isEmpty) {
      return 'Select available empanadas';
    } else {
      final String message = fillOrders(availableEmpanadas, persons);

      if (message.isEmpty) {
        personsOrder.clear();
        personsOrder.addAll(getPersonsOrder(persons));

        finalOrder.clear();
        finalOrder.addAll(getFinalOrder(persons));

        notify();
      }

      return message;
    }
  }

  String fillOrders(List<String> availableEmpanadas, List<Person> persons) {
    for (final Person person in persons) {
      person.order.clear();
      int amount = person.amount;

      for (final String preference in person.preferences) {
        if ((amount > 0) && availableEmpanadas.contains(preference)) {
          person.order.add(preference);
          amount--;
        }
      }

      if (amount > 0) {
        return 'Cannot make order for ${person.name}';
      }
    }

    return '';
  }

  Map<String, String> getPersonsOrder(List<Person> persons) {
    final Map<String, String> personsOrder = {};

    for (final Person person in persons) {
      personsOrder[person.name] =
          person.order.map((code) => EMPANADAS[code]).join('   ');
    }

    return personsOrder;
  }

  Map<String, int> getFinalOrder(List<Person> persons) {
    final Map<String, int> finalOrder = {};

    for (final Person person in persons) {
      for (final String empanadaCode in person.order) {
        if (finalOrder.containsKey(empanadaCode)) {
          finalOrder[empanadaCode] = finalOrder[empanadaCode]! + 1;
        } else {
          finalOrder[empanadaCode] = 1;
        }
      }
    }

    return finalOrder;
  }
}
