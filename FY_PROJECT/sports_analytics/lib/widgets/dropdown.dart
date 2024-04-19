import 'package:flutter/material.dart';

import '../constants.dart';

// Class to manage a list of roles
class RoleList {
  static const List<String> roles = ['Athlete', 'Coach', 'Analyst'];
}

// Dropdown widget for selecting roles
class DropdownWidget extends StatefulWidget {
  final String selectedRole;
  final ValueChanged<String> onChanged;

  const DropdownWidget({
    Key? key,
    required this.selectedRole,
    required this.onChanged,
  }) : super(key: key);

  @override
  _DropdownWidgetState createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<DropdownWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.grey), // White border
        ),
        width: double.infinity,
        child: DropdownButton<String>(
          value: widget.selectedRole,
          onChanged: (String? newValue) {
            if (newValue != null) {
              // Save the selected role to a string
              widget.onChanged(newValue);
            }
          },
          underline: Container(), // Remove default underline
          dropdownColor: Colors.grey[850], // Dropdown background color
          style: kBodyText.copyWith(color: Colors.white), // Dropdown text style
          isExpanded: true,
          items: RoleList.roles.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  value,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}