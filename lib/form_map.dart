library form_map;

import 'package:flutter/material.dart';

class FormMap<T extends Enum> {
  final GlobalKey<FormState> key;
  final Map<T, dynamic> _fromData = {};
  final Map<T, dynamic Function(String value)> handelers = {};
  FormMap({GlobalKey<FormState>? key}) : key = key ?? GlobalKey<FormState>();

  dynamic operator [](T item) => _fromData[item];
  void operator []=(T item, String? value) {
    if (handelers[item] == null || value == null) {
      _fromData[item] = value;
    } else {
      _fromData[item] = handelers[item]!(value);
    }
  }

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

  Map<String, dynamic> get dataMap {
    final Map<String, dynamic> data = {};
    for (final entry in _fromData.entries) {
      final String entryKey = entry.key.name;
      data[entryKey] = entry.value;
    }
    return data;
  }

  void submit(void Function(Map<String, dynamic> data) onSubmit) {
    if (key.currentState!.validate()) {
      key.currentState!.save();
      onSubmit(dataMap);
    }
  }
}
