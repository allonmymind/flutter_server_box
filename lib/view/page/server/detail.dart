import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toolbox/core/extension/context/common.dart';
import 'package:toolbox/core/extension/context/locale.dart';
import 'package:toolbox/core/extension/order.dart';
import 'package:toolbox/data/model/server/cpu.dart';
import 'package:toolbox/data/model/server/net_speed.dart';
import 'package:toolbox/data/model/server/server_private_info.dart';
import 'package:toolbox/data/model/server/system.dart';
import 'package:toolbox/data/res/store.dart';
import 'package:toolbox/view/widget/server_func_btns.dart';
import 'package:toolbox/view/widget/value_notifier.dart';

import '../../../core/extension/numx.dart';
import '../../../core/route.dart';
import '../../../data/model/server/server.dart';
import '../../../data/model/server/server_status.dart';
import '../../../data/provider/server.dart';
import '../../../data/res/color.dart';
import '../../../data/res/default.dart';
import '../../../data/res/ui.dart';
import '../../widget/custom_appbar.dart';
import '../../widget/round_rect_card.dart';

class ServerDetailPage extends StatefulWidget {
  const ServerDetailPage({Key? key, required this.spi}) : super(key: key);

  final ServerPrivateInfo spi;

  @override
  _ServerDetailPageState createState() => _ServerDetailPageState();
}

