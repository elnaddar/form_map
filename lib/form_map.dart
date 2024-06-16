library form_map;

import 'package:flutter/material.dart';

/// A generic class for managing form state and data based on enum values.
class FormMap<T extends Enum> {
  /// The [GlobalKey] for the form state.
  final GlobalKey<FormState> key;

  /// Internal storage for form data.
  final Map<T, dynamic> _fromData = {};

  /// Handlers for processing form input values.
  final Map<T, dynamic Function(String value)> handelers = {};

  /// Creates a [FormMap] with an optional [GlobalKey].
  FormMap({GlobalKey<FormState>? key}) : key = key ?? GlobalKey<FormState>();

  /// Retrieves the form data for a given enum key.
  dynamic operator [](T item) => _fromData[item];

  /// Sets the form data for a given enum key, processing the value if a handler is defined.
  void operator []=(T item, String? value) {
    if (handelers[item] == null || value == null) {
      _fromData[item] = value;
    } else {
      _fromData[item] = handelers[item]!(value);
    }
  }

  /// Creates a [FormMap] from a data map and a list of enum values.
  ///
  /// If [throwErrorIfNoName] is true, an error is thrown if a name in [dataMap] does not match an enum value.
  factory FormMap.fromDataMap({
    GlobalKey<FormState>? key,
    required Iterable<T> enumValues,
    required Map<String, dynamic> dataMap,
    bool throwErrorIfNoName = false,
  }) {
    final obj = FormMap<T>(key: key);
    final enumMap = enumValues.asNameMap();

    for (final entry in dataMap.entries) {
      if (enumMap[entry.key] != null) {
        final T entryKey = enumMap[entry.key]!;
        obj[entryKey] = entry.value;
      } else if (throwErrorIfNoName) {
        throw ArgumentError.value(
            entry.key, "name", "No enum value with that name");
      }
    }
    return obj;
  }

  /// Retrieves a map representation of the form data with string keys.
  Map<String, dynamic> get dataMap {
    final Map<String, dynamic> data = {};
    for (final entry in _fromData.entries) {
      final String entryKey = entry.key.name;
      data[entryKey] = entry.value;
    }
    return data;
  }

  /// Submits the form data, calling [onSubmit] with the data map.
  ///
  /// If [saveBeforeValidate] is true, the form state is saved before validation.
  void submit(
    void Function(Map<String, dynamic> data) onSubmit, {
    bool saveBeforeValidate = false,
  }) {
    if (saveBeforeValidate) {
      key.currentState!.save();
    }
    if (key.currentState!.validate()) {
      key.currentState!.save();
      onSubmit(dataMap);
    }
  }
}
