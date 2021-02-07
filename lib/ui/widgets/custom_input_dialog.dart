import 'package:dh/res/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dh/routers/fluro_navigator.dart';
import 'package:dh/ui/widgets/base_dialog.dart';
import 'package:dh/utils/index.dart';

class CustomInputDialog extends StatefulWidget {
  CustomInputDialog(
      {Key key,
      this.title,
      this.onPressed,
      this.keyboardType: TextInputType.text,
      this.hintText,
      this.inputFormatter})
      : super(key: key);

  final String title;
  final String hintText;
  final TextInputType keyboardType;
  final TextInputFormatter inputFormatter;
  final Function(String) onPressed;

  @override
  _CustomInputDialog createState() => _CustomInputDialog();
}

class _CustomInputDialog extends State<CustomInputDialog> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: widget.title,
      child: Container(
        height: 34.0,
        alignment: Alignment.center,
        margin: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0.0),
        decoration: BoxDecoration(

          borderRadius: BorderRadius.circular(2.0),
        ),
        child: TextField(
          key: const Key('custom_input_dialog'),
          autofocus: true,
          controller: _controller,
          maxLines: 1,
          keyboardType: widget.keyboardType,
          // 金额限制数字格式
          inputFormatters: (widget.keyboardType == TextInputType.number ||
                  widget.keyboardType == TextInputType.phone)
              ? [WhitelistingTextInputFormatter(RegExp('[0-9]'))]
              : [],
          decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
            border: InputBorder.none,
            hintText: widget.hintText ?? '请输入${widget.title}',
            hintStyle: TextStyle(
              color: Styles.colorGray,
              fontSize:ScreenUtil().setSp(28)
            )
          ),
        ),
      ),
      onPressed: () {
        if (_controller.text.isEmpty) {
          ToastUtil.openToast('请输入${widget.hintText ?? '请输入${widget.title}'}');
          return;
        }
        NavigatorUtil.pop(context);
        widget.onPressed(_controller.text);
      },
    );
  }
}
