import 'package:flutter/material.dart';
import 'package:flutter_component/dynamic_form/provider/form_model.dart';

class FormProvider with ChangeNotifier {
  List<FormModel> forms = [];
  List<bool> isExpanded = [];

  void addNewForm() {
    if (forms.isNotEmpty && !forms.last.isSaved) {
      // Show a message if the previous form is not saved
      return;
    }

    int newRptsl = forms.length + 1;
    forms.add(FormModel(rptsl: newRptsl));
    isExpanded.add(true);
    notifyListeners();
  }

  void removeForm(int index) {
    forms.removeAt(index);
    isExpanded.removeAt(index);
    notifyListeners();
  }

  void saveForm(int index) {
    FormModel form = forms[index];
    if (form.dropdownValue1 == null ||
        (form.dropdownValue1 == 'Others' && form.textFieldValue1 == null) ||
        form.dropdownValue2 == null ||
        (form.dropdownValue2 == 'Others' && form.textFieldValue2 == null) ||
        form.randomTextFieldValue1 == null ||
        form.randomTextFieldValue2 == null) {
      // Show a message if not all fields are filled
      return;
    }

    form.isSaved = true;
    isExpanded[index] = false;
    notifyListeners();

    // Log the values
    print('Form ${form.rptsl} saved with values:');
    print('Dropdown 1: ${form.dropdownValue1}');
    print('Text Field 1: ${form.textFieldValue1}');
    print('Dropdown 2: ${form.dropdownValue2}');
    print('Text Field 2: ${form.textFieldValue2}');
    print('Random Field 1: ${form.randomTextFieldValue1}');
    print('Random Field 2: ${form.randomTextFieldValue2}');
    print('Checkbox: ${form.checkboxValue}');
  }

  void setExpanded(int index, bool expanded) {
    isExpanded[index] = expanded;
    notifyListeners();
  }

  void updateDropdown1(int index, String value) {
    forms[index].dropdownValue1 = value;
    notifyListeners();
  }

  void updateTextField1(int index, String value) {
    forms[index].textFieldValue1 = value;
    notifyListeners();
  }

  void updateDropdown2(int index, String value) {
    forms[index].dropdownValue2 = value;
    notifyListeners();
  }

  void updateTextField2(int index, String value) {
    forms[index].textFieldValue2 = value;
    notifyListeners();
  }

  void updateRandomTextField1(int index, String value) {
    forms[index].randomTextFieldValue1 = value;
    notifyListeners();
  }

  void updateRandomTextField2(int index, String value) {
    forms[index].randomTextFieldValue2 = value;
    notifyListeners();
  }

  void updateCheckbox(int index, bool value) {
    forms[index].checkboxValue = value;
    notifyListeners();
  }
}