class _ServerDetailPageState extends State<ServerDetailPage>
    with SingleTickerProviderStateMixin {
  late MediaQueryData _media;
  final Order<String> _cardsOrder = [];

  late final _textFactor = Stores.setting.textFactor.fetch();

  late final _cardBuildMap = Map.fromIterables(
    Defaults.detailCardOrder,
    [
      _buildUpTimeAndSys,
      _buildCPUView,
      _buildMemView,
      _buildSwapView,
      _buildDiskView,
      _buildNetView,
      _buildTemperature,
    ],
  );

  final _netSortType = ValueNotifier(_NetSortType.device);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _media = MediaQuery.of(context);
  }

  @override
  void initState() {
    super.initState();
    _cardsOrder.addAll(Stores.setting.detailCardOrder.fetch());
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ServerProvider>(builder: (_, provider, __) {
      final s = widget.spi.server;
      if (s == null) {
        return Scaffold(
          body: Center(
            child: Text(l10n.noClient),
          ),
        );
      }
      return _buildMainPage(s);
    });
  }

  Widget _buildMainPage(Server si) {
    final buildFuncs = !Stores.setting.moveOutServerTabFuncBtns.fetch();
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(si.spi.name, style: UIs.textSize18),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              final delete = await AppRoute.serverEdit(spi: si.spi).go(context);
              if (delete == true) {
                context.pop();
              }
            },
          )
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.only(
          left: 13,
          right: 13,
          bottom: _media.padding.bottom + 77,
        ),
        itemCount: buildFuncs ? _cardsOrder.length + 1 : _cardsOrder.length,
        itemBuilder: (context, index) {
          if (index == 0 && buildFuncs) {
            return ServerFuncBtns(spi: widget.spi, iconSize: 19);
          }
          if (buildFuncs) index--;
          return _cardBuildMap[_cardsOrder[index]]?.call(si.status);
        },
      ),
    );
  }

  Widget _buildCPUView(ServerStatus ss) {
    final percent = ss.cpu.usedPercent(coreIdx: 0).toInt();
    final details = [
      _buildDetailPercent(ss.cpu.user, 'user'),
      UIs.width13,
      _buildDetailPercent(ss.cpu.idle, 'idle')
    ];
    if (ss.system == SystemType.linux) {
      details.addAll([
        UIs.width13,
        _buildDetailPercent(ss.cpu.sys, 'sys'),
        UIs.width13,
        _buildDetailPercent(ss.cpu.iowait, 'io'),
      ]);
    }

    return RoundRectCard(
      Padding(
        padding: UIs.roundRectCardPadding,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildAnimatedText(
                ValueKey(percent),
                '$percent%',
                UIs.textSize27,
              ),
              Row(
                children: details,
              )
            ],
          ),
          UIs.height13,
          _buildCPUProgress(ss.cpu)
        ]),
      ),
    );
  }

  Widget _buildDetailPercent(double percent, String timeType) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          '${percent.toStringAsFixed(1)}%',
          style: const TextStyle(fontSize: 13),
          textScaleFactor: _textFactor,
        ),
        Text(
          timeType,
          style: const TextStyle(fontSize: 10, color: Colors.grey),
          textScaleFactor: _textFactor,
        ),
      ],
    );
  }

  Widget _buildCPUProgress(Cpus cs) {
    final children = <Widget>[];
    for (var i = 0; i < cs.coresCount; i++) {
      if (i == 0) continue;
      children.add(
        Padding(
          padding: const EdgeInsets.all(2),
          child: _buildProgress(cs.usedPercent(coreIdx: i)),
        ),
      );
    }
    return Column(children: children);
  }

  Widget _buildProgress(double percent) {
    if (percent > 100) percent = 100;
    final percentWithinOne = percent / 100;
    return LinearProgressIndicator(
      value: percentWithinOne,
      minHeight: 7,
      backgroundColor: DynamicColors.progress.resolve(context),
      color: primaryColor,
    );
  }

  Widget _buildUpTimeAndSys(ServerStatus ss) {
    return RoundRectCard(
      Padding(
        padding: UIs.roundRectCardPadding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              ss.sysVer,
              style: UIs.textSize11,
              textScaleFactor: _textFactor,
            ),
            Text(
              ss.uptime,
              style: UIs.textSize11,
              textScaleFactor: _textFactor,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMemView(ServerStatus ss) {
    final free = ss.mem.free / ss.mem.total * 100;
    final avail = ss.mem.availPercent * 100;
    final used = ss.mem.usedPercent * 100;
    final usedStr = used.toStringAsFixed(0);

    return RoundRectCard(
      Padding(
        padding: UIs.roundRectCardPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    _buildAnimatedText(
                      ValueKey(usedStr),
                      '$usedStr%',
                      UIs.textSize27,
                    ),
                    UIs.width7,
                    Text(
                      'of ${(ss.mem.total * 1024).convertBytes}',
                      style: UIs.textSize13Grey,
                    )
                  ],
                ),
                Row(
                  children: [
                    _buildDetailPercent(free, 'free'),
                    UIs.width13,
                    _buildDetailPercent(avail, 'avail'),
                  ],
                ),
              ],
            ),
            UIs.height13,
            _buildProgress(used)
          ],
        ),
      ),
    );
  }

  Widget _buildSwapView(ServerStatus ss) {
    if (ss.swap.total == 0) return UIs.placeholder;
    final used = ss.swap.usedPercent * 100;
    final cached = ss.swap.cached / ss.swap.total * 100;
    return RoundRectCard(
      Padding(
        padding: UIs.roundRectCardPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text('${used.toStringAsFixed(0)}%', style: UIs.textSize27),
                    UIs.width7,
                    Text(
                      'of ${(ss.swap.total * 1024).convertBytes} ',
                      style: UIs.textSize13Grey,
                    )
                  ],
                ),
                _buildDetailPercent(cached, 'cached'),
              ],
            ),
            UIs.height13,
            _buildProgress(used)
          ],
        ),
      ),
    );
  }

  Widget _buildDiskView(ServerStatus ss) {
    final disk = ss.disk;
    disk.removeWhere((e) {
      for (final ingorePath in Stores.setting.diskIgnorePath.fetch()) {
        if (e.path.startsWith(ingorePath)) return true;
      }
      return false;
    });
    final children = disk
        .map((disk) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${disk.usedPercent}% of ${disk.size}',
                        style: UIs.textSize11,
                        textScaleFactor: _textFactor,
                      ),
                      Text(
                        disk.path,
                        style: UIs.textSize11,
                        textScaleFactor: _textFactor,
                      )
                    ],
                  ),
                  _buildProgress(disk.usedPercent.toDouble())
                ],
              ),
            ))
        .toList();
    return RoundRectCard(
      Padding(
        padding: UIs.roundRectCardPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: children,
        ),
      ),
    );
  }

  Widget _buildNetView(ServerStatus ss) {
    return RoundRectCard(
      Padding(
        padding: UIs.roundRectCardPadding,
        child: ValueBuilder(
          listenable: _netSortType,
          build: () {
            final ns = ss.netSpeed;
            final children = <Widget>[
              _buildNetSpeedTop(),
              const Divider(
                height: 7,
              )
            ];
            if (ns.devices.isEmpty) {
              children.add(Center(
                child: Text(
                  l10n.noInterface,
                  style: const TextStyle(color: Colors.grey, fontSize: 13),
                ),
              ));
            } else {
              final devices = ns.devices;
              devices.sort(_netSortType.value.getSortFunc(ns));
              children.addAll(devices.map((e) => _buildNetSpeedItem(ns, e)));
            }
            return Column(
              children: children,
            );
          },
        ),
      ),
    );
  }

  Widget _buildNetSpeedTop() {
    const icon = Icon(Icons.arrow_downward, size: 13);
    return Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            child: _netSortType.value.isDevice
                ? const Row(
                    children: [
                      Text('Iface'),
                      icon,
                    ],
                  )
                : const Text('Iface'),
            onTap: () => _netSortType.value = _NetSortType.device,
          ),
          GestureDetector(
            child: _netSortType.value.isIn
                ? const Row(
                    children: [
                      Text('Recv'),
                      icon,
                    ],
                  )
                : const Text('Recv'),
            onTap: () => _netSortType.value = _NetSortType.recv,
          ),
          GestureDetector(
            child: _netSortType.value.isOut
                ? const Row(
                    children: [
                      Text('Trans'),
                      icon,
                    ],
                  )
                : const Text('Trans'),
            onTap: () => _netSortType.value = _NetSortType.trans,
          ),
        ],
      ),
    );
  }

  Widget _buildNetSpeedItem(NetSpeed ns, String device) {
    final width = (_media.size.width - 34 - 34) / 3;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: width,
            child: Text(
              device,
              style: UIs.textSize11,
              textScaleFactor: _textFactor,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(
            width: width,
            child: Text(
              '${ns.speedIn(device: device)} | ${ns.sizeIn(device: device)}',
              style: UIs.textSize11,
              textAlign: TextAlign.center,
              textScaleFactor: 0.87 * _textFactor,
            ),
          ),
          SizedBox(
            width: width,
            child: Text(
              '${ns.speedOut(device: device)} | ${ns.sizeOut(device: device)}',
              style: UIs.textSize11,
              textAlign: TextAlign.right,
              textScaleFactor: 0.87 * _textFactor,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTemperature(ServerStatus ss) {
    final temps = ss.temps;
    if (temps.isEmpty) {
      return UIs.placeholder;
    }
    final List<Widget> children = [
      const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.device_hub, size: 17),
          Icon(Icons.ac_unit, size: 17),
        ],
      ),
      const Padding(
        padding: EdgeInsets.symmetric(vertical: 3),
        child: Divider(height: 7),
      ),
    ];
    children.addAll(temps.devices.map((key) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              key,
              style: UIs.textSize11,
              textScaleFactor: _textFactor,
            ),
            Text(
              '${temps.get(key)}°C',
              style: UIs.textSize11,
              textScaleFactor: _textFactor,
            ),
          ],
        )));
    return RoundRectCard(
      Padding(
        padding: UIs.roundRectCardPadding,
        child: Column(children: children),
      ),
    );
  }

  Widget _buildAnimatedText(Key key, String text, TextStyle style) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 277),
      child: Text(
        key: key,
        text,
        style: style,
        textScaleFactor: _textFactor,
      ),
      transitionBuilder: (child, animation) => FadeTransition(
        opacity: animation,
        child: child,
      ),
    );
  }
}

enum _NetSortType {
  device,
  trans,
  recv,
  ;

  bool get isDevice => this == _NetSortType.device;
  bool get isIn => this == _NetSortType.recv;
  bool get isOut => this == _NetSortType.trans;

  int Function(String, String) getSortFunc(NetSpeed ns) {
    switch (this) {
      case _NetSortType.device:
        return (b, a) => a.compareTo(b);
      case _NetSortType.recv:
        return (b, a) => ns
            .speedInBytes(ns.deviceIdx(a))
            .compareTo(ns.speedInBytes(ns.deviceIdx(b)));
      case _NetSortType.trans:
        return (b, a) => ns
            .speedOutBytes(ns.deviceIdx(a))
            .compareTo(ns.speedOutBytes(ns.deviceIdx(b)));
    }
  }
}
