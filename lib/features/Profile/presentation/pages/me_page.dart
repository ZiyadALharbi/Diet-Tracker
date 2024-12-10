import 'package:flutter/material.dart';
import 'edit_dialog.dart';

class MePage extends StatefulWidget {
  const MePage({super.key});

  @override
  State<MePage> createState() => _MePageState();
}

class _MePageState extends State<MePage> {
  bool updateDailyNutrients = true; // Checkbox state

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Me'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          buildEditableField(context, 'Goal', 'Gain weight'),
          buildEditableField(context, 'Age', '17 years'),
          buildEditableField(context, 'Height', '184 cm'),
          buildEditableField(context, 'Weight', '88 kg'),
          buildEditableField(context, 'Gender', 'Male'),
          buildEditableField(context, 'Lifestyle', 'Active'),
          const SizedBox(height: 24),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              showSaveDialog(context);
            },
            child: const Text(
              'Save',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          Center(
              child: Text("You can EDIT the values by CLICKING on them",
                  style: TextStyle(color: Colors.green[800], fontSize: 16))),
        ],
      ),
    );
  }

  Widget buildEditableField(BuildContext context, String title, String value) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
      title: Text(title),
      trailing: GestureDetector(
        onTap: () {
          showEditDialog(context, title, value);
        },
        child: Text(
          value,
          style: const TextStyle(color: Colors.blue),
        ),
      ),
    );
  }

  void showSaveDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Save'),
          content: Row(
            children: [
              Checkbox(
                value: updateDailyNutrients,
                onChanged: (bool? value) {
                  setState(() {
                    updateDailyNutrients = value ?? true;
                  });
                  Navigator.of(context).pop(); // Close the dialog temporarily
                  showSaveDialog(
                      context); // Reopen the dialog with updated state
                },
              ),
              const Expanded(
                child: Text('Update daily nutrients'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Handle the save action
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
