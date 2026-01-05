import 'package:flutter/material.dart';
import 'package:hm_shop/conponents/home/HmCategory.dart';
import 'package:hm_shop/conponents/home/HmHot.dart';
import 'package:hm_shop/conponents/home/HmMoreList.dart';
import 'package:hm_shop/conponents/home/HmSlider.dart';
import 'package:hm_shop/conponents/home/HmSuggestion.dart';
import 'package:hm_shop/constants/index.dart';
import 'package:hm_shop/utils/dio_request.dart';
import 'package:hm_shop/viewmodels/home.dart' show CategoryItem, BannerItem, SpecialRecommendResult;


class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<BannerItem> _bannerList = [];
  List<CategoryItem> _categoryList = [];
  SpecialRecommendResult _specialRecommendResult = SpecialRecommendResult(
    id: "",
    title: "",
    subTypes: [],
  );
  Future<List<BannerItem>> _getBannerListAPI() async {
    return ((await diorequest.get(
              GlobalConstants.BASE_URL + HttpConstants.BANNER_LIST,
            ))
            as List)
        .map((item) {
          return BannerItem.fromJson(item);
        })
        .toList();
  }

  Future<List<CategoryItem>> _getCategoryListAPI() async {
    return (await diorequest.get(
              GlobalConstants.BASE_URL + HttpConstants.CATEGORY_LIST,
            )
            as List)
        .map((item) {
          return CategoryItem.fromJson(item);
        })
        .toList();
  }

  Future<SpecialRecommendResult> _getSpecialRecommendResultAPI() async {
    Map<String, dynamic> resultMap =
        (await diorequest.get(
              GlobalConstants.BASE_URL + HttpConstants.PRODUCT_LIST,
            ))
            as Map<String, dynamic>;
    return SpecialRecommendResult.fromJson(resultMap);
  }

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  void _loadData() async {
    _bannerList = await _getBannerListAPI();
    _categoryList = await _getCategoryListAPI();
    _specialRecommendResult = await _getSpecialRecommendResultAPI();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: getScrollChilden());
  }

  List<Widget> getScrollChilden() {
    return [
      SliverToBoxAdapter(child: HmSlider(bannerList: _bannerList)),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      SliverToBoxAdapter(child: HmCategory(categoryList: _categoryList)),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      SliverToBoxAdapter(
        child: HmSuggestion(specialRecommendResult: _specialRecommendResult),
      ),
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
