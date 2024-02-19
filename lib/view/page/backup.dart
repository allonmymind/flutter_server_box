import 'dart:io';

import 'package:computer/computer.dart';
import 'package:flutter/material.dart';
import 'package:toolbox/core/extension/context/common.dart';
import 'package:toolbox/core/extension/context/dialog.dart';
import 'package:toolbox/core/extension/context/locale.dart';
import 'package:toolbox/core/extension/context/snackbar.dart';
import 'package:toolbox/core/extension/datetime.dart';
import 'package:toolbox/core/utils/misc.dart';
import 'package:toolbox/core/utils/sync/icloud.dart';
import 'package:toolbox/core/utils/platform/base.dart';
import 'package:toolbox/core/utils/share.dart';
import 'package:toolbox/core/utils/sync/webdav.dart';
import 'package:toolbox/data/model/app/backup.dart';
import 'package:toolbox/data/res/logger.dart';
import 'package:toolbox/data/res/path.dart';
import 'package:toolbox/data/res/store.dart';
import 'package:toolbox/data/res/ui.dart';
import 'package:toolbox/view/widget/appbar.dart';
import 'package:toolbox/view/widget/expand_tile.dart';
import 'package:toolbox/view/widget/cardx.dart';
import 'package:toolbox/view/widget/input_field.dart';
import 'package:toolbox/view/widget/store_switch.dart';

class BackupPage extends StatelessWidget {
  BackupPage({super.key});

