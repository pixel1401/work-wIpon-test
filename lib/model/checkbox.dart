import 'dart:math';

import 'package:flutter/material.dart';

class CheckboxType {
  bool state;
  Color color;
  int index;
  CheckboxType({required this.index, required this.state, required this.color});
}

class CheckboxModel {
  List<CheckboxType> checkboxType = [];
  List<CheckboxType> checkboxes = [];

  CheckboxModel({required this.checkboxType});

  //! INIT FIRST Checkbox
  CheckboxType initCheckbox() {
    if (checkboxType.isNotEmpty) {
      checkboxes.add(checkboxType[0]);
      return checkboxType[0];
    } else {
      throw 'INit Dont work';
    }
  }

  //! CHANGE STATE ACTIVE OR NO ACTIVE
  void toggleCheckbox(int indexType) {
    for (var a in checkboxType) {
      if (a.index == indexType) {
        a.state = !a.state;
      } else {
        a.state = false;
      }
    }
  }

  //! RETURN STATE Checkbox current Type
  bool setTypeCheckbox(int indexType) {
    for (var a in checkboxType) {
      if (a.index == indexType) {
        return a.state;
      }
    }
    throw 'Dont setTypeCheckbox indexType = $indexType';
    // return false;
  }

  //! RETURN Checkbox
  CheckboxType getCurrentCheckBox(int indexType) {
    for (var a in checkboxType) {
      if (a.index == indexType) {
        checkboxes.add(a);
        return a;
      }
    }
    throw 'Dont indexType getCurrentCheckBox Checkbox $indexType';
    // return checkboxType[0];
  }

  // ! ADD NEW addCheckboxes
  addCheckboxes() {
    var random = Random();
    checkboxes = [
      ...checkboxes,
      ...(List<CheckboxType>.generate(10, (int index) {
        int randomNumber = random.nextInt(checkboxType.length) + 1;
        return getCurrentCheckBox(randomNumber);
      }))
    ];
  }


  //! CLEAR
  void clearCheckboxes() {
    checkboxes.length = 1;
  }
}
