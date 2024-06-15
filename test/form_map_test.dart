import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:form_map/form_map.dart';

enum TestFields { name, email }

void main() {
  group('FormMap', () {
    test('should store and retrieve values', () {
      final formMap = FormMap<TestFields>();
      formMap[TestFields.name] = 'John Doe';
      formMap[TestFields.email] = 'john.doe@example.com';

      expect(formMap[TestFields.name], 'John Doe');
      expect(formMap[TestFields.email], 'john.doe@example.com');
    });

    test('should handle custom handlers', () {
      final formMap = FormMap<TestFields>();
      formMap.handelers[TestFields.name] = (value) => value.toUpperCase();

      formMap[TestFields.name] = 'John Doe';

      expect(formMap[TestFields.name], 'JOHN DOE');
    });

    test('should create from data map', () {
      final dataMap = {'name': 'John Doe', 'email': 'john.doe@example.com'};
      final formMap = FormMap<TestFields>.fromDataMap(
        enumValues: TestFields.values,
        dataMap: dataMap,
      );

      expect(formMap[TestFields.name], 'John Doe');
      expect(formMap[TestFields.email], 'john.doe@example.com');
    });

    test(
        'should throw error if no name in data map and throwErrorIfNoName is true',
        () {
      final dataMap = {'unknown': 'value'};
      expect(
        () => FormMap<TestFields>.fromDataMap(
          enumValues: TestFields.values,
          dataMap: dataMap,
          throwErrorIfNoName: true,
        ),
        throwsArgumentError,
      );
    });

    test('should convert to data map', () {
      final formMap = FormMap<TestFields>();
      formMap[TestFields.name] = 'John Doe';
      formMap[TestFields.email] = 'john.doe@example.com';

      final dataMap = formMap.dataMap;

      expect(dataMap['name'], 'John Doe');
      expect(dataMap['email'], 'john.doe@example.com');
    });

    testWidgets('should submit valid form', (WidgetTester tester) async {
      final formKey = GlobalKey<FormState>();
      final formMap = FormMap<TestFields>(key: formKey);
      late Map<String, dynamic> submittedData;

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  initialValue: 'John Doe',
                  onSaved: (value) => formMap[TestFields.name] = value,
                ),
                TextFormField(
                  initialValue: 'john.doe@example.com',
                  onSaved: (value) => formMap[TestFields.email] = value,
                ),
                ElevatedButton(
                  onPressed: () {
                    formMap.submit((data) {
                      submittedData = data;
                    });
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ));

      await tester.tap(find.text('Submit'));
      await tester.pump();

      expect(submittedData['name'], 'John Doe');
      expect(submittedData['email'], 'john.doe@example.com');
    });
  });
}
