import 'package:flutter/material.dart';
import 'package:hm_shop/conponents/home/HmCategory.dart';
import 'package:hm_shop/conponents/home/HmHot.dart';
import 'package:hm_shop/conponents/home/HmMoreList.dart';
import 'package:hm_shop/conponents/home/HmSlider.dart';
import 'package:hm_shop/conponents/home/HmSuggestion.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: getScrollChilden());
  }

  List<Widget> getScrollChilden() {
    return [
      SliverToBoxAdapter(child: HmSlider()),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      SliverToBoxAdapter(child: HmCategory()),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      SliverToBoxAdapter(child: HmSuggestion()),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 10),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(child: HmHot()),
              SizedBox(width: 10),
              Expanded(child: HmHot()),
            ],
          ),
        ),
      ),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      Hmmorelist(),
    ];
  }
}
