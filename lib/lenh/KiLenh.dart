import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:slaixe2/Model/ChuyenDiTrongNgay.dart';
import 'package:slaixe2/Model/postkilenhmodel.dart';
import 'package:slaixe2/components/bottomsheet.dart';
import 'package:slaixe2/components/multiselectwithChip.dart';
import 'package:slaixe2/servicesAPI.dart';
import '../Model/ChiTietKeHoach.dart';
import '../Model/DSLaiXeDuKienTheoKeHoach.dart';
import '../Model/DSXeDuKienTheoKeHoach.dart';
import '../extensions/extensions.dart';
import '../helpers/ApiHelper.dart';

double paddingkilenh = 16.0;

class KiLenh extends StatefulWidget {
  KiLenh(this.time, this.lotrinh, this.tenbenxedi, this.idkehoach,
      this.iddnvtxe, this.listdslaixe, this.iddnvttuyen, this.idbenxexuatphat);
  String time;
  String lotrinh;
  String tenbenxedi;
  String idkehoach;
  String iddnvtxe;
  String iddnvttuyen;
  String idbenxexuatphat;
  List<ThongTinLaiXe> listdslaixe;
  @override
  State<KiLenh> createState() => _KiLenhState();
}

class _KiLenhState extends State<KiLenh> {
  int numberdisplay = 10;
  bool checkError = false;
  final formkey = GlobalKey<FormState>();
  TimeOfDay time;
  TimeOfDay timetemp = TimeOfDay.now();
  final timeController = TextEditingController(
      text: '${TimeOfDay.now().hour}:${TimeOfDay.now().minute}');
  var phuxeController = TextEditingController();
  DateTime tungay =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  DateTime tungaytemp =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  final tungayController = TextEditingController(
      text: DateFormat('dd-MM-yyyy').format(DateTime.now()));
  DateTime denngay =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  DateTime denngaytemp =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  final denngayController = TextEditingController(
      text: DateFormat('dd-MM-yyyy').format(DateTime.now()));
  String iddnvtxe;
  final laixetiepnhanlenhkey = GlobalKey<FormState>();
  final bienkiemsoatkey = GlobalKey<FormState>();

  List<Data> listCDTemp = [];
  DSXeDuKienTheoKeHoach datadsxedukientheokehoach;
  DSLaiXeDuKienTheoKeHoach datadslaixedukientheokehoach;
  ChiTietKeHoach datachitietkehoach;
  String laixechinh = '';
  bool selectALl = false;
  final buttonsetState = GlobalKey();
  final passController = TextEditingController();
  final passKey = GlobalKey<FormState>();
  bool hide = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    iddnvtxe = widget.iddnvtxe;
    laixechinh = widget.listdslaixe == null
        ? null
        : widget.listdslaixe.first.idDnvtLaiXe;

