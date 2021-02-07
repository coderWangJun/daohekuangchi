import 'package:dh/res/styles.dart';
import 'package:flutter/material.dart';
import 'package:dh/utils/index.dart';

//公告栏动画 垂直淡入淡出
class MyNoticeVecAnimation extends StatefulWidget {
  final Duration duration;
  final List<String> messages;
  final Color color;

  const MyNoticeVecAnimation({
    Key key,
    this.duration = const Duration(milliseconds: 3000),
    this.messages,
    this.color
  }) : super(key: key);

  @override
  _MyNoticeVecAnimationState createState() {
    // TODO: implement createState
    return _MyNoticeVecAnimationState();
  }
}

class _MyNoticeVecAnimationState extends State<MyNoticeVecAnimation>
    with TickerProviderStateMixin {
  static AnimationController _controller;
  Animation<double> _opacityAni1;
  Animation<double> _opacityAni2;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = new AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    //透明度
    _opacityAni1 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: _controller, curve: Interval(0.0, 0.1, curve: Curves.linear)),
    );

    _opacityAni2 = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
          parent: _controller, curve: Interval(0.9, 1.0, curve: Curves.linear)),
    );

    _positionAni1 = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: const Offset(0.0, 0.0),
    ).animate(
      CurvedAnimation(
          parent: _controller, curve: Interval(0.0, 0.1, curve: Curves.linear)),
    );

    _positionAni2 = Tween<Offset>(
      begin: const Offset(0.0, 0.0),
      end: const Offset(0.0, -1.0),
    ).animate(
      CurvedAnimation(
          parent: _controller, curve: Interval(0.9, 1.0, curve: Curves.linear)),
    );
  }

  int _nextMassage = 0;

  //位移
  Animation<Offset> _positionAni1, _positionAni2;

  @override
  Widget build(BuildContext context) {
    if (widget.messages.length > 0) _startVerticalAni();
    //正向开启动画
    // TODO: implement build
    return SlideTransition(
      position: _positionAni2,
      child: FadeTransition(
        opacity: _opacityAni2,
        child: SlideTransition(
          position: _positionAni1,
          child: FadeTransition(
            opacity: _opacityAni1,
            child: Text(
              widget.messages.length <= 0
                  ? " "
                  : _nextMassage >= widget.messages.length
                      ? widget.messages[0]
                      : widget.messages[_nextMassage],
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Styles.theme(
                  color: widget.color==null?Color.fromRGBO(102, 102, 102, 1):widget.color,
                  fontSize: 26.ssp,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ),
      ),
    );
  }

  //纵向滚动
  void _startVerticalAni() {
    if (widget.messages.length > 0) {
      // TODO: implement initState
      //_controller = AnimationController(duration: widget.duration, vsync: this);

//      _opacityAni1 = Tween<double>(begin: 0.0, end: 1.0).animate(
//        CurvedAnimation(
//            parent: _controller,
//            curve: Interval(0.0, 0.1, curve: Curves.linear)),
//      );
//
//      _opacityAni2 = Tween<double>(begin: 1.0, end: 0.0).animate(
//        CurvedAnimation(
//            parent: _controller,
//            curve: Interval(0.9, 1.0, curve: Curves.linear)),
//      );

      _controller
        ..addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            if (mounted) {
              setState(() {
                _nextMassage++;
                if (_nextMassage >= widget.messages.length) {
                  _nextMassage = 0;
                }
                _controller.reset();
                _controller.forward();
              });
            }
          }
          if (status == AnimationStatus.dismissed) {
            if (mounted) {
              _controller.forward();
            }
          }
        });
      if (mounted && _controller.isDismissed) _controller.forward();
    }
  }

  //释放
  @override
  void dispose() {
    _controller?.dispose();
    // TODO: implement dispose
    super.dispose();
  }
}
