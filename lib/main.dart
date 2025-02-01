import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:multivendorplatformmobile/features/auth/services/auth_service.dart';
import 'package:multivendorplatformmobile/features/common/widgets/splash.dart';
import 'package:multivendorplatformmobile/providers/user_provider.dart';
import 'package:multivendorplatformmobile/router.dart';
import 'package:multivendorplatformmobile/theme.dart';
import 'package:provider/provider.dart';

void main() {
  Stripe.publishableKey =
      "pk_test_51QUj13KvYI3VPzXg09FJihE8d7S6TZhH1snWgfyn7AcwjQkDX1UMYIyqkeBusWVT7VC8B4jSllmjVfYMmF9knYho00dQKl01Bvyour_publishable_key";
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Multivendor Platform',
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        onGenerateRoute: (settings) => generateRoute(settings),
        home: const Splash());
  }
}

class MultiSelect extends StatefulWidget {
  final List<String> items;
  const MultiSelect({super.key, required this.items});

  @override
  State<StatefulWidget> createState() => _MultiSelectState();
}

class _MultiSelectState extends State<MultiSelect> {
  final List<String> _selectedItems = [];

  void editItemSelection(String itemValue, bool isSelected) {
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
                  value: _selectedItems.contains(item),
                  title: Text(item),
                  onChanged: (isChecked) {

                    editItemSelection(item, isChecked!);
                  }))
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

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> _selectedItems = [];

  void _showMultiSelect() async {
    // a list of selectable items
    // these items can be hard-coded or dynamically fetched from a database/API
    final List<String> items = [
      'Flutter',
      'Node.js',
      'React Native',
      'Java',
      'Docker',
      'MySQL'
    ];

    List<String> ?selectedItems = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiSelect(items: items);
      },
    );
if(selectedItems!=null)
{
  setState(() {
      _selectedItems = selectedItems;
    });

}    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('dbestech'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // use this button to open the multi-select dialog
            ElevatedButton(
              onPressed: _showMultiSelect,
              child: const Text('Select Your Favorite Topics'),
            ),
            const Divider(
              height: 30,
            ),
            // display selected items
            Wrap(
              children: _selectedItems
                  .map((e) => Chip(
                        label: Text(e),
                      ))
                  .toList(),
            )
          ],
        ),
      ),
    );
  }
}
