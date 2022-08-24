import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:slaixe2/InnerShadow.dart';
import 'package:slaixe2/Model/DSChuyendi.dart';
import 'package:slaixe2/Model/DSLenh.dart';
import 'package:collection/collection.dart';
import 'package:slaixe2/Model/DSLuongTuyen.dart';
import 'package:slaixe2/Model/DanhSachKeHoach.dart';
import 'package:slaixe2/Model/lenhModel.dart';
import 'package:slaixe2/helpers/ApiHelper.dart';

import 'package:slaixe2/lenh/KiLenh.dart';
import 'package:slaixe2/lenh/SuaKeHoach.dart';
import 'package:slaixe2/servicesAPI.dart';

import '../components/itemListView.dart';
import '../extensions/extensions.dart';

class LenhVanChuyen extends StatefulWidget {
  String idlenh;
  LenhVanChuyen(this.idlenh);
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
  var convertdatetime = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 0, 0, 0);
  Map<String, dynamic> requestPayload = {};
  final List<String> filterAsCondition = ['Giờ XB', 'BKS', 'Tuyến vận chuyển'];
  final List<DSChuyendi> DSChuyenDi = [
    DSChuyendi('Danh sách chuyến đi dự kiến', Colors.black.withOpacity(0.6)),
    DSChuyendi('Danh sách đã cấp lệnh cho lái xe', Colors.orange),
    DSChuyendi('Danh sách lệnh Đang thực hiện', Colors.blue),
    DSChuyendi('Danh sách lệnh Đã hoàn thành', Colors.green),
    DSChuyendi('Danh sách lệnh Không hoàn thành', Colors.red),
  ];

  List<KeHoach> listkehoach = [];
  List<LenhDataDetail> listlenh = [];
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

  var dslistfuture;
  int skip = 0;
  String typeapi = '';
  String choosefilter = '';
  int stylesort = 0;
  String selector = '';
  var searchController = TextEditingController();
  var luongtuyenapi;
  String trangthaifilter;
  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    _controller.forward(from: 0);
    _offsetAnimation = Tween<Offset>(
            begin: Offset(-1.5, 0.0), end: Offset(0.0, 0.0))
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
    super.initState();

    loadds();
  }

  void setdstoNull() {
    listkehoach = [];
    listlenh = [];
    skip = 0;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void checkWhatFilterIs() {
    if (choosefilter == 'Giờ XB') {
      if (index == 0) {
        setState(() {
          selector = 'Not';
        });
      } else {
        setState(() {
          selector = 'GioXuatBen';
        });
      }
    } else if (choosefilter == 'BKS') {
      setState(() {
        selector = 'BienSoXe';
      });
    } else if (choosefilter == 'Tuyến vận chuyển') {
      setState(() {
        selector = 'TenTuyen';
      });
    }
  }

  void loadds() async {
    checkWhatFilterIs();

    setState(() {
      if (searchController.text == null || searchController.text.isEmpty) {
        print('search null');
        if (stylesort == 0) {
          requestPayload = {
            'custom': {
              'DenNgay': convertdatetime.toUtc().toIso8601String(),
              'IdDnvtTuyen': widget.idlenh,
              'TuNgay': convertdatetime.toUtc().toIso8601String(),
            },
            'loadOptions': {
              'searchOperation': 'contains',
              'searchValue': null,
              'skip': skip,
              'take': 10,
              'userData': {}
            },
          };
        } else {
          requestPayload = {
            'custom': {
              'DenNgay': convertdatetime.toUtc().toIso8601String(),
              'IdDnvtTuyen': widget.idlenh,
              'TuNgay': convertdatetime.toUtc().toIso8601String(),
            },
            'loadOptions': {
              'searchOperation': 'contains',
              'searchValue': null,
              'skip': skip,
              'sort': stylesort == 2
                  ? [
                      {'desc': true, 'selector': selector}
                    ]
                  : [
                      {'desc': false, 'selector': selector}
                    ],
              'take': 10,
              'userData': {}
            },
          };
        }
      } else {
        print('search not null');
        if (stylesort == 0) {
          print('fall into if loop');
          requestPayload = {
            'custom': {
              'DenNgay': convertdatetime.toUtc().toIso8601String(),
              'IdDnvtTuyen': widget.idlenh,
              'TuNgay': convertdatetime.toUtc().toIso8601String(),
            },
            'loadOptions': {
              'filter': [
                ["BienSoXe", "contains", searchController.text],
                "or",
                ["TenTuyen", "contains", searchController.text]
              ],
              'searchOperation': 'contains',
              'searchValue': null,
              'skip': skip,
              'take': 10,
              'userData': {}
            },
          };
        } else {
          print('fall into else');
          requestPayload = {
            'custom': {
              'DenNgay': convertdatetime.toUtc().toIso8601String(),
              'IdDnvtTuyen': widget.idlenh,
              'TuNgay': convertdatetime.toUtc().toIso8601String(),
            },
            'loadOptions': {
              'filter': [
                ["BienSoXe", "contains", searchController.text],
                "or",
                ["TenTuyen", "contains", searchController.text]
              ],
              'searchOperation': 'contains',
              'searchValue': null,
              'skip': skip,
              'sort': stylesort == 2
                  ? [
                      {'desc': true, 'selector': selector}
                    ]
                  : [
                      {'desc': false, 'selector': selector}
                    ],
              'take': 10,
              'userData': {}
            },
          };
        }
      }
      print(searchController.text);
    });
    try {
      checkgettypeAPI();
      dslistfuture = ApiHelper.post(typeapi, requestPayload);
    } catch (ex) {
      dslistfuture = null;
    }
  }

  void checkgettypeAPI() {
    if (index == 0) {
      setState(() {
        typeapi = apilenh.apidskehoach;
      });
    } else if (index == 1) {
      setState(() {
        typeapi = apilenh.apidsdacaplenh;
      });
    } else if (index == 2) {
      setState(() {
        typeapi = apilenh.apidslenhdangthuchien;
      });
    } else if (index == 3) {
      setState(() {
        typeapi = apilenh.apidslenhdahoanthanh;
      });
    } else if (index == 4) {
      setState(() {
        typeapi = apilenh.apidslenhkhonghoanthanh;
      });
    }
  }

  void loaddsluongtuyen() async {
    try {
      luongtuyenapi = ApiHelper.get(apilenh.apidsluongtuyen);
    } catch (ex) {
      luongtuyenapi = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    trangthaifilter = DSChuyenDi.first.title;
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
                        controller: searchController,
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
                        onChanged: (value) {
                          setdstoNull();
                          loadds();
                          print(listlenh.length);
                        },
                      )),
                ),
              )
            : SlideTransition(
                position: _offsetAnimation,
                child: FadeTransition(
                  opacity: _controller,
                  child: Text(
                    'LỆNH VẬN CHUYỂN',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
        centerTitle: !wannaSearch,
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  wannaSearch = !wannaSearch;
                  _controller.forward(from: 0);
                  print(listlenh.length);
                });
              },
              icon: Icon(wannaSearch ? Icons.close : Icons.search)),
          IconButton(
              onPressed: () {
                loaddsluongtuyen();
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return StatefulBuilder(builder: (context, setStateModal) {
                        return FutureBuilder(
                            future: luongtuyenapi,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (snapshot.hasData) {
                                DSLuongTuyen luongtuyendata =
                                    DSLuongTuyen.fromJson(snapshot.data);
                                List<DataLuongTuyen> listluongtuyen =
                                    luongtuyendata.data;
                                listluongtuyen.insert(
                                    0,
                                    DataLuongTuyen('sdsa', 'vb', 'vcc', 'Tất cả', 'cvc', 'vc',
                                        0, 'vc', 'cv', 'cv'));
                                return Container(
                                  padding: EdgeInsets.all(15),
                                  // height: 500,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
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
                                        decoration: InputDecoration(
                                            labelText: 'Trạng thái(*)'),
                                        items:
                                            DSChuyenDi.map((DSChuyendi text) {
                                          return new DropdownMenuItem(
                                            child: Container(
                                                child: Text(text.title,
                                                    style: TextStyle(
                                                        fontSize: 15))),
                                            value: text.title,
                                          );
                                        }).toList(),
                                        hint: Text('Chọn trạng thái',
                                            style: TextStyle(
                                                fontFamily: 'Roboto Regular',
                                                fontSize: 14)),
                                        value: 'Danh sách chuyến đi dự kiến',
                                        onChanged: (t1) {
                                          setStateModal(() {
                                           trangthaifilter = t1;
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
                                                    AutovalidateMode
                                                        .onUserInteraction,
                                                onTap: () async {
                                                  FocusScope.of(context)
                                                      .requestFocus(
                                                          new FocusNode());
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
                                                // validator: (value) {
                                                //   if (tungay.day < DateTime.now().day) {
                                                //     checkError = true;

                                                //     return 'Ký từ ngày không được nhỏ hơn ngày hiện tại';
                                                //   } else if (tungay.day > denngay.day) {
                                                //     checkError = true;

                                                //     return 'Ký từ ngày không được nhỏ hơn Ký đến ngày';
                                                //   } else {
                                                //     checkError = false;

                                                //     return null;
                                                //   }
                                                // },
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
                                                              DateTime(1900),
                                                          lastDate:
                                                              DateTime(3000));
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
                                        menuMaxHeight: 300,
                                        decoration: InputDecoration(
                                            labelText: 'Tuyến vận chuyển'),
                                        items: listluongtuyen.map((text) {
                                          return new DropdownMenuItem(
                                            child: Container(
                                                // width: 200,
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Text('${text.tenTuyen}',
                                                        style: TextStyle(
                                                            fontSize: 14,fontFamily: 'Roboto Regular')),
                                                  ],
                                                )),
                                            value: text.idDnvtTuyen,
                                          );
                                        }).toList(),
                                        // value: 'Tất cả',
                                        onChanged: (t1) {
                                          setState(() {
                                            // tinh = t1;
                                          });
                                        },
                                        hint: Text('Chọn tuyến vận chuyển',
                                            style: TextStyle(
                                                fontFamily: 'Roboto Regular',
                                                fontSize: 14)),
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
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 25),
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
                                                    color: HexColor.fromHex(
                                                        '#D10909')),
                                              ),
                                            ),
                                            ElevatedButton(
                                                onPressed: !checkError
                                                    ? () {
                                                      Navigator.pop(context);
                                                        print(tungayController.text);
                                                        print(denngayController.text);
                                                        print(denngay.toUtc().toIso8601String());
                                                        print(denngay);
                                                        setState((){
                                                          index = 1;
                                                        });
                                                      }
                                                    : null,
                                                child: Text(
                                                  'XÁC NHẬN',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'Roboto Medium',
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
                              return Center(
                                child: Text(''),
                              );
                            });
                      });
                    });
              },
              icon: Icon(Icons.filter_list))
        ],
      ),
      body: Container(
        width: size.width,
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
                          onTap: () {
                            setdstoNull();
                            if (choosefilter == e) {
                              if (stylesort == 2) {
                                setState(() {
                                  choosefilter = '';
                                  stylesort = 0;
                                });
                              } else {
                                setState(() {
                                  stylesort += 1;
                                });
                              }
                            } else if (choosefilter != e) {
                              setState(() {
                                stylesort = 0;
                                choosefilter = e;
                                stylesort += 1;
                              });
                            }
                            loadds();
                          },
                          child: Container(
                              margin: EdgeInsets.only(right: 10, top: 10),
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: choosefilter == e
                                          ? HexColor.fromHex('#03A9F4')
                                          : Colors.grey.withOpacity(0.3),
                                    ),
                                    BoxShadow(
                                      color: Colors.white,
                                      spreadRadius: -1.0,
                                      blurRadius: 4.0,
                                    ),
                                  ],
                                  // color: Colors.white,
                                  border: Border.all(
                                      color: choosefilter == e
                                          ? HexColor.fromHex('#03A9F4')
                                          : Colors.grey.withOpacity(0.3)),
                                  borderRadius: BorderRadius.circular(30)),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  choosefilter == e && stylesort == 1
                                      ? RotatedBox(
                                          quarterTurns: 2,
                                          child: SvgPicture.asset(
                                            'asset/icons/sort-bool-descending.svg',
                                            color: HexColor.fromHex(
                                              '#03A9F4',
                                            ),
                                            width: 14,
                                            height: 14,
                                          ))
                                      : choosefilter == e && stylesort == 2
                                          ? SvgPicture.asset(
                                              'asset/icons/sort-bool-descending.svg',
                                              color: HexColor.fromHex(
                                                '#03A9F4',
                                              ),
                                              width: 14,
                                              height: 14,
                                            )
                                          : Icon(
                                              Icons.swap_vert,
                                              color:
                                                  Colors.black.withOpacity(0.7),
                                              size: 14,
                                            ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Text(
                                    e,
                                    style: TextStyle(
                                        color: choosefilter == e
                                            ? HexColor.fromHex('#03A9F4')
                                            : Colors.black.withOpacity(0.7),
                                        fontFamily: 'Roboto Regular',
                                        fontSize: 14),
                                  )
                                ],
                              )),
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
                            setdstoNull();
                            setState(() {
                              index--;
                              loadds();
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
                            setdstoNull();
                            setState(() {
                              index++;
                              loadds();
                            });
                          }
                        },
                        icon: Icon(Icons.arrow_circle_right_outlined)),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  FutureBuilder(
                      future: dslistfuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        } else if (snapshot.hasData) {
                          print('chay qua day');
                          print(skip);
                          var alldata;
                          List<KeHoach> listkehoachtemp = [];
                          List<LenhDataDetail> listlenhtemp = [];
                          var seen = Set<String>();

                          if (index == 0) {
                            alldata = DanhSachKeHoach.fromJson(snapshot.data);
                            listkehoachtemp.addAll(alldata.data.list);
                            listkehoach = listkehoachtemp
                                .where((element) => seen.add(element.iDKeHoach))
                                .toList();
                          } else {
                            alldata = dsLenh.fromJson(snapshot.data);
                            listlenhtemp.addAll(alldata.data.list);
                            listlenh = listlenhtemp
                                .where(
                                    (element) => seen.add(element.idLenhDienTu))
                                .toList();
                          }

                          if (alldata.data.list.length == 0) {
                            return Center(
                              child: Text('Không có dữ liệu !'),
                            );
                          }

                          return SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                index == 0
                                    ? ListView.builder(
                                        key: const PageStorageKey<String>(
                                            'page'),
                                        // controller: _scrollController,
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: listkehoach.length,
                                        itemBuilder: (context, inde) {
                                          return itemChuyenDiDuKien(
                                              listkehoach, inde);
                                        })
                                    : index == 1
                                        ? ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemCount: listlenh.length,
                                            itemBuilder: (context, inde) {
                                              return itemLenhDaCapChoLaiXe(
                                                  listlenh, inde);
                                            })
                                        : index == 2
                                            ? ListView.builder(
                                                shrinkWrap: true,
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                itemCount: listlenh.length,
                                                itemBuilder: (context, inde) {
                                                  return itemLenhDangThucHien(
                                                      listlenh, inde);
                                                })
                                            : index == 3
                                                ? ListView.builder(
                                                    shrinkWrap: true,
                                                    physics:
                                                        NeverScrollableScrollPhysics(),
                                                    itemCount: listlenh.length,
                                                    itemBuilder:
                                                        (context, inde) {
                                                      return itemLenhDangThucHien(
                                                          listlenh, inde);
                                                    })
                                                : index == 4
                                                    ? ListView.builder(
                                                        shrinkWrap: true,
                                                        physics:
                                                            NeverScrollableScrollPhysics(),
                                                        itemCount:
                                                            listlenh.length,
                                                        itemBuilder:
                                                            (context, inde) {
                                                          return itemLenhKhongHoanThanh(
                                                              listlenh, inde);
                                                        })
                                                    : SizedBox(),
                                alldata.data.list.length < 10
                                    ? SizedBox()
                                    : SizedBox(
                                        width: 150,
                                        child: ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                skip += 10;
                                                loadds();
                                                print(requestPayload);
                                              });

                                              // _scrollController.
                                            },
                                            child: Text('THÊM',
                                                style: TextStyle(
                                                  fontFamily: 'Roboto Bold',
                                                  fontSize: 14,
                                                ))),
                                      )
                              ],
                            ),
                          );
                        }
                        return Center(
                          child: Text('Không có dữ liệu'),
                        );
                      }),
                  showDSChuyenDi
                      ? Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            width: size.width * 0.9,
                            height: 155,
                            decoration:
                                BoxDecoration(color: Colors.white, boxShadow: [
                              BoxShadow(
                                  offset: Offset(0, 5),
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 2,
                                  blurRadius: 5)
                            ]),
                            child: ListView.builder(
                                itemCount: dsCDtemp.length,
                                itemBuilder: (context, inde) {
                                  return DSChuyenDi[index].title ==
                                          dsCDtemp[inde].title
                                      ? SizedBox()
                                      : GestureDetector(
                                          onTap: () {
                                            setdstoNull();
                                            setState(() {
                                              showDSChuyenDi = !showDSChuyenDi;
                                              index = inde;
                                              loadds();
                                            });
                                          },
                                          child: Container(
                                            width: size.width * 0.9,
                                            height: 40,
                                            child: Center(
                                              child: Text(dsCDtemp[inde].title,
                                                  style: TextStyle(
                                                    color: dsCDtemp[inde].color,
                                                    fontFamily: 'Roboto Bold',
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
            )
          ],
        ),
      ),
    );
  }

  Container itemChuyenDiDuKien(
    List<KeHoach> listdata,
    int index,
  ) {
    var datetemp = DateTime.parse(listdata[index].ngayDuong);
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
                    title:
                        '${listdata[index].not.substring(0, listdata[index].not.length - 3)} ${datetemp.day}/${datetemp.month}/${datetemp.year}',
                    icon: 'asset/icons/calendar-clock.svg',
                    color: Colors.black,
                    underline: false),
                SizedBox(
                  height: 8,
                ),
                itemListView(
                    title: listdata[index].bienSoXe == null ||
                            listdata[index].bienSoXe.isEmpty
                        ? '(Trống)'
                        : '${listdata[index].bienSoXe}',
                    icon: 'asset/icons/card-bulleted-outline.svg',
                    color: Colors.black,
                    underline: false),
                SizedBox(
                  height: 8,
                ),
                itemListView(
                    title:
                        '${listdata[index].loTrinh}\n (${listdata[index].maTuyen})',
                    icon: 'asset/icons/road-variant.svg',
                    color: Colors.black,
                    underline: false),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SvgPicture.asset('asset/icons/steering.svg'),
                    SizedBox(
                      width: 10,
                    ),
                    listdata[index].danhSachLaiXeThucHien == null
                        ? Text('(Trống)',
                            maxLines: 10,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Roboto Medium',
                              fontSize: 14,
                            ))
                        : Text(
                            '${listdata[index].danhSachLaiXeThucHien.first.hoTen}',
                            maxLines: 10,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.blue,
                              fontFamily: 'Roboto Medium',
                              fontSize: 14,
                            )),
                    listdata[index].danhSachLaiXeThucHien != null
                        ? Text(
                            listdata[index].danhSachLaiXeThucHien.length == 2
                                ? ' - ${listdata[index].danhSachLaiXeThucHien.last.hoTen}'
                                : '',
                            maxLines: 10,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Roboto Medium',
                              fontSize: 14,
                            ))
                        : SizedBox(),
                    listdata[index].danhSachLaiXeThucHien != null
                        ? Text(
                            listdata[index].danhSachLaiXeThucHien.length == 3
                                ? ' - ${listdata[index].danhSachLaiXeThucHien[1].hoTen} - ${listdata[index].danhSachLaiXeThucHien.last.hoTen}'
                                : '',
                            maxLines: 10,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Roboto Medium',
                              fontSize: 14,
                            ))
                        : SizedBox(),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                itemListView(
                    title: listdata[index].hoTenPhuXe == null ||
                            listdata[index].hoTenPhuXe.isEmpty
                        ? '(Trống)'
                        : '${listdata[index].hoTenPhuXe}',
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

  Container itemLenhDaCapChoLaiXe(List<LenhDataDetail> list, int index) {
    var date = DateTime.parse(list[index].ngayXuatBen);
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
                    title: '${list[index].maSoLenh}',
                    icon: 'asset/icons/script-text-outline.svg',
                    color: Colors.blue,
                    underline: true),
                SizedBox(
                  height: 8,
                ),
                itemListView(
                    title:
                        '${list[index].gioXuatBen.substring(0, list[index].gioXuatBen.length - 3)} ${date.day}/${date.month}/${date.year}',
                    icon: 'asset/icons/calendar-clock.svg',
                    color: Colors.black,
                    underline: false),
                SizedBox(
                  height: 8,
                ),
                itemListView(
                    title: '${list[index].bienSoXe}',
                    icon: 'asset/icons/card-bulleted-outline.svg',
                    color: Colors.black,
                    underline: false),
                SizedBox(
                  height: 8,
                ),
                itemListView(
                    title: '${list[index].tenTuyen}\n(${list[index].maTuyen})',
                    icon: 'asset/icons/road-variant.svg',
                    color: Colors.black,
                    underline: false),
                SizedBox(
                  height: 8,
                ),
                itemListView(
                    title: list[index].danhSachLaiXe == null
                        ? '(Trống)'
                        : '${list[index].danhSachLaiXe.first.hoTen}',
                    icon: 'asset/icons/steering.svg',
                    color: Colors.blue,
                    underline: false),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset('asset/icons/list-status.svg',
                            width: 24, height: 24),
                        SizedBox(
                          width: 10,
                        ),
                        Text('${list[index].tenTrangThaiKyLenh}',
                            maxLines: 10,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.green,
                                fontFamily: 'Roboto Medium',
                                fontSize: 14)),
                        list[index].tenTrangThaiLenh == null ||
                                list[index].tenTrangThaiLenh.isEmpty
                            ? ''
                            : Text(' - ',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Roboto Medium',
                                    fontSize: 14))
                      ],
                    ),
                    Text(
                        list[index].tenTrangThaiLenh == null ||
                                list[index].tenTrangThaiLenh.isEmpty
                            ? ''
                            : list[index].tenTrangThaiLenh,
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
                    title: '${list[index].trangThaiChuyenDiVDT}',
                    icon: 'asset/icons/ticket-confirmation-outline.svg',
                    color: Colors.green,
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
                  onTap: list[index].trangThaiKyLenh == true
                      ? null
                      : () {
                          print('hh');
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
                              color: list[index].trangThaiKyLenh == true
                                  ? Colors.grey.withOpacity(0.4)
                                  : Colors.blue)),
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

  Container itemLenhDangThucHien(List<LenhDataDetail> list, int index) {
    var date = DateTime.parse(list[index].ngayXuatBen);
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
                    title: '${list[index].maSoLenh}',
                    icon: 'asset/icons/script-text-outline.svg',
                    color: Colors.blue,
                    underline: true),
                SizedBox(
                  height: 8,
                ),
                itemListView(
                    title:
                        '${list[index].gioXuatBen.substring(0, list[index].gioXuatBen.length - 3)} ${date.day}/${date.month}/${date.year}',
                    icon: 'asset/icons/calendar-clock.svg',
                    color: Colors.black,
                    underline: false),
                SizedBox(
                  height: 8,
                ),
                itemListView(
                    title: '${list[index].bienSoXe}',
                    icon: 'asset/icons/card-bulleted-outline.svg',
                    color: Colors.black,
                    underline: false),
                SizedBox(
                  height: 8,
                ),
                itemListView(
                    title: '${list[index].tenTuyen}\n(${list[index].maTuyen})',
                    icon: 'asset/icons/road-variant.svg',
                    color: Colors.black,
                    underline: false),
                SizedBox(
                  height: 8,
                ),
                itemListView(
                    title: list[index].danhSachLaiXe == null
                        ? '(Trống)'
                        : '${list[index].danhSachLaiXe.first.hoTen}',
                    icon: 'asset/icons/steering.svg',
                    color: Colors.blue,
                    underline: false),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset('asset/icons/list-status.svg',
                            width: 24, height: 24),
                        SizedBox(
                          width: 10,
                        ),
                        Text('${list[index].tenTrangThaiKyLenh}',
                            maxLines: 10,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.green,
                                fontFamily: 'Roboto Medium',
                                fontSize: 14)),
                        list[index].tenTrangThaiLenh == null ||
                                list[index].tenTrangThaiLenh.isEmpty
                            ? ''
                            : Text(' - ',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Roboto Medium',
                                    fontSize: 14))
                      ],
                    ),
                    Text(
                        list[index].tenTrangThaiLenh == null ||
                                list[index].tenTrangThaiLenh.isEmpty
                            ? ''
                            : list[index].tenTrangThaiLenh,
                        style: TextStyle(
                            color: Colors.orange,
                            fontFamily: 'Roboto Medium',
                            fontSize: 14))
                  ],
                ),
                list[index].idTrangThaiLenh == 3
                    ? SizedBox(
                        height: 8,
                      )
                    : SizedBox(),
                list[index].idTrangThaiLenh == 3
                    ? itemListView(
                        title: list[index].trangThaiChuyenDiVDT,
                        icon: 'asset/icons/list-status.svg',
                        color: Colors.green,
                        underline: false)
                    : SizedBox(),
                SizedBox(
                  height: 8,
                ),
                itemListView(
                    title: '${list[index].trangThaiChuyenDiVDT}',
                    icon: 'asset/icons/ticket-confirmation-outline.svg',
                    color: Colors.green,
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
          list[index].idTrangThaiLenh == 1 || list[index].idTrangThaiLenh == 2
              ? InkWell(
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
                )
              : list[index].idTrangThaiLenh == 3
                  ? InkWell(
                      onTap: () {},
                      child: Container(
                        width: (size.width - 53) / 2,
                        height: 40,
                        child: Center(
                          child: Text('DỪNG HÀNH TRÌNH',
                              style: TextStyle(
                                  fontFamily: 'Roboto Medium',
                                  fontSize: 14,
                                  letterSpacing: 1.25,
                                  color: Colors.blue)),
                        ),
                      ),
                    )
                  : SizedBox()
        ],
      ),
    );
  }

  Container itemLenhKhongHoanThanh(List<LenhDataDetail> list, int index) {
    var date = DateTime.parse(list[index].ngayXuatBen);
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
                    title: '${list[index].maSoLenh}',
                    icon: 'asset/icons/script-text-outline.svg',
                    color: Colors.blue,
                    underline: true),
                SizedBox(
                  height: 8,
                ),
                itemListView(
                    title:
                        '${list[index].gioXuatBen.substring(0, list[index].gioXuatBen.length - 3)} ${date.day}/${date.month}/${date.year}',
                    icon: 'asset/icons/calendar-clock.svg',
                    color: Colors.black,
                    underline: false),
                SizedBox(
                  height: 8,
                ),
                itemListView(
                    title: '${list[index].bienSoXe}',
                    icon: 'asset/icons/card-bulleted-outline.svg',
                    color: Colors.black,
                    underline: false),
                SizedBox(
                  height: 8,
                ),
                itemListView(
                    title: '${list[index].tenTuyen}\n(${list[index].maTuyen})',
                    icon: 'asset/icons/road-variant.svg',
                    color: Colors.black,
                    underline: false),
                SizedBox(
                  height: 8,
                ),
                itemListView(
                    title: list[index].danhSachLaiXe == null
                        ? '(Trống)'
                        : '${list[index].danhSachLaiXe.first.hoTen}',
                    icon: 'asset/icons/steering.svg',
                    color: Colors.blue,
                    underline: false),
                SizedBox(
                  height: 8,
                ),
                itemListView(
                    title: list[index].tenTrangThaiLenh,
                    icon: 'asset/icons/list-status.svg',
                    color: Colors.red,
                    underline: false),
                SizedBox(
                  height: 8,
                ),
                itemListView(
                    title: '${list[index].trangThaiChuyenDiVDT}',
                    icon: 'asset/icons/ticket-confirmation-outline.svg',
                    color: Colors.green,
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
        ],
      ),
    );
  }
}
