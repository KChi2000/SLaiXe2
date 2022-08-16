import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:slaixe2/InnerShadow.dart';
import 'package:slaixe2/Model/DSChuyendi.dart';
import 'package:slaixe2/Model/DSChuyendiDuKien.dart';
import 'package:slaixe2/lenh/KiLenh.dart';
import 'package:slaixe2/lenh/SuaKeHoach.dart';

class Lenh extends StatefulWidget {
  const Lenh({Key key}) : super(key: key);

  @override
  State<Lenh> createState() => _LenhState();
}

class _LenhState extends State<Lenh> {
   int index = 0;
  final List<String> filterAsCondition = ['Giờ XB', 'BKS', 'Tuyến vận chuyển'];
  final List<DSChuyendi> DSChuyenDi = [
    DSChuyendi('Danh sách chuyến đi dự kiến', Colors.black.withOpacity(0.6)),
    DSChuyendi('Danh sách lệnh Đã cấp cho lái xe', Colors.orange)
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
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'LỆNH VẬN CHUYỂN',
          style: TextStyle(fontSize: 16),
        ),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: Icon(Icons.filter_list))
        ],
      ),
      body: Container(
        // padding: EdgeInsets.all(10),
        width: size.width,
        height: size.height,
        child: Column(
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
            Container(
              width: size.width * 0.9,
              height: 40,
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                    offset: Offset(0, 1),
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5)
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
                        print(index);
                        print(DSChuyenDi.length);
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
            Expanded(child: ListView.builder(
              itemCount: dschuyendidukien.length,
              itemBuilder: (context, inde) {
              return itemChuyenDiDuKien(
                  dschuyendidukien, index, context, size.width * 0.6);
            }))
          ],
        ),
      ),
    );
  }

  Container itemChuyenDiDuKien(List<DSChuyendiDuKien> listdata, int index,
      BuildContext context, double widthScreen) {
    return Container(
      width: widthScreen,
      margin: EdgeInsets.only(right: 18,left: 18,top: 10,bottom: 10),
      padding: EdgeInsets.only(left: 10, right: 10, top: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          // border: Border.all(
          //   color: Colors.grey.withOpacity(0.7),
          // ),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                offset: Offset(0, 4),
                blurRadius: 5,
                spreadRadius: 1)
          ]),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset('asset/icons/calendar-clock.svg', width: 24, height: 24),
                  SizedBox(
                    width: 10,
                  ),
                  Text('${listdata[index].datetime}',
                      style:
                          TextStyle(fontFamily: 'Roboto Medium', fontSize: 14)),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              SvgPicture.asset('asset/icons/card-bulleted-outline.svg', width: 24, height: 24),
              SizedBox(
                width: 10,
              ),
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: '${listdata[index].biensoxe}',
                    style: TextStyle(
                        fontFamily: 'Roboto Medium',
                        fontSize: 14,
                        color: Colors.black)),
              ])),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              SvgPicture.asset('asset/icons/road-variant.svg',
                  width: 24, height: 24),
              SizedBox(
                width: 10,
              ),
              Text(
                '${listdata[index].hanhtrinh}\n (${listdata[index].sohieuxe})',
                style: TextStyle(fontFamily: 'Roboto Medium', fontSize: 14),
              )
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              SvgPicture.asset('asset/icons/steering.svg',
                  width: 24, height: 24),
              SizedBox(
                width: 10,
              ),
              Text(
                listdata[index].tenlaixe.isEmpty
                    ? '(Trống)'
                    : '${listdata[index].tenlaixe}',
                style: TextStyle(fontFamily: 'Roboto Medium', fontSize: 14),
              )
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              SvgPicture.asset('asset/icons/account-tie-outline.svg',
                  width: 24, height: 24),
              SizedBox(
                width: 10,
              ),
              Text(
                listdata[index].tenphuxe.isEmpty
                    ?  '(Trống)'
                    : '${listdata[index].tenphuxe}',
                style: TextStyle(
                    fontFamily: 'Roboto Medium',
                    fontSize: 14,
                    color: Colors.black),
              )
            ],
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FlatButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SuaKeHoach()));
                  },
                  child: Text('SỬA KẾ HOẠCH',
                      style: TextStyle(
                          fontFamily: 'Roboto Medium',
                          fontSize: 14,
                          letterSpacing: 1.25,
                          color: Colors.orange)),
                  height: 18,
                  // color: Colors.black,
                ),
                VerticalDivider(
                  width: 2,
                  thickness: 1,
                ),
                FlatButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> KiLenh()));
                    },
                    child: Text('KÝ LỆNH',
                        style: TextStyle(
                            fontFamily: 'Roboto Medium',
                            fontSize: 14,
                            letterSpacing: 1.25,
                            color: Colors.blue)),
                    height: 18)
              ],
            ),
          )
        ],
      ),
    );
  }
}
