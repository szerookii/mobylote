import 'package:flutter/material.dart';

showDialogOk(BuildContext context, String title, String content) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

enum ToastType { error, success }
showToast(BuildContext context, String message, ToastType type) {
  Color color;
  switch (type) {
    case ToastType.error:
      color = Colors.red;
      break;
    case ToastType.success:
      color = Colors.green;
      break;
  }
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: color,
    ),
  );
}