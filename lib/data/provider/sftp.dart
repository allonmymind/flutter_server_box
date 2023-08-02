import 'dart:async';

import 'package:toolbox/core/provider_base.dart';

import '../model/sftp/req.dart';

class SftpProvider extends ProviderBase {
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
      item.worker.dispose();
    }
    super.dispose();
  }

  void cancel(int id) {
    final idx = _status.indexWhere((element) => element.id == id);
    _status[idx].worker.dispose();
    _status.removeAt(idx);
    notifyListeners();
  }
}
