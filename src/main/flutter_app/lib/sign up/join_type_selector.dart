import 'package:flutter/material.dart';
import '../app_theme.dart';

class JoinTypeSelector extends StatefulWidget {
  final Function(String) onChanged;
  const JoinTypeSelector({super.key, required this.onChanged});

  @override
  State<JoinTypeSelector> createState() => _JoinTypeSelectorState();
}

class _JoinTypeSelectorState extends State<JoinTypeSelector> {
  String? selectedType;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              backgroundColor: selectedType == '화주' ? Colors.white : Colors.transparent,
              foregroundColor: selectedType == '화주' ? AppColors.point : Colors.white,
              side: const BorderSide(color: Colors.white),
              textStyle: const TextStyle(fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              setState(() {
                selectedType = '화주';
              });
              widget.onChanged('화주');
            },
            child: const Text('화주'),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              backgroundColor: selectedType == '차주' ? Colors.white : Colors.transparent,
              foregroundColor: selectedType == '차주' ? AppColors.point : Colors.white,
              side: const BorderSide(color: Colors.white),
              textStyle: const TextStyle(fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              setState(() {
                selectedType = '차주';
              });
              widget.onChanged('차주');
            },
            child: const Text('차주'),
          ),
        ),
      ],
    );
  }
}

