import 'package:atlas_fitness/components/my_register_text_field.dart';
import 'package:flutter/material.dart';

class MyOptionsField extends StatelessWidget {
  const MyOptionsField({
    Key? key,
    required this.unitController,
    required this.hintText,
    required this.enabled,
    required this.valueController,
    this.options,
  }) : super(key: key);

  final TextEditingController unitController;
  final TextEditingController valueController;
  final String hintText;
  final bool enabled;
  final List<String>? options;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: MyRegisterTextField(
              controller: valueController,
              hintText: hintText,
              obscureText: false,
              enabled: unitController.text.isNotEmpty && enabled,
              isNumeric: true,
            ),
          ),
          SizedBox(width: 10), // Add space between the TextField and Dropdown
          Expanded(
            flex: 2,
            child: DropdownButtonFormField<String>(
              dropdownColor: Theme.of(context).colorScheme.primary,
              value: unitController.text.isEmpty ? null : unitController.text,
              items: options!.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value,
                  style: TextStyle(color: Theme.of(context).colorScheme.surface)),
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
                color:Theme.of(context).colorScheme.surface,
              ),
                enabledBorder: OutlineInputBorder(
                    borderSide:BorderSide(color: Theme.of(context).colorScheme.tertiary) 
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide:BorderSide(color: Theme.of(context).colorScheme.tertiary) 
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
