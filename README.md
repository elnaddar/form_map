# from_map

A package to make it easy to get/post information to/from form.

## Features

- Easily manage form data using enums.
- Convert form data to a map and back.
- Custom handlers for form field processing.

## Getting started

To use this package, add `from_map` to your `pubspec.yaml` file:

```yaml
dependencies:
  from_map: ^0.0.1
```

## Usage

Here is a basic example of how to use the `FormMap` class:

```dart
import 'package:flutter/material.dart';
import 'package:from_map/from_map.dart';

enum FormFields { name, email }

void main() {
  final formKey = GlobalKey<FormState>();
  final formMap = FormMap<FormFields>(key: formKey);

  runApp(MyApp(formMap: formMap, formKey: formKey));
}

class MyApp extends StatelessWidget {
  final FormMap<FormFields> formMap;
  final GlobalKey<FormState> formKey;

  MyApp({required this.formMap, required this.formKey});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('FormMap Example')),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Name'),
                  onSaved: (value) => formMap[FormFields.name] = value,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Email'),
                  onSaved: (value) => formMap[FormFields.email] = value,
                ),
                ElevatedButton(
                  onPressed: () {
                    formMap.submit((data) {
                      print('Form data: $data');
                    });
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
```

## Additional information

For more details, visit the [repository](https://github.com/elnaddar/form_map).