  final icloudLoading = ValueNotifier(false);
  final webdavLoading = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(l10n.backup, style: UIs.text18),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(17),
      children: [
        _buildTip(),
        if (isMacOS || isIOS) _buildIcloud(context),
        _buildWebdav(context),
        _buildFile(context),
        _buildClipboard(context),
      ],
    );
  }

  Widget _buildTip() {
    return CardX(
      child: ListTile(
        leading: const Icon(Icons.warning),
        title: Text(l10n.attention),
        subtitle: Text(l10n.backupTip, style: UIs.textGrey),
      ),
    );
  }

  Widget _buildFile(BuildContext context) {
    return CardX(
      child: ExpandTile(
        leading: const Icon(Icons.file_open),
        title: Text(l10n.files),
        initiallyExpanded: true,
        children: [
          ListTile(
            title: Text(l10n.backup),
            trailing: const Icon(Icons.save),
            onTap: () async {
              final path = await Backup.backup();

              /// Issue #188
              if (isWindows) {
                await Shares.text(await File(path).readAsString());
              } else {
                await Shares.files([path]);
              }
            },
          ),
          ListTile(
            trailing: const Icon(Icons.restore),
            title: Text(l10n.restore),
            onTap: () async => _onTapFileRestore(context),
          ),
        ],
      ),
    );
  }

  Widget _buildIcloud(BuildContext context) {
    return CardX(
      child: ListTile(
        leading: const Icon(Icons.cloud),
        title: const Text('iCloud'),
        trailing: StoreSwitch(
          prop: Stores.setting.icloudSync,
          validator: (p0) {
            if (p0 && Stores.setting.webdavSync.fetch()) {
              context.showSnackBar(l10n.autoBackupConflict);
              return false;
            }
            return true;
          },
          callback: (val) async {
            if (val) {
              icloudLoading.value = true;
              await ICloud.sync();
              icloudLoading.value = false;
            }
          },
        ),
      ),
    );
  }

  Widget _buildWebdav(BuildContext context) {
    return CardX(
      child: ExpandTile(
        leading: const Icon(Icons.storage),
        title: const Text('WebDAV'),
        initiallyExpanded: true,
        children: [
          ListTile(
            title: Text(l10n.setting),
            trailing: const Icon(Icons.settings),
            onTap: () async => _onTapWebdavSetting(context),
          ),
          ListTile(
            title: Text(l10n.auto),
            trailing: StoreSwitch(
              prop: Stores.setting.webdavSync,
              validator: (p0) {
                if (p0) {
                  if (Stores.setting.webdavUrl.fetch().isEmpty ||
                      Stores.setting.webdavUser.fetch().isEmpty ||
                      Stores.setting.webdavPwd.fetch().isEmpty) {
                    context.showSnackBar(l10n.webdavSettingEmpty);
                    return false;
                  }
                }
                if (Stores.setting.icloudSync.fetch()) {
                  context.showSnackBar(l10n.autoBackupConflict);
                  return false;
                }
                return true;
              },
              callback: (val) async {
                if (val) {
                  webdavLoading.value = true;
                  await Webdav.sync();
                  webdavLoading.value = false;
                }
              },
            ),
          ),
          ListTile(
            title: Text(l10n.manual),
            trailing: ListenableBuilder(
              listenable: webdavLoading,
              builder: (_, __) {
                if (webdavLoading.value) {
                  return UIs.centerSizedLoadingSmall;
                }
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextButton(
                      onPressed: () async => _onTapWebdavDl(context),
                      child: Text(l10n.restore),
                    ),
                    UIs.width7,
                    TextButton(
                      onPressed: () async => _onTapWebdavUp(context),
                      child: Text(l10n.backup),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClipboard(BuildContext context) {
    return CardX(
      child: ExpandTile(
        leading: const Icon(Icons.content_paste),
        title: Text(l10n.clipboard),
        children: [
          ListTile(
            title: Text(l10n.backup),
            trailing: const Icon(Icons.save),
            onTap: () async {
              final path = await Backup.backup();
              Shares.copy(await File(path).readAsString());
              context.showSnackBar(l10n.success);
            },
          ),
          ListTile(
            trailing: const Icon(Icons.restore),
            title: Text(l10n.restore),
            onTap: () async => _onTapClipboardRestore(context),
          ),
        ],
      ),
    );
  }

  Future<void> _onTapFileRestore(BuildContext context) async {
    final path = await pickOneFile();
    if (path == null) return;

    final file = File(path);
    if (!await file.exists()) {
      context.showSnackBar(l10n.fileNotExist(path));
      return;
    }

    final text = await file.readAsString();
    if (text.isEmpty) {
      context.showSnackBar(l10n.fieldMustNotEmpty);
      return;
    }

    try {
      context.showLoadingDialog();
      final backup =
          await Computer.shared.start(Backup.fromJsonString, text.trim());
      if (backupFormatVersion != backup.version) {
        context.showSnackBar(l10n.backupVersionNotMatch);
        return;
      }

      await context.showRoundDialog(
        title: Text(l10n.restore),
        child: Text(l10n.askContinue(
          '${l10n.restore} ${l10n.backup}(${backup.date})',
        )),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () async {
              await backup.restore(force: true);
              context.pop();
            },
            child: Text(l10n.ok),
          ),
        ],
      );
    } catch (e, trace) {
      Loggers.app.warning('Import backup failed', e, trace);
      context.showSnackBar(e.toString());
    } finally {
      context.pop();
    }
  }

  Future<void> _onTapWebdavDl(BuildContext context) async {
    webdavLoading.value = true;
    final files = await Webdav.list();
    if (files.isEmpty) {
      context.showSnackBar(l10n.dirEmpty);
      webdavLoading.value = false;
      return;
    }

    final fileName = await context.showRoundDialog<String>(
      title: Text(l10n.restore),
      child: SizedBox(
        width: 300,
        height: 300,
        child: ListView.builder(
          itemCount: files.length,
          itemBuilder: (_, index) {
            final file = files[index];
            return ListTile(
              title: Text(file),
              onTap: () => context.pop(file),
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: Text(l10n.cancel),
        ),
      ],
    );
    if (fileName == null) {
      webdavLoading.value = false;
      return;
    }

    final result = await Webdav.download(relativePath: fileName);
    if (result != null) {
      Loggers.app.warning('Download webdav backup failed: $result');
      webdavLoading.value = false;
      return;
    }
    final dlFile = await File('${await Paths.doc}/$fileName').readAsString();
    final dlBak = await Computer.shared.start(Backup.fromJsonString, dlFile);
    await dlBak.restore(force: true);
    webdavLoading.value = false;
  }

  Future<void> _onTapWebdavUp(BuildContext context) async {
    webdavLoading.value = true;
    final bakName = '${DateTime.now().numStr}-${Paths.bakName}';
    await Backup.backup(bakName);
    final uploadResult = await Webdav.upload(relativePath: bakName);
    if (uploadResult != null) {
      Loggers.app.warning('Upload webdav backup failed: $uploadResult');
    } else {
      Loggers.app.info('Upload webdav backup success');
    }
    webdavLoading.value = false;
  }

  Future<void> _onTapWebdavSetting(BuildContext context) async {
    final urlCtrl = TextEditingController(
      text: Stores.setting.webdavUrl.fetch(),
    );
    final userCtrl = TextEditingController(
      text: Stores.setting.webdavUser.fetch(),
    );
    final pwdCtrl = TextEditingController(
      text: Stores.setting.webdavPwd.fetch(),
    );
    final result = await context.showRoundDialog<bool>(
      title: const Text('WebDAV'),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Input(
            label: 'URL',
            hint: 'https://example.com/webdav/',
            controller: urlCtrl,
          ),
          Input(
            label: l10n.user,
            controller: userCtrl,
          ),
          Input(
            label: l10n.pwd,
            controller: pwdCtrl,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            context.pop(true);
          },
          child: Text(l10n.ok),
        ),
      ],
    );
    if (result == true) {
      final result =
          await Webdav.test(urlCtrl.text, userCtrl.text, pwdCtrl.text);
      if (result == null) {
        context.showSnackBar(l10n.success);
      } else {
        context.showSnackBar(result);
        return;
      }
      Webdav.changeClient(urlCtrl.text, userCtrl.text, pwdCtrl.text);
    }
  }

  void _onTapClipboardRestore(BuildContext context) async {
    final text = await Shares.paste();
    if (text == null || text.isEmpty) {
      context.showSnackBar(l10n.fieldMustNotEmpty);
      return;
    }

    try {
      context.showLoadingDialog();
      final backup =
          await Computer.shared.start(Backup.fromJsonString, text.trim());
      if (backupFormatVersion != backup.version) {
        context.showSnackBar(l10n.backupVersionNotMatch);
        return;
      }

      await context.showRoundDialog(
        title: Text(l10n.restore),
        child: Text(l10n.askContinue(
          '${l10n.restore} ${l10n.backup}(${backup.date})',
        )),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () async {
              await backup.restore(force: true);
              context.pop();
            },
            child: Text(l10n.ok),
          ),
        ],
      );
    } catch (e, trace) {
      Loggers.app.warning('Import backup failed', e, trace);
      context.showSnackBar(e.toString());
    } finally {
      context.pop();
    }
  }
}
