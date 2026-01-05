class CategoryItem {
  String id;
  String name;
  String imgUrl;

  CategoryItem({required this.id, required this.imgUrl, required this.name});

  factory CategoryItem.fromJson(Map<String, dynamic> json) {
    return CategoryItem(
      id: json['id'],
      name: json['name'],
      imgUrl: json['picture'],
    );
  }
}

class BannerItem {
  String id;
  String imgUrl;
  BannerItem({required this.id, required this.imgUrl});
  factory BannerItem.fromJson(Map<String, dynamic> json) {
    return BannerItem(
      id: json['id'],
      imgUrl: json['imgUrl'],
    );
  }
}

// 商品信息
class GoodsItem {
  final String id;
  final String name;
  final String? desc;
  final String price;
  final String picture;
  final int orderNum;

  GoodsItem({
    required this.id,
    required this.name,
    required this.desc,
    required this.price,
    required this.picture,
    required this.orderNum,
  });
  factory GoodsItem.fromJson(Map<String, dynamic> json) {
    return GoodsItem(
      id: json['id'],
      name: json['name'],
      desc: json['desc'],
      price: json['price'],
      picture: json['picture'],
      orderNum: json['orderNum'],
    );
  }
}

// 商品列表信息
class GoodsItems {
  final int counts;
  final int pageSize;
  final int pages;
  final int page;
  final List<GoodsItem> items;

  GoodsItems({
    required this.counts,
    required this.pageSize,
    required this.pages,
    required this.page,
    required this.items,
  });
  factory GoodsItems.fromJson(Map<String, dynamic> json) {
    return GoodsItems(
      counts: json['counts'],
      pageSize: json['pageSize'],
      pages: json['pages'],
      page: json['page'],
      items: (json['items'] as List<dynamic>)
          .map((item) => GoodsItem.fromJson(item))
          .toList(),
    );
  }
}

// 子类型信息
class SubType {
  final String id;
  final String title;
  final GoodsItems goodsItems;

  SubType({required this.id, required this.title, required this.goodsItems});
  factory SubType.fromJson(Map<String, dynamic> json) {
    return SubType(
      id: json['id'],
      title: json['title'],
      goodsItems: GoodsItems.fromJson(json['goodsItems']),
    );
  }
}

// 热门推荐结果
class SpecialRecommendResult {
  final String id;
  final String title;
  final List<SubType> subTypes;

  SpecialRecommendResult({
    required this.id,
    required this.title,
    required this.subTypes,
  });
  factory SpecialRecommendResult.fromJson(Map<String, dynamic> json) {
    return SpecialRecommendResult(
      id: json['id'],
      title: json['title'],
      subTypes: (json['subTypes'] as List<dynamic>)
          .map((item) => SubType.fromJson(item))
          .toList(),
    );
  }
}
