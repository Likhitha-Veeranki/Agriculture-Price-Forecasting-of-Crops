import 'package:flutter/material.dart';

class AppDropdown extends StatelessWidget {
  final String label;
  final List<String> items;
  final String? value;
  final ValueChanged<String?> onChanged;
  final String? helperText;

  const AppDropdown({
    super.key,
    required this.label,
    required this.items,
    required this.value,
    required this.onChanged,
    this.helperText,
  });

  @override
  Widget build(BuildContext context) {
    final safeValue = items.contains(value) ? value : null;
    final isEnabled = items.isNotEmpty;

    return DropdownButtonFormField<String>(
      value: safeValue,
      dropdownColor: Colors.white,
      style: const TextStyle(color: Colors.black),
      hint: Text(
        isEnabled ? "Select $label" : "Loading $label...",
        style: const TextStyle(color: Colors.black),
      ),
      decoration: InputDecoration(
        label: Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          color: Colors.white,
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),

        helperText: helperText,
        filled: true,
        fillColor: Colors.white,
        border: const OutlineInputBorder(),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black54),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
      items: isEnabled
          ? items
              .map(
                (item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
              )
              .toList()
          : null,
      onChanged: isEnabled ? onChanged : null,
    );
  }
}
