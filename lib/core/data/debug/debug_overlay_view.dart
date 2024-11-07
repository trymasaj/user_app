import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:masaj/core/data/device/app_info_service.dart';
import 'package:masaj/core/data/di/di_wrapper.dart';
import 'package:masaj/core/data/logger/abs_logger.dart';
import 'package:masaj/core/data/logger/log_saver.dart';
import 'package:masaj/core/helpers/overlay_helper.dart';
import 'package:masaj/main.dart';
import 'package:share_plus/share_plus.dart';

class DebugLogDialog extends StatefulWidget {
  final String title;
  final List<String> logList;

  const DebugLogDialog({super.key, required this.logList, required this.title});

  @override
  State<DebugLogDialog> createState() => _DebugLogDialogState();

  static void show(BuildContext context, {required String title, required List<String> log}) {
    OverlayHelper.showOverlay(context, widget: DebugLogDialog(logList: log, title: title));
  }
}

class _DebugLogDialogState extends State<DebugLogDialog> {
  int expandedIndex = -1;

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Color.fromRGBO(240, 240, 250, 1),
      elevation: 5,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 600),
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.title,
              style: const TextStyle(color: Colors.blueGrey, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Flexible(
              child: Container(
                  constraints: const BoxConstraints(maxHeight: 500),
                  padding: const EdgeInsets.all(10),
                  child: ListView.separated(
                    separatorBuilder: (context, i) => Container(
                      height: 1,
                      color: Colors.black26,
                      margin: const EdgeInsets.symmetric(vertical: 5),
                    ),
                    itemCount: widget.logList.length,
                    itemBuilder: (context, index) => ExpandableTextView(
                        isExpanded: index == expandedIndex,
                        text: widget.logList[index],
                        expand: () => setState(() {
                              expandedIndex = expandedIndex == index ? -1 : index;
                            })),
                  )),
            ),
            //> buttons
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildBtn(
                    onPressed: copy,
                    text: 'Copy',
                  ),
                  Container(
                    width: 10,
                  ),
                  _buildBtn(
                    onPressed: share,
                    text: 'Share',
                  ),
                  Container(
                    width: 10,
                  ),
                  _buildBtn(
                    onPressed: clear,
                    text: 'Clear',
                  ),
                  Container(
                    width: 10,
                  ),
                  _buildBtn(
                    onPressed: close,
                    text: 'Close',
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBtn({required String text, required VoidCallback onPressed}) {
    return CupertinoButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey),
      ),
    );
  }

  Future<void> copy() async {
    await LogSaver().copyToClipboard(widget.logList.join('\r\n---\r\n'));
  }

  void share() {
    Share.share(widget.logList.join('\r\n---\r\n'));
  }

  void close() {
    OverlayHelper.hideOverlay();
  }

  void clear() {
    DI.find<AbsLogger>().clearSavedLogs();
  }
}

class LogsBtnOverlay extends StatelessWidget {
  const LogsBtnOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      alignment: const AlignmentDirectional(1, 0.8),
      child: Opacity(
          opacity: 0.5,
          child: TextButton(
            style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.grey), foregroundColor: WidgetStatePropertyAll(Colors.white)),
            child: const Text('Show\n Log '),
            onPressed: () {
              var logList = DI.find<AbsLogger>().getSavedLogs();
              if (logList.isEmpty) {
                OverlayHelper.showInfoToast(context, 'Log is empty');
                return;
              }
              OverlayHelper.showOverlay(context, widget: DebugLogDialog(logList: logList, title: 'Log'));
            },
          )),
    );
  }
}

abstract class DebugUtils {
  static void showLoggerOverlay(BuildContext context) {
    if (BUILD_TYPE != BuildType.test) return;
    //
    OverlayHelper.showOverlay(context, widget: const LogsBtnOverlay(), layerId: 6);
  }
}

class ExpandableTextView extends StatelessWidget {
  final String text;
  final bool isExpanded;
  final VoidCallback expand;

  const ExpandableTextView({super.key, required this.text, this.isExpanded = false, required this.expand});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SmallBtn(
                text: 'Share',
                onTap: () => Share.share(text),
              ),
              SmallBtn(
                text: 'Copy',
                onTap: () {
                  LogSaver().copyToClipboard(text);
                },
              ),
              SmallBtn(
                text: isExpanded ? 'Shrink' : 'Expand',
                onTap: expand,
              )
            ],
          ),
          Text(
            text,
            style: const TextStyle(color: Colors.black38, fontSize: 17),
            textAlign: TextAlign.left,
            textDirection: TextDirection.ltr,
            maxLines: isExpanded ? 999999 : 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class SmallBtn extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const SmallBtn({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Text(
          text,
          style: const TextStyle(color: Colors.blueGrey, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
