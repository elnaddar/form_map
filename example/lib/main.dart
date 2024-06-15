import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:form_map/form_map.dart';

enum FormFields { name, email }

void main() {
  final formKey = GlobalKey<FormState>();
  final formMap = FormMap<FormFields>(key: formKey);

  runApp(MyApp(formMap: formMap, formKey: formKey));
}

class MyApp extends StatelessWidget {
  final FormMap<FormFields> formMap;
  final GlobalKey<FormState> formKey;

  const MyApp({super.key, required this.formMap, required this.formKey});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('FormMap Example')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Name'),
                  onSaved: (value) => formMap[FormFields.name] = value,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Email'),
                  onSaved: (value) => formMap[FormFields.email] = value,
                ),
                ElevatedButton(
                  onPressed: () {
                    formMap.submit((data) {
                      if (kDebugMode) {
                        print('Form data: $data');
                      }
                    });
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
