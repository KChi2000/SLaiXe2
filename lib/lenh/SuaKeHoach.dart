import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart';
import 'package:multiselect/multiselect.dart';
import 'package:slaixe2/Model/ChiTietKeHoach.dart';
import 'package:slaixe2/Model/DSLaiXeDuKienTheoKeHoach.dart';
import 'package:slaixe2/Model/DanhSachKeHoach.dart';
import 'package:slaixe2/extensions/extensions.dart';
import 'package:slaixe2/helpers/ApiHelper.dart';
import 'package:slaixe2/servicesAPI.dart';

import '../Model/DSXeDuKienTheoKeHoach.dart';

class SuaKeHoach extends StatefulWidget {
  SuaKeHoach(this.time, this.lotrinh, this.tenbenxedi, this.idkehoach,
      this.tungay, this.denngay);
  String time;
  String lotrinh;
  String tenbenxedi;
  String idkehoach;
  String tungay;
  String denngay;
  @override
  State<SuaKeHoach> createState() => _SuaKeHoachState();
}

class _SuaKeHoachState extends State<SuaKeHoach> {
  final List<String> dsBienKiemSoat = ['20A-08124 (31/12/2025)'];
  final List<String> dsLaiXe = ['Hà Thị Kim Chi'];
  final List<String> dsLaiXeDiCung = ['Khánh Linh'];
  final phuxeController = TextEditingController();
  final laixetiepnhanlenhkey = GlobalKey<FormState>();
  final bienkiemsoatkey = GlobalKey<FormState>();
  DSXeDuKienTheoKeHoach datadsxedukientheokehoach;
  DSLaiXeDuKienTheoKeHoach datadslaixedukientheokehoach;
  ChiTietKeHoach datachitietkehoach;
  List<String> selectedItem = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadapi();
  }

  Future loadapi() async {
    datadsxedukientheokehoach = DSXeDuKienTheoKeHoach.fromJson(
        await ApiHelper.get(apiSuaKeHoach.apidsxedukien(widget.idkehoach)));
    datadslaixedukientheokehoach = DSLaiXeDuKienTheoKeHoach.fromJson(
        await ApiHelper.get(apiSuaKeHoach.apidslaixedukien(widget.idkehoach)));
    datachitietkehoach = ChiTietKeHoach.fromJson(await ApiHelper.get(
        apiSuaKeHoach.apidchitietkehoach(
            widget.tungay, widget.denngay, widget.idkehoach)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SỬA KẾ HOẠCH',
            style: TextStyle(
              fontFamily: 'Roboto Regular',
            )),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: loadapi(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (datadsxedukientheokehoach.data != null &&
              datadslaixedukientheokehoach != null &&
              datachitietkehoach.data != null &&
              datadsxedukientheokehoach.message == 'Thành công' &&
              datadslaixedukientheokehoach.message == 'Thành công' &&
              datachitietkehoach.message == 'Thành công') {
            return Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      RowTextItem(
                          'asset/icons/road-variant.svg', 24, widget.lotrinh),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RowTextItem('asset/icons/calendar.svg', 24,
                              widget.time.substring(0, widget.time.length - 3)),
                          SizedBox(
                            width: 5,
                          ),
                          RowTextItem('asset/icons/bus-stop.svg', 24,
                              widget.tenbenxedi),
                        ],
                      ),
                      formsuakehoach(
                          bienkiemsoatkey: bienkiemsoatkey,
                          datadsxedukientheokehoach: datadsxedukientheokehoach,
                          datadslaixedukientheokehoach:
                              datadslaixedukientheokehoach),
                      DropdownButtonFormField(
                        decoration:
                            InputDecoration(labelText: 'Lái xe đi cùng'),
                        items: datadslaixedukientheokehoach.data.map((text) {
                          return new DropdownMenuItem(
                            child:  Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Checkbox(
                                      value: text.check, onChanged: (value) {}),
                                  Container(
                                      child: Text(text.hoTen,
                                          style: TextStyle(
                                              fontFamily: 'Roboto Regular',
                                              fontSize: 16)))
                                ],
                              ),
                       
                            value: text.dienThoai,
                          );
                        }).toList(),
                        // value: 'Bến xe Hà Nam',
                        onChanged: (value) {
                          // setState(() {
                            // selectedItem.add(value);
                          // });
                        },
                        // selectedItemBuilder: (context) {
                        //   return selectedItem
                        //       .map((e) => Chip(
                        //               label: Row(
                        //             mainAxisSize: MainAxisSize.min,
                        //             children: [
                        //               Text(e),
                        //               GestureDetector(
                        //                 onTap: () {
                        //                   setState(() {
                        //                     // selectedItem.remove(e);
                        //                   });
                        //                 },
                        //                 child: Container(
                        //                     padding: EdgeInsets.all(1),
                        //                     decoration: BoxDecoration(
                        //                         shape: BoxShape.circle,
                        //                         color: Colors.grey),
                        //                     child: Icon(
                        //                       Icons.close,
                        //                       size: 15,
                        //                       color: Colors.white,
                        //                     )),
                        //               )
                        //             ],
                        //           )))
                        //       .toList();
                        // },

                        menuMaxHeight: 400,
                      ),
                      Form(
                        // key: formkey,
                        child: TextFormField(
                          decoration: InputDecoration(labelText: 'Phụ xe'),
                          controller: phuxeController,
                          inputFormatters: [],
                          validator: (value) {},
                          onChanged: (value) {},
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Divider(
                  color: Colors.black54,
                  thickness: 0.2,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'HỦY',
                          style: TextStyle(
                              fontFamily: 'Roboto Medium',
                              fontSize: 14,
                              letterSpacing: 1.25,
                              color: HexColor.fromHex('#D10909')),
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            if (bienkiemsoatkey.currentState.validate() &&
                                laixetiepnhanlenhkey.currentState.validate()) {}
                          },
                          child: Text(
                            'XÁC NHẬN',
                            style: TextStyle(
                                fontFamily: 'Roboto Medium',
                                fontSize: 14,
                                letterSpacing: 1.25,
                                color: Colors.white),
                          ))
                    ],
                  ),
                )
              ],
            );
          }

          return Center(
              child: Text(
            'Không có dữ liệu',
            style: TextStyle(fontFamily: 'Roboto Regular', fontSize: 14),
          ));
        },
      ),
    );
  }

  Row RowTextItem(String icon, double sizeicon, String hanhtrinh) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(icon, width: 24, height: 24),
        SizedBox(
          width: 5,
        ),
        Text(
          hanhtrinh,
          style: TextStyle(fontFamily: 'Roboto Medium', fontSize: 14),
        )
      ],
    );
  }
}

