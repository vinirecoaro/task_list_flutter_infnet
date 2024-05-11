import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  const InputField(
      {super.key,
      this.label = "label name",
      this.enabled = true,
      this.initialText = '',
      this.controller});

  final String label;
  final bool enabled;
  final String initialText;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: TextFormField(
        initialValue: initialText,
        enabled: enabled,
        controller: controller,
        decoration: InputDecoration(
          label: Text(label),
          enabled: false,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Colors.grey.withOpacity(.4),
              width: 1.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Colors.indigo.withOpacity(.4),
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}
