import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../Model/DSLaiXeDuKienTheoKeHoach.dart';

class multiselectwithChip extends StatefulWidget {
  List<ThongTinLaiXe> datasource;
  List<ThongTinLaiXe> selectedlaixedicung;
  String laixechinh;
  multiselectwithChip(this.datasource, this.laixechinh,
      this.selectedlaixedicung, this.stackheadchild);
  Widget stackheadchild;
  @override
  State<multiselectwithChip> createState() => _multiselectwithChipState();
}

class _multiselectwithChipState extends State<multiselectwithChip> {
  var searchController = TextEditingController();
  var phuxeController = TextEditingController();
  List<ThongTinLaiXe> listfordisplay;
  bool showList = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    listfordisplay = widget.datasource
        .where((element) => element.idDnvtLaiXe != widget.laixechinh)
        .toList();
    return Expanded(
      child: Column(
        children: [
          Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Lái xe đi cùng',
                  style: TextStyle(
                      fontFamily: 'Roboto Regular',
                      fontSize: 12,
                      color: Colors.black54),
                ),
              ),
              widget.selectedlaixedicung.length == 0
                  ? SizedBox(
                      height: 50,
                      child: TextFormField(
                        controller: searchController,
                        decoration: InputDecoration(
                            hintText: 'Lựa chọn...',
                            hintStyle: TextStyle(
                                fontFamily: 'Roboto Regular', fontSize: 14),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.only(left: 25),
                              child: Icon(
                                Icons.arrow_drop_down,
                                color: Colors.black87.withOpacity(0.6),
                              ),
                            )),
                        onTap: () {
                          setState(() {
                            showList = !showList;
                          });
                        },
                        onChanged: ((value) {
                          print(searchController.text);
                          setState(
                            () {
                              listfordisplay = widget.datasource
                                  .where((element) => element.hoTen
                                      .toLowerCase()
                                      .contains(value))
                                  .toList();
                              print(listfordisplay.length);
                            },
                          );
                        }),
                      ))
                  : GestureDetector(
                      onTap: () {
                        setState(() {
                          print('tap from container selected');
                          showList = !showList;
                        });
                      },
                      child: Container(
                        color: Colors.white.withOpacity(0.0),
                        height: 50,
                        width: size.width,
                        child: Row(
                          children: [
                            Wrap(
                              children: [
                                ...widget.selectedlaixedicung
                                    .map((e) => Container(
                                        margin: EdgeInsets.only(right: 5),
                                        child: Chip(
                                          label: Text(e.hoTen),
                                          deleteIcon: Container(
                                            padding: EdgeInsets.all(2),
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.grey),
                                            child: Icon(
                                              Icons.close,
                                              color: Colors.white,
                                              size: 14,
                                            ),
                                          ),
                                          onDeleted: () {
                                            print('delete');
                                            setState(
                                              () {
                                                widget.selectedlaixedicung
                                                    .remove(e);
                                                int ind = widget.datasource
                                                    .indexWhere((element) =>
                                                        element.dienThoai ==
                                                        e.dienThoai);
                                                print(ind);
                                                widget.datasource[ind].check =
                                                    false;
                                                listfordisplay =
                                                    widget.datasource;
                                              },
                                            );
                                          },
                                        )))
                              ],
                            ),
                            widget.selectedlaixedicung.length == 1
                                ? Expanded(
                                    child: TextFormField(
                                    decoration: InputDecoration(
                                        border: InputBorder.none),
                                    onTap: () {
                                      setState(() {
                                        showList = !showList;
                                      });
                                    },
                                    onChanged: (value) {
                                      setState(
                                        () {
                                          listfordisplay = widget.datasource
                                              .where((element) => element.hoTen
                                                  .toLowerCase()
                                                  .contains(value))
                                              .toList();
                                          print(listfordisplay.length);
                                        },
                                      );
                                    },
                                    autofocus: true,
                                  ))
                                : Spacer(),
                            Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black87.withOpacity(0.6),
                            )
                          ],
                        ),
                      ),
                    )
            ],
          ),
          Expanded(
            child: Stack(
              children: [
                widget.stackheadchild,
                showList
                    ? Positioned(
                        child: listfordisplay.length == 0
                            ? Container(
                                height: 50,
                                color: Colors.white,
                                width: size.width,
                                child: Center(
                                  child: Text(
                                    'Không có dữ liệu !',
                                    style: TextStyle(
                                        color: Colors.grey.withOpacity(0.8),
                                        fontFamily: 'Roboto Regular',
                                        fontSize: 14),
                                  ),
                                ),
                              )
                            : Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                  color: Colors.grey.withOpacity(0.5),
                                )),
                                child: ListView.builder(
                                    itemCount: listfordisplay.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          if (widget
                                                  .selectedlaixedicung.length <
                                              2) {
                                            if (listfordisplay[index].check) {
                                              setState(
                                                () {
                                                  listfordisplay[index].check =
                                                      false;

                                                  widget.selectedlaixedicung
                                                      .removeWhere((element) =>
                                                          element.dienThoai ==
                                                          listfordisplay[index]
                                                              .dienThoai);
                                                },
                                              );
                                            } else {
                                              setState(
                                                () {
                                                  listfordisplay[index].check =
                                                      true;
                                                  widget.selectedlaixedicung
                                                      .add(listfordisplay[
                                                          index]);
                                                },
                                              );
                                            }
                                          } else {
                                            setState(
                                              () {
                                                listfordisplay[index].check =
                                                    false;
                                                widget.selectedlaixedicung
                                                    .removeWhere((element) =>
                                                        element.dienThoai ==
                                                        listfordisplay[index]
                                                            .dienThoai);
                                              },
                                            );
                                          }
                                          listfordisplay = widget.datasource;
                                          searchController =
                                              TextEditingController(text: null);
                                        },
                                        child: Container(
                                          color: Colors.white,
                                          child: Row(
                                            children: [
                                              Checkbox(
                                                  value: listfordisplay[index]
                                                      .check,
                                                  onChanged: (value) {
                                                    if (widget
                                                            .selectedlaixedicung
                                                            .length <
                                                        2) {
                                                      if (listfordisplay[index]
                                                          .check) {
                                                        setState(
                                                          () {
                                                            listfordisplay[
                                                                    index]
                                                                .check = false;

                                                            widget
                                                                .selectedlaixedicung
                                                                .removeWhere((element) =>
                                                                    element
                                                                        .dienThoai ==
                                                                    listfordisplay[
                                                                            index]
                                                                        .dienThoai);
                                                          },
                                                        );
                                                      } else {
                                                        setState(
                                                          () {
                                                            listfordisplay[
                                                                    index]
                                                                .check = true;
                                                            widget
                                                                .selectedlaixedicung
                                                                .add(
                                                                    listfordisplay[
                                                                        index]);
                                                          },
                                                        );
                                                      }
                                                    } else {
                                                      setState(
                                                        () {
                                                          listfordisplay[index]
                                                              .check = false;
                                                          widget
                                                              .selectedlaixedicung
                                                              .removeWhere((element) =>
                                                                  element
                                                                      .dienThoai ==
                                                                  listfordisplay[
                                                                          index]
                                                                      .dienThoai);
                                                        },
                                                      );
                                                    }
                                                    listfordisplay =
                                                        widget.datasource;
                                                    searchController =
                                                        TextEditingController(
                                                            text: null);
                                                  }),
                                              Text(
                                                listfordisplay[index].hoTen,
                                                style: TextStyle(
                                                  fontFamily: 'Roboto Regular',
                                                  fontSize: 14,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                      )
                    : SizedBox(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
