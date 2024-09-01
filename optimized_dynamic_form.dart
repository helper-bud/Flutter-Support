import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dynamic Form Example',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Dynamic Form Example'),
        ),
        body: DynamicFormScreen(),
      ),
    );
  }
}

class DynamicFormScreen extends StatefulWidget {
  @override
  _DynamicFormScreenState createState() => _DynamicFormScreenState();
}

class _DynamicFormScreenState extends State<DynamicFormScreen> {
  List<FormModel> formList = []; // List to hold all forms
  List<bool> isExpandedList = []; // Track the expansion state of each form

  @override
  void initState() {
    super.initState();
    _addNewForm(); // Add the first form by default
  }

  void _addNewForm({FormModel? previousForm}) {
    if (formList.isNotEmpty && !formList.last.isSaved) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please save the current form before adding a new one.')),
      );
      return;
    }

    setState(() {
      formList.add(previousForm ?? FormModel(rptsl: formList.length + 1));
      isExpandedList.add(true); // Start with the new form expanded
    });
  }

  void _removeForm(int index) {
    setState(() {
      formList.removeAt(index);
      isExpandedList.removeAt(index);
    });
  }

  void _saveForm(int index) {
    if (!_allFieldsFilled(formList[index])) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields before saving.')),
      );
      return;
    }

    setState(() {
      formList[index].isSaved = true;
      isExpandedList[index] = false; // Close the expansion tile upon saving
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Form ${formList[index].rptsl} saved!')),
    );
  }

  bool _allFieldsFilled(FormModel form) {
    return [form.dropdownValue1, form.dropdownValue2, form.dropdownValue3]
            .every((value) => value != null) &&
        [form.textFieldValue1, form.textFieldValue2, form.textFieldValue3]
            .every((value) => value != null);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...formList.asMap().entries.map((entry) {
              int index = entry.key;
              return _buildForm(entry.value, index);
            }).toList(),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () => _addNewForm(),
                  child: Text('Add Form'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildForm(FormModel form, int index) {
    return ExpansionTile(
      initiallyExpanded: isExpandedList[index],
      onExpansionChanged: (expanded) => setState(() => isExpandedList[index] = expanded),
      title: Text('Form ${form.rptsl}'),
      trailing: IconButton(
        icon: Icon(Icons.close),
        onPressed: () => _removeForm(index),
      ),
      children: [
        ..._buildDropdownFields(form),
        ..._buildTextFields(form),
        SizedBox(height: 16),
        Align(
          alignment: Alignment.centerRight,
          child: ElevatedButton(
            onPressed: () => _saveForm(index),
            child: Text('Save'),
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  List<Widget> _buildDropdownFields(FormModel form) {
    return [
      _buildDropdownField(form, 1),
      _buildDropdownField(form, 2),
      _buildDropdownField(form, 3),
    ];
  }

  Widget _buildDropdownField(FormModel form, int fieldNumber) {
    String? currentValue;
    switch (fieldNumber) {
      case 1:
        currentValue = form.dropdownValue1;
        break;
      case 2:
        currentValue = form.dropdownValue2;
        break;
      case 3:
        currentValue = form.dropdownValue3;
        break;
    }

    return Column(
      children: [
        DropdownButton<String>(
          value: currentValue,
          hint: Text('Select an option for dropdown $fieldNumber'),
          items: <String>['24hr', 'Night time', 'Others'].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (newValue) {
            setState(() {
              switch (fieldNumber) {
                case 1:
                  form.dropdownValue1 = newValue;
                  break;
                case 2:
                  form.dropdownValue2 = newValue;
                  break;
                case 3:
                  form.dropdownValue3 = newValue;
                  break;
              }
            });
          },
        ),
        if (currentValue == 'Others')
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: _buildTextField(form, fieldNumber),
          ),
      ],
    );
  }

  List<Widget> _buildTextFields(FormModel form) {
    return [
      _buildTextField(form, 1),
      _buildTextField(form, 2),
      _buildTextField(form, 3),
    ];
  }

  Widget _buildTextField(FormModel form, int fieldNumber) {
    TextEditingController controller;

    switch (fieldNumber) {
      case 1:
        controller = TextEditingController(text: form.textFieldValue1);
        break;
      case 2:
        controller = TextEditingController(text: form.textFieldValue2);
        break;
      case 3:
        controller = TextEditingController(text: form.textFieldValue3);
        break;
      default:
        controller = TextEditingController();
    }

    return TextField(
      controller: controller,
      onChanged: (text) {
        switch (fieldNumber) {
          case 1:
            form.textFieldValue1 = text;
            break;
          case 2:
            form.textFieldValue2 = text;
            break;
          case 3:
            form.textFieldValue3 = text;
            break;
        }
      },
      decoration: InputDecoration(
        labelText: 'Please specify ($fieldNumber)',
        border: OutlineInputBorder(),
      ),
    );
  }
}

class FormModel {
  int rptsl; // Unique identifier for each form
  String? dropdownValue1;
  String? dropdownValue2;
  String? dropdownValue3;
  String? textFieldValue1;
  String? textFieldValue2;
  String? textFieldValue3;
  bool isSaved = false;

  FormModel({
    required this.rptsl,
    this.dropdownValue1,
    this.dropdownValue2,
    this.dropdownValue3,
    this.textFieldValue1,
    this.textFieldValue2,
    this.textFieldValue3,
  });
}