class formsuakehoach extends StatelessWidget {
  const formsuakehoach({
    Key key,
    @required this.bienkiemsoatkey,
    @required this.datadsxedukientheokehoach,
    @required this.datadslaixedukientheokehoach,
  }) : super(key: key);

  final GlobalKey<FormState> bienkiemsoatkey;
  final DSXeDuKienTheoKeHoach datadsxedukientheokehoach;
  final DSLaiXeDuKienTheoKeHoach datadslaixedukientheokehoach;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: bienkiemsoatkey,
        child: Column(
          children: [
            DropdownButtonFormField(
              decoration: InputDecoration(labelText: 'Biển kiểm soát(*)'),
              items: datadsxedukientheokehoach.data.map((text) {
                return new DropdownMenuItem(
                  child: Container(
                      child: Text(text.bienKiemSoat,
                          style: TextStyle(
                              fontFamily: 'Roboto Regular', fontSize: 16))),
                  value: text.bienKiemSoat,
                );
              }).toList(),
              // value: 'Bến xe Hà Nam',
              onChanged: (value) {},
              hint: Text('Chọn biển kiểm soát',
                  style: TextStyle(fontFamily: 'Roboto Regular', fontSize: 14)),
              menuMaxHeight: 200,
              validator: (vl1) {
                if (vl1 == null || vl1.isEmpty) {
                  return 'Chưa chọn biển kiểm soát';
                }
                return null;
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
            DropdownButtonFormField(
              decoration:
                  InputDecoration(labelText: 'Lái xe tiếp nhận lệnh(*)'),
              items: datadslaixedukientheokehoach.data.map((text) {
                return new DropdownMenuItem(
                  child: Container(
                      child: Text(text.hoTen,
                          style: TextStyle(
                              fontFamily: 'Roboto Regular', fontSize: 16))),
                  value: text.dienThoai,
                );
              }).toList(),
              // value: 'Bến xe Hà Nam',
              onChanged: (value) {},
              hint: Text('Chọn lái xe',
                  style: TextStyle(fontFamily: 'Roboto Regular', fontSize: 14)),
              menuMaxHeight: 400,
              validator: (vl1) {
                if (vl1 == null) {
                  return 'Chưa chọn lái xe tiếp nhận lệnh';
                }
                return null;
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
          ],
        ));
  }
}
