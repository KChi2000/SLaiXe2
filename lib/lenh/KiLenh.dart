import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:slaixe2/Model/ChuyenDiTrongNgay.dart';

import '../extensions/extensions.dart';

class KiLenh extends StatefulWidget {
  const KiLenh({Key key}) : super(key: key);

  @override
  State<KiLenh> createState() => _KiLenhState();
}

class _KiLenhState extends State<KiLenh> {
  bool checkError = false;
  final formkey = GlobalKey<FormState>();
  TimeOfDay time = TimeOfDay.now();
  TimeOfDay timetemp = TimeOfDay.now();
  final timeController = TextEditingController(
      text: '${TimeOfDay.now().hour}:${TimeOfDay.now().minute}');
  final phuxeController = TextEditingController();
  DateTime tungay = DateTime.now();
  DateTime tungaytemp = DateTime.now();
  final tungayController = TextEditingController(
      text: DateFormat('dd-MM-yyyy').format(DateTime.now()));
  DateTime denngay = DateTime.now();
  DateTime denngaytemp = DateTime.now();
  final denngayController = TextEditingController(
      text: DateFormat('dd-MM-yyyy').format(DateTime.now()));
  final List<String> dsBienKiemSoat = ['20A-08124 (31/12/2025)'];
  final List<String> dsLaiXe = ['Hà Thị Kim Chi'];
  final List<String> dsLaiXeDiCung = ['Khánh Linh', 'Kim Yến'];
  List<ChuyenDiTrongNgay> dsCDTrongNgay = [
    ChuyenDiTrongNgay('Thứ 2', '15/09/2022', '18/7', false),
    ChuyenDiTrongNgay('Thứ 3', '15/09/2022', '18/7', false),
    ChuyenDiTrongNgay('Thứ 4', '15/09/2022', '18/7', false),
    ChuyenDiTrongNgay('Thứ 4', '15/09/2022', '18/7', false),
    ChuyenDiTrongNgay('Thứ 5', '15/09/2022', '18/7', false),
    ChuyenDiTrongNgay('Thứ 6', '15/09/2022', '18/7', false),
    ChuyenDiTrongNgay('Thứ 7', '15/09/2022', '18/7', false)
  ];
  List<ChuyenDiTrongNgay> listCDTemp = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(15),
                width: size.width,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RowTextItem('asset/icons/road-variant.svg', 24,
                        'TT TP. Thái Nguyên - Nam Hà Giang'),
                    SizedBox(
                      height: 5,
                    ),
                    RowTextItem(
                        'asset/icons/bus-stop.svg', 24, 'TT TP. Thái Nguyên'),
                    TextFormField(
                      controller: timeController,
                      decoration: InputDecoration(
                        isDense: true,
                        labelText: 'Giờ xuất bến KH',
                        suffixIcon: Icon(
                          Icons.alarm,
                          size: 24,
                        ),
                      ),
                      onTap: () async {
                        FocusScope.of(context).requestFocus(new FocusNode());
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
                          timeController.text = '${time.hour}:${time.minute}';
                        });
                      },
                    ),
                    DropdownButtonFormField(
                      decoration:
                          InputDecoration(labelText: 'Biển kiểm soát(*)'),
                      items: dsBienKiemSoat.map((String text) {
                        return new DropdownMenuItem(
                          child: Container(
                              child: Text(text,
                                  style: TextStyle(
                                      fontFamily: 'Roboto Regular',
                                      fontSize: 14))),
                          value: text,
                        );
                      }).toList(),
                      // value: 'Bến xe Hà Nam',
                      onChanged: (value) {},
                      hint: Text('Chọn biển kiểm soát',
                          style: TextStyle(
                              fontFamily: 'Roboto Regular', fontSize: 14)),
                      menuMaxHeight: 200,
                      validator: (vl1) {
                        return null;
                      },
                    ),
                    DropdownButtonFormField(
                      decoration: InputDecoration(
                          labelText: 'Lái xe tiếp nhận lệnh(*)'),
                      items: dsLaiXe.map((String text) {
                        return new DropdownMenuItem(
                          child: Container(
                              child: Text(text,
                                  style: TextStyle(
                                      fontFamily: 'Roboto Regular',
                                      fontSize: 14))),
                          value: text,
                        );
                      }).toList(),
                      // value: 'Bến xe Hà Nam',
                      onChanged: (value) {},
                      hint: Text('Chọn lái xe',
                          style: TextStyle(
                              fontFamily: 'Roboto Regular', fontSize: 14)),
                      menuMaxHeight: 200,
                      validator: (vl1) {
                        return null;
                      },
                    ),
                    DropdownButtonFormField(
                      decoration: InputDecoration(labelText: 'Lái xe đi cùng'),
                      items: dsLaiXeDiCung.map((String text) {
                        return new DropdownMenuItem(
                          child: Container(
                              child: Text(text,
                                  style: TextStyle(
                                      fontFamily: 'Roboto Regular',
                                      fontSize: 16))),
                          value: text,
                        );
                      }).toList(),
                      // value: 'Bến xe Hà Nam',
                      onChanged: (value) {},
                      hint: Text('Lựa chọn...',
                          style: TextStyle(
                              fontFamily: 'Roboto Regular', fontSize: 14)),
                      menuMaxHeight: 200,
                      validator: (vl1) {},
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Phụ xe'),
                      controller: phuxeController,
                      inputFormatters: [],
                      onChanged: (value) {},
                    ),
                    Form(
                        key: formkey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: tungayController,
                              decoration: InputDecoration(
                                isDense: true,
                                labelText: 'Từ ngày(*)',
                                suffixIcon: Icon(
                                  Icons.calendar_month,
                                  size: 24,
                                ),
                              ),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              onTap: () async {
                                FocusScope.of(context)
                                    .requestFocus(new FocusNode());
                                tungay = await showDatePicker(
                                    context: context,
                                    initialDate: tungaytemp,
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime(3000));
                                if (tungay == null) {
                                  setState(() {
                                    tungay = tungaytemp;
                                  });
                                } else {
                                  tungaytemp = tungay;
                                }
                                setState(() {
                                  tungayController.text =
                                      DateFormat('dd-MM-yyyy').format(tungay);
                                });
                              },
                              validator: (value) {
                                if (tungay.day < DateTime.now().day) {
                                  checkError = true;

                                  return 'Ký từ ngày không được nhỏ hơn ngày hiện tại';
                                } else if (tungay.day > denngay.day) {
                                  checkError = true;

                                  return 'Ký từ ngày không được nhỏ hơn Ký đến ngày';
                                } else {
                                  checkError = false;

                                  return null;
                                }
                              },
                            ),
                            TextFormField(
                              controller: denngayController,
                              decoration: InputDecoration(
                                isDense: true,
                                labelText: 'Đến ngày(*)',
                                suffixIcon: Icon(
                                  Icons.calendar_month,
                                  size: 24,
                                ),
                              ),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              onTap: () async {
                                FocusScope.of(context)
                                    .requestFocus(new FocusNode());
                                denngay = await showDatePicker(
                                    context: context,
                                    initialDate: denngaytemp,
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime(3000));
                                if (denngay == null) {
                                  denngay = denngaytemp;
                                } else {
                                  denngaytemp = denngay;
                                }
                                setState(() {
                                  denngayController.text =
                                      DateFormat('dd-MM-yyyy').format(denngay);
                                });
                              },
                              validator: (value) {
                                if (denngay.day < tungay.day) {
                                  checkError = true;

                                  return 'Ký đến ngày không được nhỏ hơn Ký từ ngày';
                                } else {
                                  checkError = false;

                                  return null;
                                }
                              },
                            ),
                          ],
                        )),
                    SizedBox(
                      height: 15,
                    ),
                    Align(
                        alignment: Alignment.topLeft,
                        child: Text('Danh sách chuyến đi trong ngày',
                            style: TextStyle(
                                fontFamily: 'Roboto Medium', fontSize: 14))),
                    SizedBox(
                      height: 10,
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: dsCDTrongNgay.length,
                        itemBuilder: (context, index) {
                          return itemListCD(index, size);
                        }),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 25),
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(
                        width: 1, color: Colors.grey.withOpacity(0.3)))),
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
                    onPressed: !checkError && listCDTemp.length != 0
                        ? () {
                            print(tungay.day < DateTime.now().day);
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
          )
        ],
      ),
    );
  }

  Row itemListCD(int index, Size size) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Checkbox(
            value: dsCDTrongNgay[index].checked,
            onChanged: (value) {
              setState(() {
                dsCDTrongNgay[index].checked = value;
                listCDTemp = dsCDTrongNgay
                    .where((element) => element.checked == true)
                    .toList();
              });
            }),
        SizedBox(
          width: 5,
        ),
        Container(
          padding: EdgeInsets.all(10),
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              itemElement(
                  '${dsCDTrongNgay[index].date}, ngày ${dsCDTrongNgay[index].fulldate}'),
              SizedBox(
                height: 5,
              ),
              itemElement('Lịch âm: ${dsCDTrongNgay[index].lunarCalendar}'),
            ],
          ),
        )
      ],
    );
  }

  Row itemElement(String title) {
    return Row(
      children: [
        SvgPicture.asset(
          'asset/icons/calendar-clock.svg',
          width: 24,
          height: 24,
        ),
        SizedBox(
          width: 5,
        ),
        Text(title, style: TextStyle(fontFamily: 'Roboto Medium', fontSize: 14))
      ],
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
