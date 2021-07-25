import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

Future<void> normalDialog(BuildContext context, String message) async {
  showDialog(
    context: context,
    builder: (context) => SimpleDialog(
      title: Text(message),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FlatButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'OK',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

class MyDialog {
  Future<Null> alertLocationService(
      BuildContext context, String title, String message) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: ListTile(
          title: Text(
            title,
            style: TextStyle(color: Colors.deepOrange),
          ),
          subtitle: Text(
            message,
            style: TextStyle(color: Colors.deepOrange[300]),
          ),
        ),
        actions: [
          FlatButton(
            onPressed: () async {
              // Navigator.pop(context);
              await Geolocator.openLocationSettings();
              exit(0);
            },
            child: Text(
              'OK',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}