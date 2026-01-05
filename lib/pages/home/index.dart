import 'package:flutter/material.dart';
import 'package:hm_shop/conponents/home/HmCategory.dart';
import 'package:hm_shop/conponents/home/HmHot.dart';
import 'package:hm_shop/conponents/home/HmMoreList.dart';
import 'package:hm_shop/conponents/home/HmSlider.dart';
import 'package:hm_shop/conponents/home/HmSuggestion.dart';
import 'package:hm_shop/constants/index.dart';
import 'package:hm_shop/utils/dio_request.dart';
import 'package:hm_shop/viewmodels/category.dart';
import 'package:hm_shop/viewmodels/home.dart';

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
          return BannerItem(id: item["id"], imgUrl: item["imgUrl"]);
        })
        .toList();
  }

  Future<List<CategoryItem>> _getCategoryListAPI() async {
    return (await diorequest.get(
              GlobalConstants.BASE_URL + HttpConstants.CATEGORY_LIST,
            )
            as List)
        .map((item) {
          return CategoryItem(
            id: item["id"],
            name: item["name"],
            imgUrl: item["picture"],
          );
        })
        .toList();
  }

  Future<SpecialRecommendResult> _getSpecialRecommendResultAPI() async {
    Map<String, dynamic> specialRecommendResultMap =
        (await diorequest.get(
              GlobalConstants.BASE_URL + HttpConstants.PRODUCT_LIST,
            ))
            as Map<String, dynamic>;
    List<dynamic> subTypesList =
        specialRecommendResultMap["subTypes"] as List<dynamic>;

    List<SubType> subTypes = [];
    for (dynamic subItem in subTypesList) {
      String id = subItem["id"];
      String title = subItem["title"] ?? "";
      Map<String, dynamic> goodItemsMap =
          subItem["goodsItems"] as Map<String, dynamic>;
      int counts = goodItemsMap["counts"] as int;
      int pageSize = goodItemsMap["pageSize"] as int;
      int pages = goodItemsMap["pages"] as int;
      int page = goodItemsMap["page"] as int;
      List<dynamic> itemsList = goodItemsMap["items"] as List<dynamic>;
      List<GoodsItem> goodItems = [];
      for (var item in itemsList) {
        String itemId = item["id"] as String;
        String itemName = item["name"] ?? "";
        String itemDesc = item["desc"] ?? "";
        String itemPrice = item["price"] ?? "";
        String itemPicture = item["picture"] ?? "";
        int itemOrderNum = item["orderNum"] as int;
        goodItems.add(
          GoodsItem(
            id: itemId,
            name: itemName,
            desc: itemDesc,
            price: itemPrice,
            picture: itemPicture,
            orderNum: itemOrderNum,
          ),
        );
      }
      GoodsItems goodItem = GoodsItems(
        counts: counts,
        pageSize: pageSize,
        pages: pages,
        page: page,
        items: goodItems,
      );

      subTypes.add(SubType(id: id, title: title, goodsItems: goodItem));
    }

    return SpecialRecommendResult(
      id: specialRecommendResultMap["id"] as String,
      title: specialRecommendResultMap["title"] as String,
      subTypes: subTypes,
    );
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
