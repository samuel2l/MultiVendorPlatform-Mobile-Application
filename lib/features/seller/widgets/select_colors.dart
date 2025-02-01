import 'package:flutter/material.dart';
import 'package:multivendorplatformmobile/constants.dart';
import 'package:multivendorplatformmobile/theme.dart';

class SelectColors extends StatefulWidget {
  final List<String> items;
  const SelectColors({super.key, required this.items});

  @override
  State<StatefulWidget> createState() => _SelectColorsState();
}

class _SelectColorsState extends State<SelectColors> {
  final List<String> _selectedItems = [];

  void editColorSelection(String itemValue, bool isSelected) {
    setState(() {
      if (isSelected) {
        _selectedItems.add(itemValue);
      } else {
        _selectedItems.remove(itemValue);
      }
    });
    print(_selectedItems);
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
                
                    value: _selectedItems.contains(item),
                    title: ListTile(
                      
                      hoverColor: colorDictionary[item],

                      title: Text(item),
                    ),
                    onChanged: (isChecked) =>
                        editColorSelection(item, isChecked!),
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

