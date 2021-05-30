import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextFromField extends StatelessWidget {
  final String? initValue;
  final String? label;
  final IconData? prefixIconData;
  final Function(String?)? onChange;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;

  const MyTextFromField(
      {Key? key,
      this.initValue,
      this.label,
      this.prefixIconData,
      this.onChange,
      this.validator,
      this.inputFormatters,
      this.keyboardType})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initValue,
      validator: validator,
      onChanged: onChange,
      textInputAction: TextInputAction.next,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
          labelText: label,
          prefixIcon: prefixIconData != null ? Icon(prefixIconData) : null),
    );
  }
}

// onChanged: provider.onNameChange,
// initialValue: provider.name,
// decoration: InputDecoration(
// labelText: 'الاسم',
// prefixIcon: Icon(Icons.person_outline)),
