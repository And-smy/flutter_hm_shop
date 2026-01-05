import 'package:flutter/material.dart';
import 'package:hm_shop/viewmodels/category.dart';

class HmCategory extends StatefulWidget {
  List<CategoryItem> categoryList;
  HmCategory({required this.categoryList, Key? key}) : super(key: key);

  @override
  _HmCategoryState createState() => _HmCategoryState();
}

class _HmCategoryState extends State<HmCategory> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.categoryList.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            alignment: Alignment.center,
            width: 80,
            height: 100,
            decoration: BoxDecoration(color: Color.fromARGB(255, 231, 232, 234),borderRadius: BorderRadius.circular(40)),
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  widget.categoryList[index].imgUrl,
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                ),
                Text(
                   widget.categoryList[index].name,
                   style: TextStyle(color: Colors.black),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
