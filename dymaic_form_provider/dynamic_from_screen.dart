import 'package:flutter/material.dart';
import 'package:flutter_component/dynamic_form/provider/FormProvider.dart';
import 'package:flutter_component/dynamic_form/provider/form_model.dart';
import 'package:provider/provider.dart';

class DynamicFormScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final formProvider = Provider.of<FormProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: formProvider.forms.length,
              itemBuilder: (context, index) {
                return FormTile(index: index);
              },
            ),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: formProvider.addNewForm,
            child: Text('Add Form'),
          ),
        ],
      ),
    );
  }
}

class FormTile extends StatelessWidget {
  final int index;

  const FormTile({required this.index});

  @override
  Widget build(BuildContext context) {
    final formProvider = Provider.of<FormProvider>(context);
    final form = formProvider.forms[index];

    return ExpansionTile(
      initiallyExpanded: formProvider.isExpanded[index],
      onExpansionChanged: (expanded) {
        formProvider.setExpanded(index, expanded);
      },
      title: Text('Form ${form.rptsl}'),
      trailing: IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          formProvider.removeForm(index);
        },
      ),
      children: [
        DropdownButton<String>(
          value: form.dropdownValue1,
          hint: Text('Select an option'),
          items: <String>['24hr', 'Night time', 'Others'].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: form.isSaved
              ? null
              : (newValue) {
                  formProvider.updateDropdown1(index, newValue!);
                },
        ),
        if (form.dropdownValue1 == 'Others')
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: TextFormField(
              initialValue: form.textFieldValue1,
              decoration: InputDecoration(labelText: 'Specify (1)'),
              onChanged: form.isSaved
                  ? null
                  : (text) {
                      formProvider.updateTextField1(index, text);
                    },
            ),
          ),
        DropdownButton<String>(
          value: form.dropdownValue2,
          hint: Text('Select an option'),
          items: <String>['24hr', 'Night time', 'Others'].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: form.isSaved
              ? null
              : (newValue) {
                  formProvider.updateDropdown2(index, newValue!);
                },
        ),
        if (form.dropdownValue2 == 'Others')
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: TextFormField(
              initialValue: form.textFieldValue2,
              decoration: InputDecoration(labelText: 'Specify (2)'),
              onChanged: form.isSaved
                  ? null
                  : (text) {
                      formProvider.updateTextField2(index, text);
                    },
            ),
          ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: TextFormField(
            initialValue: form.randomTextFieldValue1,
            decoration: InputDecoration(labelText: 'Random Field 1'),
            onChanged: form.isSaved
                ? null
                : (text) {
                    formProvider.updateRandomTextField1(index, text);
                  },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: TextFormField(
            initialValue: form.randomTextFieldValue2,
            decoration: InputDecoration(labelText: 'Random Field 2'),
            onChanged: form.isSaved
                ? null
                : (text) {
                    formProvider.updateRandomTextField2(index, text);
                  },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: CheckboxListTile(
            title: Text('Check this box'),
            value: form.checkboxValue,
            onChanged: form.isSaved
                ? null
                : (newValue) {
                    formProvider.updateCheckbox(index, newValue!);
                  },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed: form.isSaved
                  ? null
                  : () {
                      formProvider.saveForm(index);
                    },
              child: Text('Save'),
            ),
          ],
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
