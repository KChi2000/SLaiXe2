import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';

import 'package:slaixe2/Model/DSLaiXeDuKienTheoKeHoach.dart';
import 'package:slaixe2/Model/DanhSachKeHoach.dart';
import 'package:slaixe2/Routes.dart';
import 'package:slaixe2/components/multiselectwithChip.dart';
import 'package:slaixe2/extensions/extensions.dart';
import 'package:slaixe2/helpers/ApiHelper.dart';
import 'package:slaixe2/lenh/LenhVanChuyen.dart';
import 'package:slaixe2/servicesAPI.dart';
import '../Model/ChiTietKeHoach.dart';
import '../Model/DSXeDuKienTheoKeHoach.dart';

class SuaKeHoach extends StatefulWidget {
  SuaKeHoach(this.time, this.lotrinh, this.tenbenxedi, this.idkehoach,
      this.tungay, this.denngay, this.iddnvtxe, this.listdslaixe);
  String time;
  String lotrinh;
  String tenbenxedi;
  String idkehoach;
  String tungay;
  String denngay;
  String iddnvtxe;

  List<ThongTinLaiXe> listdslaixe;
  @override
  State<SuaKeHoach> createState() => _SuaKeHoachState();
}

class _SuaKeHoachState extends State<SuaKeHoach> {
  var phuxeController = TextEditingController();
  final laixetiepnhanlenhkey = GlobalKey<FormState>();
  final bienkiemsoatkey = GlobalKey<FormState>();
  DSXeDuKienTheoKeHoach datadsxedukientheokehoach;
  DSLaiXeDuKienTheoKeHoach datadslaixedukientheokehoach;
  ChiTietKeHoach datachitietkehoach;
  bool showList = false;
  String iddnvtxe;
  String laixechinh = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    iddnvtxe = widget.iddnvtxe;
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

  suakehoach(List<String> iddnvtlaixe) async {
    var postdata = await ApiHelper.post(apiSuaKeHoach.suakehoach, {
      'HoTenPhuXe': phuxeController.text,
      'IdDnvtLaiXes': iddnvtlaixe,
      'IdDnvtXe': iddnvtxe,
      'IdKeHoach': widget.idkehoach
    });
    return postdata;
  }

  int findIndex(ThongTinLaiXe e) {
    return datadslaixedukientheokehoach.data
        .indexWhere((element) => element.dienThoai == e.dienThoai);
  }

