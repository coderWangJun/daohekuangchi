import 'package:flutter/material.dart';
import 'package:dh/routers/fluro_navigator.dart';
import 'package:dh/ui/widgets/custom_app_bar.dart';

class CustomInputTextPage extends StatefulWidget {
  const CustomInputTextPage({
    Key key,
    @required this.title,
    this.content,
    this.hintText,
    this.keyboardType: TextInputType.text,
  }) : super(key: key);

  final String title;
  final String content;
  final String hintText;
  final TextInputType keyboardType;

  @override
  _CustomInputTextPageState createState() => _CustomInputTextPageState();
}

class _CustomInputTextPageState extends State<CustomInputTextPage> {
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.content;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.title,
        actionName: '完成',
        onPressed: () {
          NavigatorUtil.popResult(context, _controller.text);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.only(
            top: 21.0, left: 16.0, right: 16.0, bottom: 16.0),
        child: Semantics(
          multiline: true,
          maxValueLength: 30,
          child: TextField(
              maxLength: 30,
              maxLines: 5,
              autofocus: true,
              controller: _controller,
              keyboardType: widget.keyboardType,
              decoration: InputDecoration(
                hintText: widget.hintText,
                border: InputBorder.none,
                //hintStyle: TextStyles.textGrayC14
              )),
        ),
      ),
    );
  }
}
