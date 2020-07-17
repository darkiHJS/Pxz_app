import 'package:flutter/material.dart';
import 'package:hello_world/components/IconFont.dart';
import 'package:hello_world/jsons/AdoptPetItemModel.dart';
import 'dart:math' as math;

class PetHommingItem extends StatelessWidget {
  final PetItemData itemData;
  const PetHommingItem({Key key, this.itemData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(1, 1),
          )
        ]),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(10),
              width: 120,
              height: 120,
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image.network(
                    itemData.imageDefaultId,
                    fit: BoxFit.cover,
                  )),
                  itemData.status == "true" ? 
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      color: Colors.white.withOpacity(.6),
                      alignment: Alignment.center,
                      child: Transform.rotate(
                        angle: math.pi*-.2,
                        child: Text("已领养", style: TextStyle(color: Color(0xfffecf1f), fontSize: 30, fontWeight: FontWeight.bold),),
                      )
                    ),
                  ):Container()
                ],
              )
            ),
            Expanded(
                child: Container(
              height: 120,
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(itemData.name), 
                      SizedBox(width: 10,), 
                      Text(itemData.origin, style: TextStyle(fontSize: 12, color: Colors.black54),)
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      itemData.sex == "女孩" ? Icon(
                        IconFont.woman,
                        color: Colors.pink,
                        size: 18,
                      ) : Icon(
                        IconFont.man,
                        color: Colors.blue,
                        size: 18,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 2),
                        padding:
                            EdgeInsets.symmetric(vertical: 1, horizontal: 4),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.black12),
                        child: Text(
                          itemData.ageStage,
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 2),
                        padding:
                            EdgeInsets.symmetric(vertical: 1, horizontal: 4),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.black12),
                        child: Text(
                          itemData.petVarietyId,
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 2),
                        padding:
                            EdgeInsets.symmetric(vertical: 1, horizontal: 4),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.black12),
                        child: Text(
                          itemData.area.split(",").last,
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    itemData.intro,
                    maxLines: 2,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12),
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 2),
                        padding:
                            EdgeInsets.symmetric(vertical: 1, horizontal: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            width: 1,
                            color: Color(0xfff3d72f),
                          ),
                        ),
                        child: Text(
                          itemData.vaccine,
                          style: TextStyle(
                            color: Color(0xfff3d72f),
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 2),
                        padding:
                            EdgeInsets.symmetric(vertical: 1, horizontal: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            width: 1,
                            color: Color(0xfff3d72f),
                          ),
                        ),
                        child: Text(
                          itemData.deworming,
                          style: TextStyle(
                            color: Color(0xfff3d72f),
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 2),
                        padding:
                            EdgeInsets.symmetric(vertical: 1, horizontal: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            width: 1,
                            color: Color(0xfff3d72f),
                          ),
                        ),
                        child: Text(
                          itemData.sterilization,
                          style: TextStyle(
                            color: Color(0xfff3d72f),
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )),
          ],
        ));
  }
}
