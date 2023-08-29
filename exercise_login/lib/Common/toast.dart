

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Toast {


  static showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}