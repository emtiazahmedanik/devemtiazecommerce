import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class CustomFlushbar {
  static void show(
    BuildContext context, {
    required String message,
    Color bgColor = Colors.black,
    IconData icon = Icons.info,
  }) {
    Flushbar(
      message: message,
      backgroundColor: bgColor,
      icon: Icon(icon, color: Colors.white),
      duration: const Duration(seconds: 3),
      borderRadius: BorderRadius.circular(12),
      margin: const EdgeInsets.all(12),
      flushbarStyle: FlushbarStyle.FLOATING,
      flushbarPosition: FlushbarPosition.TOP,
    ).show(context);
  }
}