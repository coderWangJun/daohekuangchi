
//fluro路由跳转工具类
import 'package:fluro/fluro.dart';

import 'application.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:flutter/cupertino.dart' hide Router;

class NavigatorUtil {

	//跳转
	static push(BuildContext context, String path,
			{bool replace = false, bool clearStack = false}) {
		FocusScope.of(context).unfocus();
		Application.getRouter.navigateTo(context, path, replace: replace, clearStack: clearStack, transition: TransitionType.native);
	}

	static pushW(BuildContext context, Widget widget,
			{bool full = false, bool material = false}) {
		FocusScope.of(context).unfocus();
		return Navigator.push(
			context,
			material
					? MaterialPageRoute(builder: (context) => widget)
					: CupertinoPageRoute(
					builder: (context) => widget, fullscreenDialog: full),
		);
	}


	//跳转带参数
	static pushResult(BuildContext context, String path, Function(Object) function,
			{bool replace = false, bool clearStack = false}) {
		FocusScope.of(context).unfocus();
		Application.getRouter.navigateTo(context, path, replace: replace, clearStack: clearStack, transition: TransitionType.fadeIn).then((result) {
			// 页面返回result为null
			if (result == null) {
				return;
			}
			function(result);
		}).catchError((error) {
			print('$error');
		});
	}
	//后退
	static pop(BuildContext context){
		FocusScope.of(context).unfocus();
		Application.getRouter.pop(context);
	}

	//带参数返回
	static void popResult(BuildContext context, result) {
		FocusScope.of(context).unfocus();
		Navigator.pop(context, result);
	}



}
