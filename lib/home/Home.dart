import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:slaixe2/components/itemListView.dart';
import 'package:slaixe2/extensions/extensions.dart';
import 'package:slaixe2/helpers/ApiHelper.dart';

import '../Routes.dart';
import '../checkAccount.dart';
import '../helpers/LoginHelper.dart';
import '../restartwidget.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  Timer timer;
  int timespan;
  var lenhHienTaiFuture;

  // LenhHienTai lenhhientai;
  String checklenh = 'has data';
  var datetime;
  String timeXuatBen;
  // Barcode result;
  Size size;
  @override
  void initState() {
    checkExpire();
    super.initState();

    loadLenhHienTai();
  }

  void loadLenhHienTai() {
    try {
      lenhHienTaiFuture = ApiHelper.getLenhHienTai();
    } catch (ex) {
      // checklenh = 'no data';
      lenhHienTaiFuture = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return LoaderOverlay(
      useDefaultLoading: false,
      overlayOpacity: 0.6,
      overlayWidget: Center(
        child: CircularProgressIndicator(),
      ),
      child: Scaffold(
          body: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              height: size.height * 0.2,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color.fromARGB(255, 175, 211, 241), Colors.blue],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        child: Image.asset(
                          'asset/images/logo.png',
                          width: 45,
                          height: 45,
                        ),
                        backgroundColor: Colors.white,
                        minRadius: 10,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: 200,
                        child: Text(
                          'ddddd',
                          style: TextStyle(
                              fontFamily: 'Roboto Italic',
                              // fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 14),
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    child: Ink(
                        width: 40,
                        height: 40,
                        // color: Colors.pink,
                        child: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            child: SvgPicture.asset(
                              'asset/icons/scan.svg',
                              color: Colors.white,
                            ))),
                    onTap: () async {},
                  )
                ],
              ),
            ),
            // checklenh != 'no data'
            //     ?
            FutureBuilder(
                future: lenhHienTaiFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    context.loaderOverlay.show();
                  } else if (snapshot.hasError) {
                    context.loaderOverlay.hide();
                    return customStatus(Text('Lỗi',
                        style: TextStyle(
                            fontFamily: 'Roboto Regular', fontSize: 14)));
                  } else if (snapshot.hasData) {
                    context.loaderOverlay.hide();
                    datetime = DateTime.parse(
                            snapshot.data.data.thoiGianXuatBenKeHoach)
                        .toLocal();
                    timeXuatBen =
                        DateFormat('kk:mm dd-MM-yyyy ').format(datetime);
                    return itemLenhHienTai(
                        '$timeXuatBen',
                        '${snapshot.data.data.trangThai}',
                        '${snapshot.data.data.bienKiemSoat} (${snapshot.data.data.maLenh})',
                        '${snapshot.data.data.tenTuyen}\n(${snapshot.data.data.maTuyen})',
                        '5 khách');
                  }
                  context.loaderOverlay.hide();
                  return customStatus(Text('Không có dữ liệu lệnh hiện tại !',
                      style: TextStyle(
                          fontFamily: 'Roboto Regular',
                          fontSize: 14,
                          color: HexColor.fromHex('#737373'))));
                }),
            // : customStatus(Text('Không có dữ liệu lệnh hiện tại !',
            //     style: TextStyle(
            //         fontFamily: 'Roboto Regular',
            //         fontSize: 14,
            //         color: HexColor.fromHex('#737373')))),
            Align(
              alignment: Alignment.topLeft,
              child: itemChucNang('Lệnh điện tử', 'Quản lí lệnh',
                  'asset/icons/script-text-outline.svg', () {
                Routes.navigatetoQuanLiLenh(context);
              }),
            )
          ],
        ),
      )),
    );
  }

  Container customStatus(Widget childd) {
    return Container(
      width: size.width * 0.85,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.grey[600].withOpacity(0.15),
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.grey[600].withOpacity(0.15),
                offset: Offset(5, 5),
                blurRadius: 3,
                spreadRadius: 0.1)
          ]),
      child: Center(child: childd),
    );
  }

  Container itemLenhHienTai(String timexuatben, String trangthai,
      String bienkiemsoatmalenh, String tentuyenmatuyen, String khach) {
    return Container(
      width: size.width * 0.9,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.grey[600].withOpacity(0.15),
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.grey[600].withOpacity(0.15),
                offset: Offset(5, 5),
                blurRadius: 3,
                spreadRadius: 0.1)
          ]),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: itemListView(
                    title: timeXuatBen,
                    icon: 'asset/icons/clock.svg',
                    color: Colors.black,
                    underline: false),
              ),
              Text(
                trangthai,
                style: TextStyle(
                    fontFamily: 'Roboto Medium',
                    fontSize: 14,
                    color: Colors.orange),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          itemListView(
              title: bienkiemsoatmalenh,
              icon: 'asset/icons/sohieu.svg',
              color: Colors.black,
              underline: false),
          SizedBox(
            height: 10,
          ),
          itemListView(
              title: tentuyenmatuyen,
              icon: 'asset/icons/buslocation.svg',
              color: Colors.black,
              underline: false),
          SizedBox(
            height: 10,
          ),
          // itemListView(
          //     title: khach,
          //     icon: 'asset/icons/customer.svg',
          //     color: Colors.black,
          //     underline: false),
          Align(
              alignment: Alignment.bottomRight,
              child: SizedBox(
                  height: 35,
                  width: 150,
                  child: ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        'XEM LỆNH',
                        style: TextStyle(
                            fontFamily: 'Roboto Medium',
                            fontSize: 14,
                            letterSpacing: 1.25),
                      ))))
        ],
      ),
    );
  }

  Container itemChucNang(
      String title, String tenchucNang, String icon, Function ontap) {
    return Container(
      margin: EdgeInsets.only(left: 30, top: 20),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title,
              style: TextStyle(
                  fontFamily: 'Roboto Bold',
                  fontSize: 16,
                  color: Colors.black)),
          GestureDetector(
            onTap: ontap,
            child: Container(
                width: 65,
                height: 65,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.grey[600].withOpacity(0.4),
                  ),
                ),
                margin: EdgeInsets.only(top: 10, bottom: 5),
                child: Center(
                  child: SvgPicture.asset(
                    icon,
                    width: 35,
                    height: 35,
                    color: Color.fromRGBO(254, 174, 170, 1),
                  ),
                )),
          ),
          Text(tenchucNang,
              style: TextStyle(
                  fontFamily: 'Roboto Regular',
                  fontSize: 14,
                  color: Colors.black))
        ],
      ),
    );
  }

  checkExpire() {
    timer = Timer.periodic(Duration(seconds: 10), (Timer timer) async {
      timespan = DateTime.now().millisecondsSinceEpoch;
      int cal = (timespan / 1000).toInt();
      // print(DateTime.fromMillisecondsSinceEpoch(1660301736 * 1000));
      // print('i am working still ^_^');
      if (cal > LoginHelper.Default.userToken.exp) {
        await storage.deleteAll().then((value) {
          print('expireeeeeeeeeeeeeeeeeeee');
          RestartWidget.restartApp(context);
        });
      }
    });
  }
}