    loadapi();
  }

  Future loadapi() async {
    datadsxedukientheokehoach = DSXeDuKienTheoKeHoach.fromJson(
        await ApiHelper.get(apiSuaKeHoach.apidsxedukien(widget.idkehoach)));
    datadslaixedukientheokehoach = DSLaiXeDuKienTheoKeHoach.fromJson(
        await ApiHelper.get(apiSuaKeHoach.apidslaixedukien(widget.idkehoach)));
    await loadchitietkehoach();
  }

  Future loadchitietkehoach() async {
    datachitietkehoach = ChiTietKeHoach.fromJson(await ApiHelper.get(
        apiSuaKeHoach.apidchitietkehoach(tungay.toUtc().toIso8601String(),
            denngay.toUtc().toIso8601String(), widget.idkehoach)));
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
        title: Text('KÝ LỆNH CỐ ĐỊNH THÔNG TIN',
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
            time = TimeOfDay(
                hour: int.parse(widget.time.substring(0, 1)),
                minute: int.parse(widget.time.substring(3, 5)));
            timeController.text =
                widget.time.substring(0, widget.time.length - 3);
            phuxeController = TextEditingController(
                text: datachitietkehoach.data.first.hoTenPhuXe == null
                    ? ''
                    : datachitietkehoach.data.first.hoTenPhuXe);
            List<ThongTinLaiXe> selectedlaixedicung = [];

            List<ThongTinLaiXe> dslaixedicung = datadslaixedukientheokehoach
                .data
                .where((element) => element.idDnvtLaiXe != laixechinh)
                .toList();

            setInitValuePage(selectedlaixedicung);
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.all(16),
                      width: size.width,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          RowTextItem('asset/icons/road-variant.svg', 24,
                              widget.lotrinh),
                          SizedBox(
                            height: 5,
                          ),
                          RowTextItem('asset/icons/bus-stop.svg', 24,
                              widget.tenbenxedi),
                          SizedBox(
                            height: paddingkilenh,
                          ),
                          StatefulBuilder(builder: (context, setState) {
                            return TextField(
                              controller: timeController,
                              decoration: InputDecoration(
                                isDense: true,
                                labelText: 'Giờ xuất bến KH',
                                suffixIcon: Icon(
                                  Icons.alarm,
                                  size: 24,
                                ),
                                // contentPadding: EdgeInsets.zero
                              ),
                              onTap: () async {
                                FocusScope.of(context)
                                    .requestFocus(new FocusNode());
                                time = await showTimePicker(
                                    context: context,
                                    initialTime: time,
                                    hourLabelText: 'Giờ',
                                    minuteLabelText: 'phút');

                                if (time == null) {
                                  setState(() {
                                    time = timetemp;
                                  });
                                } else {
                                  setState(() {
                                    timetemp = time;
                                  });
                                }

                                setState(() {
                                  timeController.text =
                                      '${time.hour}:${time.minute.toString().padLeft(2, '0')}';
                                });
                              },
                            );
                          }),
                          SizedBox(
                            height: paddingkilenh,
                          ),
                          DropdownButtonFormField(
                            decoration: InputDecoration(
                                labelText: 'Biển kiểm soát(*)',
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 6),
                                isDense: true),
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
                            onChanged: (value) {},
                            hint: Text('Chọn biển kiểm soát',
                                style: TextStyle(
                                    fontFamily: 'Roboto Regular',
                                    fontSize: 14)),
                            menuMaxHeight: 200,
                            validator: (vl1) {
                              return null;
                            },
                          ),
                          multiselectwithChip(
                              datadslaixedukientheokehoach.data,
                              laixechinh,
                              selectedlaixedicung,
                              Column(
                                children: [
                                  TextFormField(
                                    decoration: InputDecoration(
                                      labelText: 'Phụ xe',
                                      isDense: true,
                                      contentPadding:
                                          EdgeInsets.symmetric(vertical: 6),
                                    ),
                                    controller: phuxeController,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(50)
                                    ],
                                    onChanged: (value) {},
                                  ),
                                  SizedBox(
                                    height: paddingkilenh,
                                  ),
                                  StatefulBuilder(
                                      builder: (context, setstateall) {
                                    return Column(
                                      children: [
                                        StatefulBuilder(
                                            builder: (context, setState) {
                                          return Form(
                                              key: formkey,
                                              child: Column(
                                                children: [
                                                  TextFormField(
                                                    controller:
                                                        tungayController,
                                                    decoration: InputDecoration(
                                                      isDense: true,
                                                      labelText: 'Từ ngày(*)',
                                                      suffixIcon: Icon(
                                                        Icons.calendar_month,
                                                        size: 24,
                                                      ),
                                                      contentPadding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 6),
                                                    ),
                                                    autovalidateMode:
                                                        AutovalidateMode
                                                            .onUserInteraction,
                                                    onTap: () async {
                                                      FocusScope.of(context)
                                                          .requestFocus(
                                                              new FocusNode());
                                                      tungay =
                                                          await showDatePicker(
                                                              context: context,
                                                              initialDate:
                                                                  tungaytemp,
                                                              firstDate:
                                                                  DateTime(
                                                                      1900),
                                                              lastDate:
                                                                  DateTime(
                                                                      3000));
                                                      if (tungay == null) {
                                                        setState(() {
                                                          tungay = tungaytemp;
                                                        });
                                                      } else {
                                                        tungaytemp = tungay;
                                                        if (formkey.currentState
                                                            .validate()) {
                                                          loadchitietkehoach();
                                                          setstateall(
                                                            () {},
                                                          );
                                                        }
                                                      }
                                                      setState(() {
                                                        tungayController
                                                            .text = DateFormat(
                                                                'dd-MM-yyyy')
                                                            .format(tungay);
                                                      });
                                                      print(tungay
                                                          .toUtc()
                                                          .toIso8601String());
                                                    },
                                                    validator: (value) {
                                                      if (tungay.day <
                                                          DateTime.now().day) {
                                                        checkError = true;

                                                        return 'Ký từ ngày không được nhỏ hơn ngày hiện tại';
                                                      } else if (tungay.day >
                                                          denngay.day) {
                                                        checkError = true;
                                                        return 'Ký từ ngày không được nhỏ hơn Ký đến ngày';
                                                      } else {
                                                        checkError = false;

                                                        return null;
                                                      }
                                                    },
                                                  ),
                                                  SizedBox(
                                                    height: paddingkilenh,
                                                  ),
                                                  TextFormField(
                                                    controller:
                                                        denngayController,
                                                    decoration: InputDecoration(
                                                      isDense: true,
                                                      labelText: 'Đến ngày(*)',
                                                      suffixIcon: Icon(
                                                        Icons.calendar_month,
                                                        size: 24,
                                                      ),
                                                      contentPadding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 6),
                                                    ),
                                                    autovalidateMode:
                                                        AutovalidateMode
                                                            .onUserInteraction,
                                                    onTap: () async {
                                                      FocusScope.of(context)
                                                          .requestFocus(
                                                              new FocusNode());
                                                      denngay =
                                                          await showDatePicker(
                                                              context: context,
                                                              initialDate:
                                                                  denngaytemp,
                                                              firstDate:
                                                                  DateTime(
                                                                      1900),
                                                              lastDate:
                                                                  DateTime(
                                                                      3000));
                                                      if (denngay == null) {
                                                        denngay = denngaytemp;
                                                      } else {
                                                        denngaytemp = denngay;

                                                        if (formkey.currentState
                                                            .validate()) {
                                                          loadchitietkehoach();
                                                          setstateall(
                                                            () {},
                                                          );
                                                        }
                                                      }
                                                      setState(() {
                                                        denngayController
                                                            .text = DateFormat(
                                                                'dd-MM-yyyy')
                                                            .format(denngay);
                                                      });
                                                    },
                                                    validator: (value) {
                                                      if (denngay.day <
                                                              tungay.day ||
                                                          denngay.month <
                                                              tungay.month ||
                                                          denngay.year <
                                                              tungay.year) {
                                                        checkError = true;

                                                        return 'Ký đến ngày không được nhỏ hơn Ký từ ngày';
                                                      } else {
                                                        checkError = false;

                                                        return null;
                                                      }
                                                    },
                                                  ),
                                                ],
                                              ));
                                        }),
                                        SizedBox(
                                          height: paddingkilenh,
                                        ),
                                        Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                                'Danh sách chuyến đi trong ngày',
                                                style: TextStyle(
                                                    fontFamily: 'Roboto Medium',
                                                    fontSize: 14))),
                                        SizedBox(
                                          height: paddingkilenh,
                                        ),
                                        FutureBuilder(
                                            future: loadchitietkehoach(),
                                            builder: (context, snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                return CircularProgressIndicator();
                                              } else if (datachitietkehoach
                                                          .message ==
                                                      'Thành công' &&
                                                  datachitietkehoach.data !=
                                                      null) {
                                                return StatefulBuilder(
                                                    // key: listStatekey,
                                                    builder:
                                                        (context, setState) {
                                                  return Column(
                                                    children: [
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Checkbox(
                                                              value: selectALl,
                                                              onChanged:
                                                                  (value) {
                                                                setState(() {
                                                                  selectALl =
                                                                      value;
                                                                  int count = numberdisplay <=
                                                                          datachitietkehoach
                                                                              .data
                                                                              .length
                                                                      ? numberdisplay
                                                                      : datachitietkehoach
                                                                          .data
                                                                          .length;
                                                                  for (int i =
                                                                          0;
                                                                      i < count;
                                                                      i++) {
                                                                    setState(
                                                                      () {
                                                                        datachitietkehoach
                                                                            .data[i]
                                                                            .checked = value;
                                                                      },
                                                                    );
                                                                  }

                                                                  listCDTemp = datachitietkehoach
                                                                      .data
                                                                      .where((element) =>
                                                                          element
                                                                              .checked ==
                                                                          true)
                                                                      .toList();
                                                                  buttonsetState
                                                                      .currentState
                                                                      .setState(
                                                                          () {});
                                                                });
                                                              }),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Container(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      vertical:
                                                                          13),
                                                              width:
                                                                  size.width *
                                                                      0.7,
                                                              child: Text(
                                                                'Tất cả',
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'Roboto Regular',
                                                                    fontSize:
                                                                        14),
                                                              ))
                                                        ],
                                                      ),
                                                      SizedBox(
                                                          width:
                                                              size.width * 0.8,
                                                          child: Divider(
                                                            color: Colors.grey,
                                                          )),
                                                      ListView.builder(
                                                          shrinkWrap: true,
                                                          physics:
                                                              NeverScrollableScrollPhysics(),
                                                          itemCount: numberdisplay <=
                                                                  datachitietkehoach
                                                                      .data
                                                                      .length
                                                              ? numberdisplay
                                                              : datachitietkehoach
                                                                  .data.length,
                                                          itemBuilder:
                                                              (context, index) {
                                                            return itemListCD(
                                                                datachitietkehoach
                                                                    .data,
                                                                index,
                                                                size,
                                                                setState);
                                                          }),
                                                      numberdisplay <=
                                                              datachitietkehoach
                                                                  .data.length
                                                          ? SizedBox(
                                                              width: 100,
                                                              child:
                                                                  ElevatedButton(
                                                                onPressed: () {
                                                                  setState(
                                                                    () {
                                                                      numberdisplay +=
                                                                          10;
                                                                    },
                                                                  );
                                                                },
                                                                child: Text(
                                                                  'THÊM',
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'Roboto Medium',
                                                                      letterSpacing:
                                                                          1.25,
                                                                      fontSize:
                                                                          14),
                                                                ),
                                                              ),
                                                            )
                                                          : SizedBox()
                                                    ],
                                                  );
                                                });
                                              }
                                              return Text('no more');
                                            })
                                      ],
                                    );
                                  })
                                ],
                              ),
                              laixetiepnhanlenhkey),
                        ],
                      ),
                    ),
                  ),
                ),
                StatefulBuilder(
                    key: buttonsetState,
                    builder: (context, setState) {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        decoration: BoxDecoration(
                            border: Border(
                                top: BorderSide(
                                    width: 1,
                                    color: Colors.grey.withOpacity(0.3)))),
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
                                onPressed: listCDTemp.length != 0
                                    ? () {
                                        showModalBottomSheet(
                                            context: context,
                                            builder: (context) {
                                              return StatefulBuilder(
                                                  builder: (context, setState) {
                                                return Container(
                                                  padding: EdgeInsets.only(
                                                      top: 24,
                                                      right: 16,
                                                      left: 16,
                                                      bottom: 8),
                                                  // color: Colors.pink,
                                                  height: 180,
                                                  width: size.width,
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        'Nhập mã bảo mật',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Roboto Bold',
                                                          fontSize: 20,
                                                        ),
                                                      ),
                                                      Form(
                                                        key: passKey,
                                                        child: TextFormField(
                                                          obscureText: hide,
                                                          obscuringCharacter:
                                                              '*',
                                                          controller:
                                                              passController,
                                                          decoration:
                                                              InputDecoration(
                                                                  suffixIcon:
                                                                      IconButton(
                                                                          onPressed:
                                                                              () {
                                                                            setState(
                                                                              () {
                                                                                hide = !hide;
                                                                              },
                                                                            );
                                                                          },
                                                                          icon:
                                                                              Icon(
                                                                            hide
                                                                                ? Icons.visibility_off
                                                                                : Icons.visibility,
                                                                            color:
                                                                                Colors.black,
                                                                          ))),
                                                          validator: (value) {
                                                            if (value.isEmpty ||
                                                                value == null) {
                                                              return 'Mã bảo mật không được để trống';
                                                            }
                                                            return null;
                                                          },
                                                          autovalidateMode:
                                                              AutovalidateMode
                                                                  .onUserInteraction,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          InkWell(
                                                            onTap: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: Text(
                                                              'HỦY',
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'Roboto Medium',
                                                                  fontSize: 14,
                                                                  letterSpacing:
                                                                      1.25,
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                          ),
                                                          ElevatedButton(
                                                              onPressed: () {
                                                                if (passKey
                                                                    .currentState
                                                                    .validate()) {
                                                                  var phuxelist = phuxeController
                                                                      .text
                                                                      .replaceAll(
                                                                          ' ',
                                                                          '')
                                                                      .split(
                                                                          ',');
                                                                  var test = listCDTemp.map((e) => DateTime.parse(e.ngayDuong).toLocal().toUtc().toIso8601String()).toList();
                                                                  test.forEach((element) {print(element);});
                                                                  List<postkilenhmodel> listpost = List.filled(
                                                                      listCDTemp
                                                                          .length,
                                                                      postkilenhmodel(
                                                                          widget
                                                                              .idbenxexuatphat,
                                                                          widget
                                                                              .iddnvttuyen,
                                                                          widget
                                                                              .iddnvtxe,
                                                                          widget
                                                                              .idkehoach,
                                                                          laixechinh,
                                                                          selectedlaixedicung
                                                                              .map((e) => e.idDnvtLaiXe)
                                                                              .toList(),
                                                                          '',
                                                                          '',
                                                                          phuxelist,
                                                                          passController.text));

                                                                 
                                                                  // listpost.forEach(
                                                                  //     (element) {
                                                                  //   print(element
                                                                  //       .IdBenXeXuatPhat);
                                                                  //   print(element
                                                                  //       .IdDnvtTuyen);
                                                                  //   print(element
                                                                  //       .IdKeHoach);
                                                                  //   print(element
                                                                  //       .LaiXeChinh_IdDnvtLaixe);
                                                                  //   print(element
                                                                  //       .LaiXeDiCung_IdDnvtLaixes
                                                                  //       .length);
                                                                  //   print(element
                                                                  //       .maBaoMat);
                                                                  //   print(element
                                                                  //       .PhuXes
                                                                  //       .length);
                                                                  //       print('-------------------');
                                                                  // });
                                                                }
                                                              },
                                                              child: Text(
                                                                'XÁC NHẬN',
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'Roboto Medium',
                                                                    fontSize:
                                                                        14,
                                                                    letterSpacing:
                                                                        1.25,
                                                                    color: Colors
                                                                        .white),
                                                              )),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              });
                                            });
                                      }
                                    : null,
                                child: Text(
                                  'KÝ LỆNH (${listCDTemp.length})',
                                  style: TextStyle(
                                      fontFamily: 'Roboto Medium',
                                      fontSize: 14,
                                      letterSpacing: 1.25,
                                      color: Colors.white),
                                )),
                          ],
                        ),
                      );
                    }),
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

  Row itemListCD(List<Data> list, int index, Size size,
      Function(void Function()) setState) {
    var ngayduong = DateTime.parse(list[index].ngayDuong);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Checkbox(
            value: list[index].checked,
            onChanged: (value) {
              setState(() {
                list[index].checked = value;
                listCDTemp =
                    list.where((element) => element.checked == true).toList();

                buttonsetState.currentState.setState(() {});
              });
            }),
        SizedBox(
          width: 5,
        ),
        Container(
          padding: EdgeInsets.only(top: 8, right: 4, bottom: 8, left: 8),
          width: size.width * 0.7,
          margin: EdgeInsets.only(top: 15),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                    offset: Offset(1, 3),
                    blurRadius: 3,
                    spreadRadius: 2,
                    color: Colors.grey.withOpacity(0.2))
              ]),
          child: Container(
            padding: EdgeInsets.only(top: 16, right: 16, bottom: 8, left: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                itemElement(
                    '${checkDayinWeek(list[index].ngayTrongTuan)}, ngày ${ngayduong.day}/${ngayduong.month}/${ngayduong.year}'),
                SizedBox(
                  height: 5,
                ),
                itemElement(
                    'Lịch âm: ${list[index].ngayAm.day}/${list[index].ngayAm.month}'),
              ],
            ),
          ),
        )
      ],
    );
  }

  checkDayinWeek(int num) {
    switch (num) {
      case 1:
        return 'Thứ Hai';
        break;
      case 2:
        return 'Thứ Ba';
        break;
      case 3:
        return 'Thứ Tư';
        break;
      case 4:
        return 'Thứ Năm';
        break;
      case 5:
        return 'Thứ Sáu';
        break;
      case 6:
        return 'Thứ Bảy';
        break;
      case 0:
        return 'Chủ Nhật';
        break;
      default:
        return 'unknown';
        break;
    }
  }

  Container itemElement(String title) {
    return Container(
      margin: EdgeInsets.only(bottom: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            'asset/icons/calendar-clock.svg',
            width: 24,
            height: 24,
          ),
          SizedBox(
            width: 5,
          ),
          Text(title,
              style: TextStyle(fontFamily: 'Roboto Medium', fontSize: 14))
        ],
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
