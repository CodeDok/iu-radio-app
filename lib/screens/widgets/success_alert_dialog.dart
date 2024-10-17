import 'package:flutter/material.dart';

class SuccessAlertDialog extends StatelessWidget {
  final String title;

  const SuccessAlertDialog({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: Icon(Icons.star, color: Colors.yellow, size: 80),
      surfaceTintColor: Theme.of(context).colorScheme.secondary,
      title: Text(title),
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
