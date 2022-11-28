import 'package:flutter/material.dart';

class SnackBarMessage {

  void showSuccessSnackBar({required BuildContext context,required String msg}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        content: Text(
          msg,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void showErrorSnackBar({required BuildContext context,required String msg}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text(
          msg,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}