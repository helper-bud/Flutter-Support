/*
full dynammic form. 

Cross Button: Add a cross button at the top right of each form to remove it.
Validation: Ensure that all fields in a form must be filled before saving.
Form Expansion: Wrap each form inside an ExpansionTile to open/close the form.
Conditional Form Creation: Prevent creating a new form if the previous one is not saved.
Auto-Close on Save: Automatically close the ExpansionTile upon saving the form.
*/

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
    // Check if the last form is saved before adding a new one
    if (formList.isNotEmpty && !formList.last.isSaved) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please save the current form before adding a new one.')),
      );
      return;
    }

    setState(() {
      int newRptsl = formList.length + 1;
      formList.add(previousForm ?? FormModel(rptsl: newRptsl)); // Use previous form values if provided
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
    // Check if all fields are filled
    FormModel form = formList[index];
    if (form.dropdownValue1 == null ||
        (form.dropdownValue1 == 'Others' && form.textFieldValue1 == null) ||
        form.dropdownValue2 == null ||
        (form.dropdownValue2 == 'Others' && form.textFieldValue2 == null) ||
        form.dropdownValue3 == null ||
        (form.dropdownValue3 == 'Others' && form.textFieldValue3 == null) ||
        form.textFieldValue1 == null ||
        form.textFieldValue2 == null ||
        form.textFieldValue3 == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields before saving.')),
      );
      return;
    }

    setState(() {
      form.isSaved = true;
      isExpandedList[index] = false; // Close the expansion tile upon saving
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Form ${form.rptsl} saved!')),
    );
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
              FormModel form = entry.value;
              return _buildForm(form, index);
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
      onExpansionChanged: (expanded) {
        setState(() {
          isExpandedList[index] = expanded;
        });
      },
      title: Text('Form ${form.rptsl}'),
      trailing: IconButton(
        icon: Icon(Icons.close),
        onPressed: () => _removeForm(index),
      ),
      children: [
        DropdownButton<String>(
          value: form.dropdownValue1,
          hint: Text('Select an option for first dropdown'),
          items: <String>['24hr', 'Night time', 'Others'].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (newValue) {
            setState(() {
              form.dropdownValue1 = newValue;
            });
          },
        ),
        if (form.dropdownValue1 == 'Others') // Show TextField if "Others" is selected
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: TextField(
              controller: TextEditingController(text: form.textFieldValue1),
              onChanged: (text) {
                form.textFieldValue1 = text;
              },
              decoration: InputDecoration(
                labelText: 'Please specify (1)',
                border: OutlineInputBorder(),
              ),
            ),
          ),
        SizedBox(height: 16),

        DropdownButton<String>(
          value: form.dropdownValue2,
          hint: Text('Select an option for second dropdown'),
          items: <String>['24hr', 'Night time', 'Others'].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (newValue) {
            setState(() {
              form.dropdownValue2 = newValue;
            });
          },
        ),
        if (form.dropdownValue2 == 'Others') // Show TextField if "Others" is selected
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: TextField(
              controller: TextEditingController(text: form.textFieldValue2),
              onChanged: (text) {
                form.textFieldValue2 = text;
              },
              decoration: InputDecoration(
                labelText: 'Please specify (2)',
                border: OutlineInputBorder(),
              ),
            ),
          ),
        SizedBox(height: 16),

        DropdownButton<String>(
          value: form.dropdownValue3,
          hint: Text('Select an option for third dropdown'),
          items: <String>['24hr', 'Night time', 'Others'].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (newValue) {
            setState(() {
              form.dropdownValue3 = newValue;
            });
          },
        ),
        if (form.dropdownValue3 == 'Others') // Show TextField if "Others" is selected
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: TextField(
              controller: TextEditingController(text: form.textFieldValue3),
              onChanged: (text) {
                form.textFieldValue3 = text;
              },
              decoration: InputDecoration(
                labelText: 'Please specify (3)',
                border: OutlineInputBorder(),
              ),
            ),
          ),
        SizedBox(height: 16),

        // Random TextFormFields
        TextFormField(
          controller: TextEditingController(text: form.textFieldValue1),
          decoration: InputDecoration(
            labelText: 'Random Field 1',
            border: OutlineInputBorder(),
          ),
          onChanged: (text) {
            form.textFieldValue1 = text;
          },
        ),
        SizedBox(height: 16),
        TextFormField(
          controller: TextEditingController(text: form.textFieldValue2),
          decoration: InputDecoration(
            labelText: 'Random Field 2',
            border: OutlineInputBorder(),
          ),
          onChanged: (text) {
            form.textFieldValue2 = text;
          },
        ),
        SizedBox(height: 16),
        TextFormField(
          controller: TextEditingController(text: form.textFieldValue3),
          decoration: InputDecoration(
            labelText: 'Random Field 3',
            border: OutlineInputBorder(),
          ),
          onChanged: (text) {
            form.textFieldValue3 = text;
          },
        ),
        SizedBox(height: 16),

        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed: () => _saveForm(index),
              child: Text('Save'),
            ),
          ],
        ),
        SizedBox(height: 16),
      ],
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
