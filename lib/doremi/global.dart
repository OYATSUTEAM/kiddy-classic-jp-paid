import 'package:flutter/material.dart';

class GlobalData {
  static final GlobalData _instance = GlobalData._internal();
  factory GlobalData() {
    return _instance;
  }

  GlobalData._internal();

  String globalEnv = 'Do';
  String globalToHe = 'jaToon';
  double sWidth = 0.0;
  double sHeight = 0.0;
  setEnv(String env) async {
    globalEnv = env;
  }

  setS_Size(Size size) async {
    sWidth = size.width;
    sHeight = size.height;
  }

  setToHe(String toHeValue) async {
    globalToHe = toHeValue;
  }
}

// Create a single instance
final globalData = GlobalData();
