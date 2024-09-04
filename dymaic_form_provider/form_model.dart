import 'package:flutter/material.dart';

class FormModel {
  int rptsl;
  String? dropdownValue1;
  String? dropdownValue2;
  String? textFieldValue1;
  String? textFieldValue2;
  String? randomTextFieldValue1;
  String? randomTextFieldValue2;
  bool checkboxValue = false;
  bool isSaved = false;

  FormModel({
    required this.rptsl,
    this.dropdownValue1,
    this.dropdownValue2,
    this.textFieldValue1,
    this.textFieldValue2,
    this.randomTextFieldValue1,
    this.randomTextFieldValue2,
  });
}
