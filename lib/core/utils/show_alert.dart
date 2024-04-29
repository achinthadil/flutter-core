import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Future<void> showAlertDialog({
  required BuildContext context,
  required String title,
  required String content,
}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          title ?? '',
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.w500),
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(content ?? ''),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Dismiss'),
            onPressed: () {
              context.pop();
            },
          ),
        ],
      );
    },
  );
}