  void setInitValuePage(List<ThongTinLaiXe> list) {
    if (widget.listdslaixe != null) {
      if (widget.listdslaixe.length > 1) {
        list.addAll(widget.listdslaixe.skip(1));
        datadslaixedukientheokehoach
            .data[findIndex(widget.listdslaixe[1])].check = true;
        if (widget.listdslaixe.length == 3) {
          datadslaixedukientheokehoach
              .data[findIndex(widget.listdslaixe[2])].check = true;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('SỬA KẾ HOẠCH',
            style: TextStyle(
              fontFamily: 'Roboto Regular',
            )),
        centerTitle: true,
      ),
      body: LoaderOverlay(
        useDefaultLoading: false,
        overlayOpacity: 0.6,
        overlayWidget: Center(
          child: CircularProgressIndicator(),
        ),
        child: FutureBuilder(
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
              List<ThongTinLaiXe> selectedlaixedicung = [];

              phuxeController = TextEditingController(
                  text: datachitietkehoach.data.first.hoTenPhuXe == null
                      ? ''
                      : datachitietkehoach.data.first.hoTenPhuXe);
              laixechinh = widget.listdslaixe == null
                  ? null
                  : widget.listdslaixe.first.idDnvtLaiXe;
              List<ThongTinLaiXe> dslaixedicung = datadslaixedukientheokehoach
                  .data
                  .where((element) => element.idDnvtLaiXe != laixechinh)
                  .toList();

              setInitValuePage(selectedlaixedicung);
              return Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
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
                        RowTextItem(
                            'asset/icons/bus-stop.svg', 24, widget.tenbenxedi),
                      ],
                    ),
                    StatefulBuilder(builder: (context, setState) {
                      return Form(
                        key: bienkiemsoatkey,
                        child: DropdownButtonFormField(
                          decoration:
                              InputDecoration(labelText: 'Biển kiểm soát(*)'),
                          items: datadsxedukientheokehoach.data.map((text) {
                            DateTime phuhieuhethan =
                                DateTime.parse(text.phuHieuNgayHetHan)
                                    .toLocal();
                            return new DropdownMenuItem(
                              child: Container(
                                  child: Text(
                                      '${text.bienKiemSoat} (${phuhieuhethan.day}/${phuhieuhethan.month}/${phuhieuhethan.year})',
                                      style: TextStyle(
                                          fontFamily: 'Roboto Regular',
                                          fontSize: 16))),
                              value: text.idDnvtXe,
                            );
                          }).toList(),
                          value: iddnvtxe == null ? null : iddnvtxe,
                          onChanged: (value) {
                            setState(() {
                              iddnvtxe = value;
                            });
                          },
                          hint: Text('Chọn biển kiểm soát',
                              style: TextStyle(
                                  fontFamily: 'Roboto Regular', fontSize: 14)),
                          menuMaxHeight: 200,
                          validator: (vl1) {
                            if (vl1 == null || vl1.isEmpty) {
                              return 'Chưa chọn biển kiểm soát';
                            }
                            return null;
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                      );
                    }),

                    Expanded(
                      child: multiselectwithChip(
                          datadslaixedukientheokehoach.data,
                          laixechinh,
                          selectedlaixedicung,
                         TextFormField(
                              decoration: InputDecoration(labelText: 'Phụ xe'),
                              controller: phuxeController,
                              inputFormatters: [],
                              validator: (value) {},
                              onChanged: (value) {
                                print('aaaa');
                              },
                            ),
                         
                          laixetiepnhanlenhkey),
                    ),

                    // Spacer(),
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
                              onPressed: () async {
                                laixetiepnhanlenhkey.currentState.validate();
                                List<String> Iddnvtlaixe = selectedlaixedicung
                                    .map((e) => e.idDnvtLaiXe)
                                    .toList();
                                Iddnvtlaixe.insert(0, laixechinh);
                                print(laixechinh);
                                // if (bienkiemsoatkey.currentState.validate() &&
                                //     laixetiepnhanlenhkey.currentState
                                //         .validate()) {
                                //   context.loaderOverlay.show();
                                //   var res = await suakehoach(Iddnvtlaixe);
                                //   if (res['message'] == 'Thành công') {
                                //     context.loaderOverlay.hide();
                                //    Routes.navigatetoQuanLiLenh(context, storeIDlenh);
                                //   } else {
                                //     context.loaderOverlay.hide();
                                //     showDialog(
                                //       context: context,
                                //       barrierDismissible:
                                //           false, // user must tap button!
                                //       builder: (BuildContext context) {
                                //         return AlertDialog(
                                //           title: const Text('Lỗi',
                                //               style: TextStyle(
                                //                   fontFamily: 'Roboto Regular',
                                //                   fontSize: 18,
                                //                   color: Colors.red)),
                                //           content: Text(res['message'],
                                //               style: TextStyle(
                                //                   fontFamily: 'Roboto Regular',
                                //                   fontSize: 14)),
                                //           actions: <Widget>[
                                //             TextButton(
                                //               child: const Text('Đã hiểu',
                                //                   style: TextStyle(
                                //                       fontFamily:
                                //                           'Roboto Regular',
                                //                       fontSize: 14)),
                                //               onPressed: () {
                                //                 Navigator.of(context).pop();
                                //               },
                                //             ),
                                //           ],
                                //         );
                                //       },
                                //     );
                                //   }
                                // }
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
                ),
              );
            }

            return Center(
                child: Text(
              'Không có dữ liệu',
              style: TextStyle(fontFamily: 'Roboto Regular', fontSize: 14),
            ));
          },
        ),
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
