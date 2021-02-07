import 'package:dh/routers/module/login_router.dart';
import 'package:dh/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:dh/routers/fluro_navigator.dart';

///欢迎页
class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  AnimationController _logoController;
  Animation<double> _animation;
  AnimationController _countdownController;

  @override
  void initState() {
    _logoController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));

    _animation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(curve: Curves.easeInOutBack, parent: _logoController));

    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _logoController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _logoController.forward();
      }
    });
    _logoController.forward();

    _countdownController =
        AnimationController(vsync: this, duration: Duration(seconds: 4));
    _countdownController.forward();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await SpUtil.getInstance();
    });
    super.initState();
  }

  @override
  void dispose() {
    _logoController.dispose();
    _countdownController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: false);
    return Scaffold(
      body: WillPopScope(
        onWillPop: () => Future.value(false),
        child: Stack(children: <Widget>[
          Image.asset(
            "assets/images/1080-1920.jpg",
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fitHeight,
          ),
          Positioned(
            top: 15.h,
            right: 30.w,
            child: Container(
              alignment: Alignment.topRight,
              //margin: EdgeInsets.only(bottom: 20.h, right: 20.w),
              child: SafeArea(
                child: InkWell(
                  onTap: () {
                    NavigatorUtil.push(context, "/login");
                  },
                  child: Container(
                    child: AnimatedCountdown(
                      context: context,
                      animation: StepTween(begin: 3, end: 0)
                          .animate(_countdownController),
                    ),
                  ),
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}

class AnimatedCountdown extends AnimatedWidget {
  final Animation<int> animation;

  AnimatedCountdown({key, this.animation, context})
      : super(key: key, listenable: animation) {
    this.animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        NavigatorUtil.push(context, LoginRouter.login, replace: true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var value = animation.value + 1;
    return new Text(
      (value == 0 ? '' : '$value | ') + "跳过",
      style: TextStyle(color: Colors.white),
    );
  }
}
