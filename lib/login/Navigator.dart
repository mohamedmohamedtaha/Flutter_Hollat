import 'package:flutter/material.dart';

void navigatorControllerReplacement(BuildContext context, Widget page) {
  Navigator.pushReplacement(context, MaterialPageRoute(
    builder: (context) {
      return page;
    },
  ));
}

void navigatorControllerPush(BuildContext context, Widget page) {
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return page;
  }));
}

void navigatorControllerPup(BuildContext context) {
  Navigator.pop(context);
}

void navigatorControllerPushAndRemoveUntil(
    BuildContext context, Widget page, bool predicate) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) {
      return page;
    }),
    (route) {
      return predicate;
    },
  );
}
