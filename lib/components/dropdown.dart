import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:slaixe2/Model/DSLaiXeDuKienTheoKeHoach.dart';

class dropdown extends StatefulWidget {
  List<ThongTinLaiXe> list;
  List<String> selected;
 dropdown(this.list,this.selected);

  @override
  State<dropdown> createState() => _dropdownState();
}

class _dropdownState extends State<dropdown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField( decoration:
                            InputDecoration(labelText: 'Lái xe đi cùng'),
                        items: widget.list.map((text) {
                          return new DropdownMenuItem(
                            child:
                               GestureDetector(
                                onTap: () {
                                  setState(
                                    () {
                                      text.check = !text.check;
                                    
                                      print(text.hoTen);
                                    },
                                  );
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Checkbox(
                                        value: text.check,
                                        onChanged: (value) {
                                        }),
                                    Container(
                                        child: Text(text.hoTen,
                                            style: TextStyle(
                                                fontFamily: 'Roboto Regular',
                                                fontSize: 16)))
                                  ],
                                ),
                              ),
                           
                            value: text.dienThoai,
                          );
                        }).toList(),
                        // value: 'Bến xe Hà Nam',
                        onChanged: (value) {},
                        selectedItemBuilder: (context) {
                          return widget.selected
                              .map((e) => Chip(
                                      label: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(e),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            widget.selected.remove(e);
                                          });
                                        },
                                        child: Container(
                                            padding: EdgeInsets.all(1),
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.grey),
                                            child: Icon(
                                              Icons.close,
                                              size: 15,
                                              color: Colors.white,
                                            )),
                                      )
                                    ],
                                  )))
                              .toList();
                        },

                        menuMaxHeight: 400,);
  }
}