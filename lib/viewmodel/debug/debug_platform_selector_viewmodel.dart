import 'package:flutter/material.dart';
import 'package:flutter_template/util/mixin/dispose_mixin.dart';
import 'package:flutter_template/viewmodel/back_navigator.dart';

class DebugPlatformSelectorViewModel with ChangeNotifier, DisposeMixin {
  DebugPlatformSelectorNavigator _navigator;

  Future<void> init(DebugPlatformSelectorNavigator navigator) async {
    _navigator = navigator;
  }

  void onBackClicked() => _navigator.goBack<void>();
}

abstract class DebugPlatformSelectorNavigator implements BackNavigator {}
