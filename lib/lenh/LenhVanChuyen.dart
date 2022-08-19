import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:slaixe2/InnerShadow.dart';
import 'package:slaixe2/Model/DSChuyendi.dart';
import 'package:slaixe2/Model/DSChuyendiDuKien.dart';
import 'package:slaixe2/Model/DSDaCapLenh.dart';
import 'package:slaixe2/helpers/ApiHelper.dart';

import 'package:slaixe2/lenh/KiLenh.dart';
import 'package:slaixe2/lenh/SuaKeHoach.dart';
import 'package:slaixe2/servicesAPI.dart';

import '../components/itemListView.dart';
import '../extensions/extensions.dart';

class LenhVanChuyen extends StatefulWidget {
  const LenhVanChuyen({Key key}) : super(key: key);

  @override
  State<LenhVanChuyen> createState() => _LenhState();
}

class _LenhState extends State<LenhVanChuyen>
    with SingleTickerProviderStateMixin {
  Size size;
  bool wannaSearch = false;
  bool checkError = false;
  bool showDSChuyenDi = false;
  final formkey = GlobalKey<FormState>();
  DateTime tungay = DateTime.now();
  DateTime tungaytemp = DateTime.now();
  final tungayController = TextEditingController(
      text: DateFormat('dd-MM-yyyy').format(DateTime.now()));
  DateTime denngay = DateTime.now();
  DateTime denngaytemp = DateTime.now();
  final denngayController = TextEditingController(
      text: DateFormat('dd-MM-yyyy').format(DateTime.now()));
  int index = 0;
  AnimationController _controller;
  Animation<Offset> _offsetAnimation;
  var _opacity;
  Map<String, dynamic> requestPayload = {
    'custom': {
      'DenNgay': '',
      'IdDnvtTuyen': null,
      'TuNgay': '',
    },
    'loadOptions': {
      'searchOperation': 'contains',
      'searchValue': null,
      'skip': 0,
      'sort': [
        {'desc': '', 'selector': ''}
      ],
      'take': 10,
      'userData': {}
    },
  };
  final List<String> filterAsCondition = ['Giờ XB', 'BKS', 'Tuyến vận chuyển'];
  final List<DSChuyendi> DSChuyenDi = [
    DSChuyendi('Danh sách chuyến đi dự kiến', Colors.black.withOpacity(0.6)),
    DSChuyendi('Danh sách đã cấp lệnh cho lái xe', Colors.orange),
    DSChuyendi('Danh sách lệnh Đang thực hiện', Colors.blue),
    DSChuyendi('Danh sách lệnh Đã hoàn thành', Colors.green),
    DSChuyendi('Danh sách lệnh Không hoàn thành', Colors.red),
  ];
  final List<DSChuyendiDuKien> dschuyendidukien = [
    DSChuyendiDuKien(
        '7:30 11/08/2022',
        '20B-94469',
        'TT TP.Thái Nguyên - Bến xe Mỹ Đình',
        '2029.1113.A',
        'Nguyễn Ngọc Hiếu',
        ''),
    DSChuyendiDuKien(
        '7:30 11/08/2022',
        '20B-94469',
        'TT TP.Thái Nguyên - Bến xe Mỹ Đình',
        '2029.1113.A',
        'Nguyễn Ngọc Hiếu',
        ''),
    DSChuyendiDuKien(
        '7:30 11/08/2022',
        '20B-94469',
        'TT TP.Thái Nguyên - Bến xe Mỹ Đình',
        '2029.1113.A',
        'Nguyễn Ngọc Hiếu',
        ''),
    DSChuyendiDuKien(
        '7:30 11/08/2022',
        '20B-94469',
        'TT TP.Thái Nguyên - Bến xe Mỹ Đình',
        '2029.1113.A',
        'Nguyễn Ngọc Hiếu',
        ''),
    DSChuyendiDuKien(
        '7:30 11/08/2022',
        '20B-94469',
        'TT TP.Thái Nguyên - Bến xe Mỹ Đình',
        '2029.1113.A',
        'Nguyễn Ngọc Hiếu',
        '')
  ];

  List<DSChuyendi> dsCDtemp = [
    DSChuyendi('Danh sách chuyến đi dự kiến', Colors.black.withOpacity(0.6)),
    DSChuyendi('Danh sách đã cấp lệnh cho lái xe', Colors.orange),
    DSChuyendi('Danh sách lệnh Đang thực hiện', Colors.blue),
    DSChuyendi('Danh sách lệnh Đã hoàn thành', Colors.green),
    DSChuyendi('Danh sách lệnh Không hoàn thành', Colors.red),
  ];
  final List<String> dsTuyenVanChuyen = [
    'Tất cả',
    'TT TP. Thái Nguyên - Nam Hà Giang',
  ];

  final List<DSDaCapLenh> dsDaCapLenh = [
    DSDaCapLenh(
        'LVC-0000437/SPCT',
        '07:30 25/07/2022',
        '20B-944698',
        'TT TP.Thái Nguyên - Bến xe Mỹ Đình',
        '2029.1113.A',
        'Hà Chy',
        'Đã ký lệnh',
        'Chờ kích hoạt',
        'Chưa có chuyến đi bán vé'),
    DSDaCapLenh(
        'LVC-0000437/SPCT',
        '07:30 25/07/2022',
        '20B-944698',
        'TT TP.Thái Nguyên - Bến xe Mỹ Đình',
        '2029.1113.A',
        'Hà Chy',
        'Đã ký lệnh',
        'Chờ kích hoạt',
        'Chưa có chuyến đi bán vé'),
    DSDaCapLenh(
        'LVC-0000437/SPCT',
        '07:30 25/07/2022',
        '20B-944698',
        'TT TP.Thái Nguyên - Bến xe Mỹ Đình',
        '2029.1113.A',
        'Hà Chy',
        'Đã ký lệnh',
        'Chờ kích hoạt',
        'Chưa có chuyến đi bán vé'),
    DSDaCapLenh(
        'LVC-0000437/SPCT',
        '07:30 25/07/2022',
        '20B-944698',
        'TT TP.Thái Nguyên - Bến xe Mỹ Đình',
        '2029.1113.A',
        'Hà Chy',
        'Đã ký lệnh',
        'Chờ kích hoạt',
        'Chưa có chuyến đi bán vé'),
  ];
  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    super.initState();
    loaddskehoach();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future loaddskehoach() async {
    ApiHelper.postMultipart(
      apilenh.apidskehoach,requestPayload
    );
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: wannaSearch
            ? SlideTransition(
                position: _offsetAnimation,
                child: FadeTransition(
                  opacity: _controller,
                  child: Container(
                      // height: 30,
                      width: 260,
                      // color: Colors.black,
                      child: TextFormField(
                        cursorColor: Colors.white,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Roboto Regular',
                            fontSize: 14),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Nhập từ khóa tìm kiếm...',
                            hintStyle: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Roboto Regular',
                                fontSize: 14)),
                      )),
                ),
              )
            : AnimatedContainer(
                duration: Duration(seconds: 2),
                curve: Curves.easeIn,
                child: Text(
                  'LỆNH VẬN CHUYỂN',
                  style: TextStyle(fontSize: 16),
                ),
              ),
        centerTitle: !wannaSearch,
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  wannaSearch = !wannaSearch;
                  _offsetAnimation = Tween<Offset>(
                          begin: Offset(-1.5, 0.0), end: Offset(0.0, 0.0))
                      .animate(CurvedAnimation(
                          parent: _controller, curve: Curves.easeIn));
                  // _opacity = Tween(begin: 0.0, end: 1.0).animate(_controller);
                  _controller.forward(from: 0);
                });
              },
              icon: Icon(wannaSearch ? Icons.close : Icons.search)),
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return StatefulBuilder(builder: (context, setStateModal) {
                        return Container(
                          padding: EdgeInsets.all(15),
                          height: 500,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: size.width * 0.32),
                                    child: Text('Lọc dữ liệu',
                                        style: TextStyle(
                                            fontFamily: 'Roboto Medium',
                                            fontSize: 18)),
                                  ),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: IconButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            icon: SvgPicture.asset(
                                                'asset/icons/filter-variant-remove.svg')),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              DropdownButtonFormField(
                                decoration:
                                    InputDecoration(labelText: 'Trạng thái(*)'),
                                items: DSChuyenDi.map((DSChuyendi text) {
                                  return new DropdownMenuItem(
                                    child: Container(
                                        child: Text(text.title,
                                            style: TextStyle(fontSize: 15))),
                                    value: text.title,
                                  );
                                }).toList(),
                                hint: Text('Chọn trạng thái',
                                    style: TextStyle(
                                        fontFamily: 'Roboto Regular',
                                        fontSize: 14)),
                                value: 'Danh sách chuyến đi dự kiến',
                                onChanged: (t1) {
                                  setState(() {
                                    // tinh = t1;
                                  });
                                },
                                validator: (vl1) {
                                  if (vl1 == null || vl1.isEmpty) {
                                    return 'Chưa chọn trạng thái';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 10,
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
                                                DateFormat('dd-MM-yyyy')
                                                    .format(tungay);
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
                                      SizedBox(
                                        height: 10,
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
                                                DateFormat('dd-MM-yyyy')
                                                    .format(denngay);
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
                                height: 10,
                              ),
                              DropdownButtonFormField(
                                decoration: InputDecoration(
                                    labelText: 'Tuyến vận chuyển'),
                                items: dsTuyenVanChuyen.map((text) {
                                  return new DropdownMenuItem(
                                    child: Container(
                                        child: Text(text,
                                            style: TextStyle(fontSize: 15))),
                                    value: text,
                                  );
                                }).toList(),
                                value: 'Tất cả',
                                onChanged: (t1) {
                                  setState(() {
                                    // tinh = t1;
                                  });
                                },
                                hint: Text('Chọn tuyến vận chuyển',
                                    style: TextStyle(
                                        fontFamily: 'Roboto Regular',
                                        fontSize: 14)),
                                menuMaxHeight: 200,
                                validator: (vl1) {
                                  if (vl1 == null || vl1.isEmpty) {
                                    return 'Chưa chọn trạng thái';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 25),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                        onPressed: !checkError
                                            ? () {
                                                print(tungay.day <
                                                    DateTime.now().day);
                                              }
                                            : null,
                                        child: Text(
                                          'XÁC NHẬN',
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
                      });
                    });
              },
              icon: Icon(Icons.filter_list))
        ],
      ),
      body: Container(
        // padding: EdgeInsets.all(10),
        width: size.width,
        // height: size.height,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: EdgeInsets.only(left: 10),
                child: Wrap(
                  children: [
                    ...filterAsCondition.map((e) => InkWell(
                          onTap: () {},
                          child: GestureDetector(
                            onTap: () {},
                            child: InnerShadow(
                              blur: 4,
                              color: Colors.grey.withOpacity(0.4),
                              offset: const Offset(0.4, 0.4),
                              child: Container(
                                  margin: EdgeInsets.only(right: 10, top: 10),
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.swap_vert,
                                        color: Colors.black.withOpacity(0.7),
                                        size: 14,
                                      ),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      Text(
                                        e,
                                        style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.7),
                                            fontFamily: 'Roboto Regular',
                                            fontSize: 14),
                                      )
                                    ],
                                  )),
                            ),
                          ),
                        ))
                  ],
                ),
              ),
            ),
            Divider(
              thickness: 1,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  showDSChuyenDi = !showDSChuyenDi;
                });
              },
              child: Container(
                width: size.width * 0.9,
                height: 40,
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 1),
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 4)
                ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          if (index > 0) {
                            setState(() {
                              index--;
                            });
                          }
                        },
                        icon: Icon(Icons.arrow_circle_left_outlined)),
                    Text(
                      DSChuyenDi[index].title,
                      style: TextStyle(
                          color: DSChuyenDi[index].color,
                          fontFamily: 'Roboto Bold',
                          fontSize: 14),
                    ),
                    IconButton(
                        onPressed: () {
                          if (index < DSChuyenDi.length - 1) {
                            setState(() {
                              index++;
                            });
                          }
                        },
                        icon: Icon(Icons.arrow_circle_right_outlined)),
                  ],
                ),
              ),
            ),
            FutureBuilder(
                future: loaddskehoach(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Expanded(
                        child: Center(
                      child: CircularProgressIndicator(),
                    ));
                  } else if (snapshot.hasData) {
                    return Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Stack(
                              children: [
                                index == 0
                                    ? ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: dschuyendidukien.length,
                                        itemBuilder: (context, inde) {
                                          return itemChuyenDiDuKien(
                                              dschuyendidukien, index);
                                        })
                                    : index == 1
                                        ? ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemCount: dsDaCapLenh.length,
                                            itemBuilder: (context, inde) {
                                              return itemLenhDaCapChoLaiXe(
                                                  dsDaCapLenh, inde);
                                            })
                                        : Center(
                                            child: Text('Không có dữ liệu aa'),
                                          ),
                                showDSChuyenDi
                                    ? Align(
                                        alignment: Alignment.topCenter,
                                        child: Container(
                                          width: size.width * 0.9,
                                          height: 155,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                    offset: Offset(0, 5),
                                                    color: Colors.grey
                                                        .withOpacity(0.3),
                                                    spreadRadius: 2,
                                                    blurRadius: 5)
                                              ]),
                                          child: ListView.builder(
                                              itemCount: dsCDtemp.length,
                                              itemBuilder: (context, inde) {
                                                return DSChuyenDi[index]
                                                            .title ==
                                                        dsCDtemp[inde].title
                                                    ? SizedBox()
                                                    : GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            index = inde;
                                                          });
                                                          // print(DSChuyenDi[inde].title);
                                                          // print(dsCDtemp[inde].title);
                                                        },
                                                        child: Container(
                                                          width:
                                                              size.width * 0.9,
                                                          height: 40,
                                                          child: Center(
                                                            child: Text(
                                                                dsCDtemp[inde]
                                                                    .title,
                                                                style:
                                                                    TextStyle(
                                                                  color: dsCDtemp[
                                                                          inde]
                                                                      .color,
                                                                  fontFamily:
                                                                      'Roboto Bold',
                                                                  fontSize: 14,
                                                                )),
                                                          ),
                                                        ),
                                                      );
                                              }),
                                        ),
                                      )
                                    : SizedBox()
                              ],
                            ),
                            SizedBox(
                              width: 150,
                              child: ElevatedButton(
                                  onPressed: () {},
                                  child: Text('THÊM',
                                      style: TextStyle(
                                        fontFamily: 'Roboto Bold',
                                        fontSize: 14,
                                      ))),
                            )
                          ],
                        ),
                      ),
                    );
                  }
                  return Expanded(
                    child: Center(
                      child: Text('Không có dữ liệu'),
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }

  Container itemChuyenDiDuKien(
    List<DSChuyendiDuKien> listdata,
    int index,
  ) {
    return Container(
      // width: widthScreen,
      margin: EdgeInsets.only(right: 18, left: 18, top: 10, bottom: 10),

      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                offset: Offset(0, 4),
                blurRadius: 5,
                spreadRadius: 1)
          ]),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Column(
              children: [
                itemListView(
                    title: '${listdata[index].datetime}',
                    icon: 'asset/icons/calendar-clock.svg',
                    color: Colors.black,
                    underline: false),
                SizedBox(
                  height: 8,
                ),
                itemListView(
                    title: '${listdata[index].biensoxe}',
                    icon: 'asset/icons/card-bulleted-outline.svg',
                    color: Colors.black,
                    underline: false),
                SizedBox(
                  height: 8,
                ),
                itemListView(
                    title:
                        '${listdata[index].hanhtrinh}\n (${listdata[index].sohieuxe})',
                    icon: 'asset/icons/road-variant.svg',
                    color: Colors.black,
                    underline: false),
                SizedBox(
                  height: 8,
                ),
                itemListView(
                    title: listdata[index].tenlaixe.isEmpty
                        ? '(Trống)'
                        : '${listdata[index].tenlaixe}',
                    icon: 'asset/icons/steering.svg',
                    color: Colors.blue,
                    underline: false),
                SizedBox(
                  height: 8,
                ),
                itemListView(
                    title: listdata[index].tenphuxe.isEmpty
                        ? '(Trống)'
                        : '${listdata[index].tenphuxe}',
                    icon: 'asset/icons/account-tie-outline.svg',
                    color: Colors.black,
                    underline: false),
              ],
            ),
          ),
          SizedBox(
            height: 8,
          ),
          SizedBox(
            height: 10,
          ),
          Divider(
            thickness: 1,
            height: 1,
          ),
          IntrinsicHeight(
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SuaKeHoach()));
                  },
                  child: Container(
                    height: 40,
                    width: (size.width - 53) / 2,
                    child: Center(
                      child: Text('SỬA KẾ HOẠCH',
                          style: TextStyle(
                              fontFamily: 'Roboto Medium',
                              fontSize: 14,
                              letterSpacing: 1.25,
                              color: Colors.orange)),
                    ),
                  ),
                ),
                VerticalDivider(
                  thickness: 1,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => KiLenh()));
                  },
                  child: Container(
                    width: (size.width - 53) / 2,
                    height: 40,
                    child: Center(
                      child: Text('KÝ LỆNH',
                          style: TextStyle(
                              fontFamily: 'Roboto Medium',
                              fontSize: 14,
                              letterSpacing: 1.25,
                              color: Colors.blue)),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Container itemLenhDaCapChoLaiXe(List<DSDaCapLenh> list, int index) {
    return Container(
      margin: EdgeInsets.only(right: 18, left: 18, top: 10, bottom: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                offset: Offset(0, 4),
                blurRadius: 5,
                spreadRadius: 1)
          ]),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Column(
              children: [
                itemListView(
                    title: '${list[index].lenhvanchuyen}',
                    icon: 'asset/icons/script-text-outline.svg',
                    color: Colors.blue,
                    underline: true),
                SizedBox(
                  height: 8,
                ),
                itemListView(
                    title: '${list[index].datetime}',
                    icon: 'asset/icons/calendar-clock.svg',
                    color: Colors.black,
                    underline: false),
                SizedBox(
                  height: 8,
                ),
                itemListView(
                    title: '${list[index].biensoxe}',
                    icon: 'asset/icons/card-bulleted-outline.svg',
                    color: Colors.black,
                    underline: false),
                SizedBox(
                  height: 8,
                ),
                itemListView(
                    title:
                        '${list[index].hanhtrinhchay}(${list[index].sohieuxe})',
                    icon: 'asset/icons/road-variant.svg',
                    color: Colors.black,
                    underline: false),
                SizedBox(
                  height: 8,
                ),
                itemListView(
                    title: list[index].tenlaixe.isEmpty
                        ? '(Trống)'
                        : '${list[index].tenlaixe}',
                    icon: 'asset/icons/steering.svg',
                    color: Colors.blue,
                    underline: false),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    //  itemListView(list[index].trangthailenh, 'asset/icons/list-status.svg', Colors.green, false),
                    Row(
                      children: [
                        SvgPicture.asset('asset/icons/list-status.svg',
                            width: 24, height: 24),
                        SizedBox(
                          width: 10,
                        ),
                        Text('${list[index].trangthailenh}',
                            maxLines: 10,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.green,
                                fontFamily: 'Roboto Medium',
                                fontSize: 14)),
                        Text(' - ',
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Roboto Medium',
                                fontSize: 14))
                      ],
                    ),
                    Text(list[index].trangthaicho,
                        style: TextStyle(
                            color: Colors.orange,
                            fontFamily: 'Roboto Medium',
                            fontSize: 14))
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                itemListView(
                    title: '${list[index].trangthaibanve}',
                    icon: 'asset/icons/ticket-confirmation-outline.svg',
                    color: Colors.red,
                    underline: false),
              ],
            ),
          ),
          SizedBox(
            height: 8,
          ),
          SizedBox(
            height: 10,
          ),
          Divider(
            thickness: 1,
            height: 1,
          ),
          IntrinsicHeight(
            child: Row(
              children: [
                InkWell(
                  onTap: () {},
                  child: Container(
                    width: (size.width - 53) / 2,
                    height: 40,
                    child: Center(
                      child: Text('HỦY LỆNH',
                          style: TextStyle(
                              fontFamily: 'Roboto Medium',
                              fontSize: 14,
                              letterSpacing: 1.25,
                              color: Colors.red)),
                    ),
                  ),
                ),
                VerticalDivider(
                  thickness: 1,
                ),
                InkWell(
                  onTap: () {
                    print('giug');
                  },
                  hoverColor: Colors.orange,
                  highlightColor: Colors.orange,
                  child: Container(
                    width: (size.width - 53) / 2,
                    height: 40,
                    child: Center(
                      child: Text('KÝ LẠI LỆNH',
                          style: TextStyle(
                              fontFamily: 'Roboto Medium',
                              fontSize: 14,
                              letterSpacing: 1.25,
                              color: Colors.blue)),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
