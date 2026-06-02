import 'package:flutter/material.dart';

class CustomDialog {
  static Future<void> showResetDialog(BuildContext context, VoidCallback onReset) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Reset All Data'),
          content: const Text('Are you sure you want to reset all courses? This action cannot be undone.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                onReset();
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Reset'),
            ),
          ],
        );
      },
    );
  }
  
  static Future<void> showSaveDialog(BuildContext context, VoidCallback onSave) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Save Calculation'),
          content: const Text('Do you want to save this GPA calculation to history?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                onSave();
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }
}
