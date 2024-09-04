import 'package:flutter/material.dart';
import 'package:flutter_component/dynamic_form/provider/dynamic_form_screen.dart';
import 'package:provider/provider.dart';

import 'FormProvider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FormProvider()),
      ],
      child: MaterialApp(
        title: 'Dynamic Form Example',
        home: Scaffold(
          appBar: AppBar(
            title: Text('Dynamic Form Example'),
          ),
          body: DynamicFormScreen(),
        ),
      ),
    );
  }
}
