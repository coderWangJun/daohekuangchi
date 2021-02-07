import 'package:dh/res/styles.dart';
import 'package:flutter/material.dart';

/// 自定义dialog的模板
class BaseDialog extends StatelessWidget {
  const BaseDialog(
      {Key key,
      this.title,
      this.onPressed,
      this.hiddenTitle: false,
      @required this.child})
      : super(key: key);

  final String title;
  final Function onPressed;
  final Widget child;
  final bool hiddenTitle;

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      padding: MediaQuery.of(context).viewInsets +
          const EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0),
      duration: const Duration(milliseconds: 120),
      curve: Curves.easeInCubic,
      child: MediaQuery.removeViewInsets(
        removeLeft: true,
        removeTop: true,
        removeRight: true,
        removeBottom: true,
        context: context,
        child: Center(
          child: SizedBox(
            width: 270.0,
            child: Material(
              borderRadius: BorderRadius.circular(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                 Styles.vGap24,
                  Visibility(
                    visible: !hiddenTitle,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        hiddenTitle ? '' : title,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Flexible(child: child),
                 Styles.vGap8,
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: SizedBox(
                          height: 48.0,
                          child: FlatButton(
                            child: const Text(
                              '取消',
                              style: TextStyle(fontSize: 16),
                            ),
                            textColor: Styles.colorGray,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 48.0,
                        width: 0.6,
                        child: const VerticalDivider(),
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 48.0,
                          child: FlatButton(
                            child: const Text(
                              '确定',
                              style: TextStyle(fontSize: 16),
                            ),
                            textColor: Theme.of(context).primaryColor,
                            onPressed: () {
                              onPressed();
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
