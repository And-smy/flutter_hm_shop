import 'package:flutter/material.dart';
import 'package:hm_shop/viewmodels/home.dart'
    show SpecialRecommendResult, GoodsItem;

class HmHot extends StatefulWidget {
  final SpecialRecommendResult result;
  final String type;
  HmHot({required this.result, required this.type, Key? key}) : super(key: key);

  @override
  _HmHotState createState() => _HmHotState();
}

class _HmHotState extends State<HmHot> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: widget.type == "hot"
              ? Color.fromARGB(255, 249, 247, 219)
              : Color.fromARGB(255, 211, 228, 240),
        ),
        child: Column(
          children: [_getTitle(), SizedBox(height: 10), _getData()],
        ),
      ),
    );
  }

  Widget _getTitle() {
    return Row(
      children: [
        Text(
          widget.type == "hot" ? "爆款推荐" : "一站式服务",
          style: TextStyle(
            color: Color.fromARGB(255, 86, 24, 20),
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(width: 10),
        Text(
          widget.type == "hot" ? "最受欢迎" : "精心优选",
          style: TextStyle(
            color: Color.fromARGB(255, 124, 63, 58),
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _getData() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: _getChildrenList(),
    );
  }

  List<Widget> _getChildrenList() {
    List<GoodsItem> list = _getGoodsList();
    return List.generate(list.length, (index) {
      return Column(
        children: [
          Image.network(
            list[index].picture,
            width: 80,
            height: 120,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 240, 96, 12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              "￥${list[index].price}",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      );
    });
  }

  List<GoodsItem> _getGoodsList() {
    if (widget.result.subTypes.isEmpty) {
      return [];
    }
    return widget.result.subTypes.first.goodsItems.items.take(2).toList();
  }
}
