import 'package:flutter/material.dart';
import 'package:multivendorplatformmobile/constants.dart';
import 'package:multivendorplatformmobile/theme.dart';

class SelectSizes extends StatefulWidget {
  final List<String> items;
  const SelectSizes({super.key, required this.items});

  @override
  State<StatefulWidget> createState() => _SelectSizesState();
}

class _SelectSizesState extends State<SelectSizes> {
  final List<String> _selectedItems = [];

  void editSizeSelection(String itemValue, bool isSelected) {
    setState(() {
      if (isSelected) {
        _selectedItems.add(itemValue);
      } else {
        _selectedItems.remove(itemValue);
      }
    });
    print(_selectedItems);
  }

  void _cancel() {
    Navigator.pop(context);
  }

// this function is called when the Submit button is tapped
  void _submit() {
    Navigator.pop(context, _selectedItems);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Topics'),
      content: SingleChildScrollView(
        child: Column(
          children: widget.items
              .map((item) => CheckboxListTile(
                checkColor: teal,
                checkboxShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),

                
                    value: _selectedItems.contains(item),
                    title: Text(sizeMapping[item]!),
                    onChanged: (isChecked) =>
                        editSizeSelection(item, isChecked!),
                  ))
              .toList(),
        ),
      ),
      actions: [

        ElevatedButton(
          onPressed: _submit,
          child: const Text('Submit'),
        ),
      ],
    );
  }
}

