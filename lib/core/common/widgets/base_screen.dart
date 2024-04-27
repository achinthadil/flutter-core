import 'package:flutter/material.dart';

class BaseScreen extends StatelessWidget {
  final String? screenTitle;

  const BaseScreen({
    this.screenTitle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(screenTitle ?? 'Base Screen'),
      ),
    );
  }
}
