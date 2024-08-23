import 'package:atlas_fitness/components/profile_text_field.dart';
import 'package:flutter/material.dart';

class ProfileOptionsField extends StatelessWidget {
  const ProfileOptionsField({
    Key? key,
    required this.unitController,
    required this.hintText,
    required this.enabled,
    required this.valueController,
    required this.placeholder,
    this.options,
  }) : super(key: key);

  final TextEditingController unitController;
  final TextEditingController valueController;
  final String hintText;
  final bool enabled;
  final List<String>? options;
  final String placeholder;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: ProfileTextField(
              controller: valueController,
              hintText: hintText,
              obscureText: false,
              enabled: unitController.text.isNotEmpty && enabled,
              isNumeric: true,
              placeholder: placeholder,
            ),
          ),
          SizedBox(width: 10), // Add space between the TextField and Dropdown
          Expanded(
            flex: 2,
            child: DropdownButtonFormField<String>(
              dropdownColor: Theme.of(context).colorScheme.secondary,
              value: unitController.text.isEmpty ? null : unitController.text,
              items: options!.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value,
                  style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary)),
                );
              }).toList(),
              onChanged: enabled
                  ? (String? newValue) {
                      unitController.text = newValue ?? '';
                    }
                  : null,
              decoration: InputDecoration(
                hintText: "unit",
                hintStyle: TextStyle(
                color:Theme.of(context).colorScheme.secondary,
              ),
                enabledBorder: OutlineInputBorder(
                    borderSide:BorderSide(color: Theme.of(context).colorScheme.secondary) 
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide:BorderSide(color: Theme.of(context).colorScheme.secondary) 
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
