import 'package:flutter/material.dart';
import 'package:atlas_fitness/backend/model/person.dart';

class UserInfo extends ChangeNotifier {
  late Person _person;

  // Getter for person
  Person get person => _person;

  // Setter for person
  set person(Person newPerson) {
    _person = newPerson;
    notifyListeners();
  }
}
