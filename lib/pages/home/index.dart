import 'package:flutter/material.dart';
import 'package:hm_shop/conponents/home/HmCategory.dart';
import 'package:hm_shop/conponents/home/HmHot.dart';
import 'package:hm_shop/conponents/home/HmMoreList.dart';
import 'package:hm_shop/conponents/home/HmSlider.dart';
import 'package:hm_shop/conponents/home/HmSuggestion.dart';
import 'package:hm_shop/constants/index.dart';
import 'package:hm_shop/utils/dio_request.dart';
import 'package:hm_shop/pojo/home.dart'
    show CategoryItem, BannerItem, SpecialRecommendResult, ShopItem;

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
  SpecialRecommendResult _invogueList = SpecialRecommendResult(
    id: "",
    title: "",
    subTypes: [],
  );
  SpecialRecommendResult _oneStepList = SpecialRecommendResult(
    id: "",
    title: "",
    subTypes: [],
  );
  List<ShopItem> _shopList = [];

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

  Future<SpecialRecommendResult> _getInvogueListAPI() async {
    return SpecialRecommendResult.fromJson(
      (await diorequest.get(
            GlobalConstants.BASE_URL + HttpConstants.INVOGUE_LIST,
          ))
          as Map<String, dynamic>,
    );
  }

  Future<SpecialRecommendResult> _getOneStepAPI() async {
    return SpecialRecommendResult.fromJson(
      (await diorequest.get(
            GlobalConstants.BASE_URL + HttpConstants.ONE_STOP_LIST,
          ))
          as Map<String, dynamic>,
    );
  }

  Future<List<ShopItem>> _getShopListAPI({required int limit}) async {
    return (await diorequest.get(
              GlobalConstants.BASE_URL + HttpConstants.SHOP_LIST,
              params: {"limit": limit},
            )
            as List)
        .map((item) {
          return ShopItem.fromJson(item);
        })
        .toList();
  }

  @override
  void initState() {
    _loadData();
    _getShopList();
    _registerEvent();
    super.initState();
  }

  void _loadData() async {
    _bannerList = await _getBannerListAPI();
    _categoryList = await _getCategoryListAPI();
    _specialRecommendResult = await _getSpecialRecommendResultAPI();
    _invogueList = await _getInvogueListAPI();
    _oneStepList = await _getOneStepAPI();
    setState(() {});
  }

  void _getShopList() async {
    if (isLoading || !ishasNext) {
      return;
    }
    isLoading = true;
    int currentLimit = 10 * _page; 
    _shopList = await _getShopListAPI(limit: currentLimit);
    isLoading = false;
    if (_shopList.length < currentLimit) {
      ishasNext = false;
      return;
    }
     _page++;
    setState(() {});
  }

  int _page = 1;
  bool isLoading = false;
  bool ishasNext = true;
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: getScrollChilden(),
    );
  }

  void _registerEvent() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 50) {
        _getShopList();
      }
    });
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
              Expanded(
                child: HmHot(result: _invogueList, type: "hot"),
              ),
              SizedBox(width: 10),
              Expanded(
                child: HmHot(result: _oneStepList, type: "step"),
              ),
            ],
          ),
        ),
      ),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      Hmmorelist(shopList: _shopList),
    ];
  }
}
