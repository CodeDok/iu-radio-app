import 'package:flutter/material.dart';

class ErrorAlertDialog extends StatelessWidget {
  const ErrorAlertDialog({super.key, required this.errorMessage, required this.heading});

  final String errorMessage;
  final String heading;


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: Icon(Icons.bug_report, color: Colors.red),
      title: Text(heading),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(errorMessage),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Ok'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}