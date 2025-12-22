import 'package:flutter/material.dart';
import 'package:hm_shop/pages/cart/index.dart';
import 'package:hm_shop/pages/category/index.dart';
import 'package:hm_shop/pages/home/index.dart';
import 'package:hm_shop/pages/my/index.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  //  定义数据 根据数据进行渲染4个导航
  final List<Map<String, String>> _tabList = [
    {
      "icon": "lib/assets/ic_public_home_normal.png",
      "active_icon": "lib/assets/ic_public_home_active.png",
      "text": "首页",
    },
    {
      "icon": "lib/assets/ic_public_pro_normal.png",
      "active_icon": "lib/assets/ic_public_pro_active.png",
      "text": "分类",
    },
    {
      "icon": "lib/assets/ic_public_cart_normal.png",
      "active_icon": "lib/assets/ic_public_cart_active.png",
      "text": "购物车",
    },
    {
      "icon": "lib/assets/ic_public_my_normal.png",
      "active_icon": "lib/assets/ic_public_my_active.png",
      "text": "我的",
    },
  ];
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(children: _getChildren(), index: _currentIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        unselectedItemColor: Colors.black,
        items: _getTabBarWidget(),
        currentIndex: _currentIndex,
        selectedItemColor: Colors.black,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  List<Widget> _getChildren() {
    return [HomeView(), CategoryView(), CartView(), MyView()];
  }

  //  返回底部分类
  List<BottomNavigationBarItem> _getTabBarWidget() {
    return List.generate(_tabList.length, (index) {
      return BottomNavigationBarItem(
        icon: Image.asset(_tabList[index]["icon"]!, width: 30, height: 30),
        activeIcon: Image.asset(
          _tabList[index]["active_icon"]!,
          width: 30,
          height: 30,
        ),
        label: _tabList[index]["text"],
      );
    });
  }
}
