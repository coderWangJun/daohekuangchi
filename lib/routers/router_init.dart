import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:flutter/cupertino.dart' hide Router;

abstract class IRouterProvider{

	void initRouter(Router router);
}