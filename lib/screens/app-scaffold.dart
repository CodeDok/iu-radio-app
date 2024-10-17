import 'package:flutter/material.dart';

class AppScaffold extends StatefulWidget {
  const AppScaffold({super.key, required this.headerTitle, required this.body});

  final String headerTitle;
  final Widget body;

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      appBar: AppBar(
        centerTitle: true,
        title: Chip(
          label: Text(
            widget.headerTitle,
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
          side: BorderSide.none,
        ),
      ),
      body: SingleChildScrollView(child: widget.body),
    );
  }
}
