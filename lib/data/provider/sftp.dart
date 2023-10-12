import 'dart:async';

import 'package:flutter/material.dart';

import '../model/sftp/req.dart';

class SftpProvider extends ChangeNotifier {
  final List<SftpReqStatus> _status = [];
  List<SftpReqStatus> get status => _status;

  SftpReqStatus? get(int id) {
    return _status.singleWhere((element) => element.id == id);
  }

  void add(SftpReq req, {Completer? completer}) {
    _status.add(SftpReqStatus(
      notifyListeners: notifyListeners,
      completer: completer,
      req: req,
    ));
  }

  @override
  void dispose() {
    for (final item in _status) {
      item.dispose();
    }
    super.dispose();
  }

  void cancel(int id) {
    final idx = _status.indexWhere((element) => element.id == id);
    _status[idx].dispose();
    _status.removeAt(idx);
    notifyListeners();
  }
}
