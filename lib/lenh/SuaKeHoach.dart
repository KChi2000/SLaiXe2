import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:slaixe2/extensions/extensions.dart';

class SuaKeHoach extends StatefulWidget {
  const SuaKeHoach({Key key}) : super(key: key);

  @override
  State<SuaKeHoach> createState() => _SuaKeHoachState();
}

class _SuaKeHoachState extends State<SuaKeHoach> {
  final List<String> dsBienKiemSoat = ['20A-08124 (31/12/2025)'];
  final List<String> dsLaiXe = ['Hà Thị Kim Chi'];
  final List<String> dsLaiXeDiCung = ['Khánh Linh'];
  final phuxeController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SỬA KẾ HOẠCH',
          style: TextStyle(fontFamily: 'Roboto Regular', )),
        centerTitle: true,
      ),
      body: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
              children: [
                RowTextItem('asset/icons/road-variant.svg', 24,
                'TT TP. Thái Nguyên - Nam Hà Giang'),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RowTextItem('asset/icons/calendar.svg', 24, '7:00'),
                SizedBox(
                  width: 5,
                ),
                RowTextItem(
                    'asset/icons/bus-stop.svg', 24, 'TT TP. Thái Nguyên'),
              ],
            ),
            DropdownButtonFormField(
              decoration: InputDecoration(labelText: 'Biển kiểm soát(*)'),
              items: dsBienKiemSoat.map((String text) {
                return new DropdownMenuItem(
                  child: Container(
                      child: Text(text,
                          style: TextStyle(
                              fontFamily: 'Roboto Regular', fontSize: 16))),
                  value: text,
                );
              }).toList(),
              // value: 'Bến xe Hà Nam',
              onChanged: (value) {},
              hint: Text('Chọn biển kiểm soát',
                  style: TextStyle(fontFamily: 'Roboto Regular', fontSize: 14)),
              menuMaxHeight: 200,
              validator: (vl1) {
                if (vl1 == null) {
                  return 'Chưa chọn điểm trả hàng';
                }
                return null;
              },
            ),
            DropdownButtonFormField(
              decoration:
                  InputDecoration(labelText: 'Lái xe tiếp nhận lệnh(*)'),
              items: dsLaiXe.map((String text) {
                return new DropdownMenuItem(
                  child: Container(
                      child: Text(text,
                          style: TextStyle(
                              fontFamily: 'Roboto Regular', fontSize: 16))),
                  value: text,
                );
              }).toList(),
              // value: 'Bến xe Hà Nam',
              onChanged: (value) {},
              hint: Text('Chọn lái xe',
                  style: TextStyle(fontFamily: 'Roboto Regular', fontSize: 14)),
              menuMaxHeight: 200,
              validator: (vl1) {
                if (vl1 == null) {
                  return 'Chưa chọn điểm trả hàng';
                }
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
                              fontFamily: 'Roboto Regular', fontSize: 16))),
                  value: text,
                );
              }).toList(),
              // value: 'Bến xe Hà Nam',
              onChanged: (value) {},
              hint: Text('Lựa chọn...',
                  style: TextStyle(fontFamily: 'Roboto Regular', fontSize: 14)),
              menuMaxHeight: 200,
              validator: (vl1) {
                if (vl1 == null) {
                  return 'Chưa chọn điểm trả hàng';
                }
                return null;
              },
            ),
            Form(
              key: formkey,
              child: TextFormField(
                decoration: InputDecoration(labelText: 'Phụ xe'),
                controller: phuxeController,
                inputFormatters: [],
                validator: (value) {},
                onChanged: (value) {},
              ),
            ),
              ],
            ),),
            Spacer(),
            Divider(color: Colors.black54,thickness: 0.2,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                InkWell(onTap: (){
                   Navigator.pop(context);
                },child: Text('HỦY',style: TextStyle(fontFamily: 'Roboto Medium',fontSize: 14,letterSpacing: 1.25,color: HexColor.fromHex('#D10909')),),),
                ElevatedButton(onPressed: (){}, child: Text('XÁC NHẬN',style: TextStyle(fontFamily: 'Roboto Medium',fontSize: 14,letterSpacing: 1.25,color: Colors.white),))
              ],),
            )
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
