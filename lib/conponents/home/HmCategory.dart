import 'package:flutter/material.dart';

class HmCategory extends StatefulWidget {
  HmCategory({Key? key}) : super(key: key);

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
        itemCount: 10,
        itemBuilder: (BuildContext context,int index) {
        return Container(
          alignment: Alignment.center,
          width: 80,
          height: 100 ,
          color: Colors.greenAccent,
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Text("分组${index}",style: TextStyle(
            color: Colors.white,  
          ),),
        );
      }),
    );
  }
}