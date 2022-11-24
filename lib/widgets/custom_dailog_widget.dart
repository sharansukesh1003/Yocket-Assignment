import 'package:flutter/material.dart';

class CustomDailogWidget {
  static showCustomDailog(
      BuildContext context, String dailogTitle, String dailogDescription) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(dailogTitle),
        content: Text(dailogDescription),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
