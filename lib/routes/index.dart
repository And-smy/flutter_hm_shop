//  管理路由
import 'package:flutter/material.dart';
import 'package:hm_shop/pages/login/index.dart';
import 'package:hm_shop/pages/main/index.dart';

//  返回app根组件
Widget getRootWidget() {
  return MaterialApp(
    //  命名路由
    initialRoute: "/",
    routes: getRootRoutes(),
  );
}

//  返回路由配置
Map<String, Widget Function(BuildContext)> getRootRoutes() {
  return {
    "/" : (context) => MainPage(),
    "/login" : (context) => LoginPage()
  };
}
