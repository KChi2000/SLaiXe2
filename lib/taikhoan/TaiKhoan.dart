import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:image_picker/image_picker.dart';
import 'dart:math';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slaixe2/servicesAPI.dart';
import '../Model/Huyen.dart';
import '../checkAccount.dart';
import '../helpers/ApiHelper.dart';
import '../helpers/LoginHelper.dart';
import '../model/Tinh.dart';
import 'package:collection/collection.dart';
var spaceInfo=10.0;
class Taikhoan extends StatefulWidget {
  const Taikhoan({Key key}) : super(key: key);
  @override
  TaikhoanState createState() {
    return TaikhoanState();
  }
}

class TaikhoanState extends State<Taikhoan> {
  final storage = new FlutterSecureStorage();
  final formkey = GlobalKey<FormState>();
  DateTime datetime = DateTime.now();
  String formattedDate;
  String unselect = 'chưa chọn';
  String sdt;
  String email;
  String address;
  XFile imageitem;
  List<XFile> image = [];
  final phoneController = TextEditingController(text: '');
  final emailController = TextEditingController(text: '');
  final addressController = TextEditingController(text: '');
  // final diachiContoller= TextEditingController(text: 'tổ abc, phường xyz');
  String txt;
  String tinh, huyen, diachi;
  List<DataTinh> province = [];
  List<DataHuyen> district = [];

  var idTinh;
  var datafuture;
  Map<String, dynamic> data;
  var tinhfuture;
  DataHuyen huyentemp;
  Tinh dataTinh;
  var huyenfuture;
  void Function(void Function()) setstatedialog;
  Huyen dataHuyen;
SharedPreferences prefs;
  // Future getImage() async {
  //   final image = await imagePicker.getImage(source: ImageSource.camera);
  //   setState(() {
  //     _image = File(image.path);
  //   });
  // }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  loadPic();
    loadInfo();
    // print('${infoMap.}');
  }
void loadPic()async{
   prefs = await SharedPreferences.getInstance();
  imageitem =  XFile(prefs.getString(LoginHelper.Default.userToken.preferred_username));
}
  void loadInfo() async {
    
    datafuture =
        ApiHelper.get(servicesAPI.API_LenhDienTu + 'lay-thong-tin-ca-nhan');
    data = await datafuture;
    if (data != null) {
      tinh = '';
      idTinh = data['data']['idTinh'];
      print('ttttt ${data['data']['idTinh']}');
      tinhfuture = ApiHelper.getProvince(
         );
      dataTinh = await tinhfuture;
      province = dataTinh.data;
      if (idTinh != null) {
        loadHuyen(false);
      }
    }
    setState(() {});
  }

  void loadHuyen(bool checksetState) async {
    huyenfuture = ApiHelper.getDistrict(
        idTinh);
    dataHuyen = await huyenfuture;
    district = dataHuyen.data;

    if (checksetState) {
      setstatedialog(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (datetime != null) {
      formattedDate = DateFormat('dd/MM/yyyy').format(datetime);
    }
    // formattedDate == DateFormat('dd-MM-yyyy').format(datetime)? null: formattedDate;
    print(formattedDate);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          // style: TextStyle(
          //   color: titleColor,
          //   fontFamily: 'Roboto Medium',
          //   fontSize: 20,
          //   fontWeight: FontWeight.bold,
          //   letterSpacing: 0.15
          // ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(20),
                child: Stack(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: imageitem != null  
                          ? FileImage(File(imageitem.path))
                          : AssetImage('asset/images/logo.png') ,
                    ), //Scaffold.of(context).showSnackBar(new SnackBar(content: new Text('edit avatar')));
                    Positioned(
                      bottom: 25 - sin(45) * 25,
                      right: 25 - sin(45) * 25,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.brown[400],
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(6),
                          child: GestureDetector(
                              child: Icon(
                                Icons.edit,
                                size: 10,
                                color: Colors.white,
                              ),
                              onTap: ()async {
                                
                                return showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: Container(
                                          width: 60,
                                          child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                GestureDetector(
                                                  child: Text('Chụp ảnh mới',
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontFamily:
                                                              'Roboto Regular')),
                                                  onTap: () async {
                                                    print('chọn chụp ảnh');
                                                    Navigator.pop(context);
                                                    imageitem =
                                                        await ImagePicker()
                                                            .pickImage(
                                                                source:
                                                                    ImageSource
                                                                        .camera);
                                                    if (imageitem == null) {
                                                      return;
                                                    }

                                                    
                                                    await prefs.setString(LoginHelper.Default.userToken.preferred_username, imageitem.toString());
                                                    setState(() {
                                                      
                                                    });
                                                  },
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                GestureDetector(
                                                  child: Text('Chọn ảnh',
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontFamily:
                                                              'Roboto Regular')),
                                                  onTap: () async {
                                                    print('chọn ảnh');
                                                    Navigator.pop(context);
                                                    imageitem =
                                                        await ImagePicker()
                                                            .pickImage(
                                                                source:
                                                                    ImageSource
                                                                        .gallery);
                                                    if (imageitem == null) {
                                                      return;
                                                    }
                                                    print(imageitem.path);
                                                   await prefs.setString(LoginHelper.Default.userToken.preferred_username, imageitem.path.toString());
                                                   setState(() {
                                                     
                                                   });
                                                  },
                                                ),
                                              ]),
                                        ),
                                      );
                                    });
                              }),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 10, right: 20),
                    child: SizedBox(
                      width: 200,
                      child: Text(
                        '${LoginHelper.Default.userToken.given_name} ',
                        style: TextStyle(
                            fontFamily: 'Roboto Medium', fontSize: 16),
                        maxLines: 2,
                      ),
                    ),
                  ),
                  Text(
                    'Lái xe',
                    maxLines: 1,
                    style: TextStyle(
                      fontFamily: 'Roboto Regular',
                      color: Colors.grey[700],
                      fontSize: 12,
                    ),
                  ),
                ],
              )
            ],
          ),
          data != null
              ? FutureBuilder<Map<String, dynamic>>(
                  future: datafuture,
                  builder: (context, snapshot) {
                    // By default, show a loading spinner.
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: const CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('${snapshot.error} loiiiii'));
                    } else if (snapshot.hasData) {
                      var fetchdata = snapshot.data;
                      formattedDate = fetchdata['data']['ngaySinh'];
                      sdt = fetchdata['data']['soDienThoai'];
                      email = fetchdata['data']['email'];
                      address = fetchdata['data']['diaChiThuongTru'];
                      if (formattedDate != null) {
                        formattedDate = DateFormat('dd/MM/yyyy')
                            .format(DateTime.parse(formattedDate).toLocal());
                      }
                      print('date:  $formattedDate');

                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(10),
                            // height: MediaQuery.of(context).size.height * 0.5,
                            width: MediaQuery.of(context).size.width * 0.9,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      offset: Offset(0, 0), blurRadius: 0.5)
                                ],
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15)),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Thông tin cá nhân',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Roboto Medium',
                                      fontSize: 16),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                rowItemInfor(
                                    'Ngày sinh',
                                    formattedDate != null
                                        ? formattedDate
                                        : unselect,
                                    true, () async {
                                  var datetemp = await showDatePicker(
                                      context: context,
                                      initialDate: fetchdata['data']
                                                  ['ngaySinh'] !=
                                              null
                                          ? DateTime.parse(
                                                  fetchdata['data']['ngaySinh'])
                                              .toLocal()
                                          : DateTime.now(),
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime(2222));
                                  //     .then((value) {
                                  //   setState(() {

                                  formattedDate =
                                      DateFormat('dd/MM/yyyy').format(datetemp);
                                  print(formattedDate);
                                  var res = await ApiHelper.post(
                                      servicesAPI.API_LenhDienTu +
                                          'chinh-sua-thong-tin-ca-nhan',
                                      {
                                        'noiDung': '${formattedDate}',
                                        'tenTruong': 'ngaySinh'
                                      });
                                  print('formatttt $formattedDate');
                                  if (res['status']) {
                                    //
                                    setState(() {
                                      loadInfo();
                                    });
                                    // Navigator.pop(context, 'OK');
                                  } else {
                                    print('failed');
                                    //  Navigator.pop(context, 'OK');
                                  }

                                  //   });
                                  // });
                                }),
                                SizedBox(
                                  height: spaceInfo,
                                ),
                                rowItemInfor('Số điện thoại',
                                    sdt != null ? sdt : unselect, true, () {
                                  phoneController.text =
                                      fetchdata['data']['soDienThoai'];
                                  return showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          title: Text(
                                            'Sửa SĐT',
                                            style: TextStyle(
                                                fontFamily: 'Roboto Medium',
                                                fontSize: 18),
                                          ),
                                          content: Container(
                                              height: 30,
                                              width: 100,
                                              child: Form(
                                                key: formkey,
                                                child: TextFormField(
                                                  decoration: InputDecoration(
                                                      hintText:
                                                          'nhập số điện thoại'),
                                                  controller: phoneController,
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .allow(RegExp(r'[0-9]'))
                                                  ],
                                                  validator: (sodt) {
                                                    if (sodt == null ||
                                                        sodt.isEmpty) {
                                                      return 'Số điện thoại không được để trống';
                                                    }
                                                    return null;
                                                  },
                                                ),
                                              )),
                                          actions: [
                                            TextButton(
                                              onPressed: () => Navigator.pop(
                                                  context, 'Cancel'),
                                              child: const Text(
                                                'Cancel',
                                                style: TextStyle(
                                                    fontFamily:
                                                        'Roboto Regular',
                                                    fontSize: 14),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () async {
                                                if (formkey.currentState
                                                    .validate()) {
                                                  var res = await ApiHelper.post(
                                                      servicesAPI.API_LenhDienTu +
                                                          'chinh-sua-thong-tin-ca-nhan',
                                                      {
                                                        'noiDung':
                                                            '${phoneController.text}',
                                                        'tenTruong':
                                                            'soDienThoai'
                                                      });
                                                  if (res['status']) {
                                                    loadInfo();
                                                    Navigator.pop(
                                                        context, 'OK');
                                                  } else {
                                                    print('failed');
                                                  }
                                                }
                                              },
                                              child: const Text(
                                                'OK',
                                                style: TextStyle(
                                                    fontFamily:
                                                        'Roboto Regular',
                                                    fontSize: 14),
                                              ),
                                            ),
                                          ],
                                        );
                                      });
                                }),
                                SizedBox(
                                  height: spaceInfo,
                                ),
                                rowItemInfor('Email',
                                    email == null ? unselect : email, true, () {
                                  emailController.text =
                                      fetchdata['data']['email'];
                                  return showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          title: Text(
                                            'Sửa Email',
                                            style: TextStyle(
                                                fontFamily: 'Roboto Medium',
                                                fontSize: 18),
                                          ),
                                          content: Form(
                                              key: formkey,
                                              child: TextFormField(
                                                decoration: InputDecoration(
                                                    hintText: 'nhập email'),
                                                controller: emailController,
                                                inputFormatters: [],
                                                validator: (em) {
                                                  if (em == null ||
                                                      em.isEmpty) {
                                                    return 'Email không được để trống';
                                                  }
                                                  return null;
                                                },
                                              )),
                                          actions: [
                                            TextButton(
                                              onPressed: () => Navigator.pop(
                                                  context, 'Cancel'),
                                              child: const Text(
                                                'Huỷ',
                                                style: TextStyle(
                                                    fontFamily:
                                                        'Roboto Regular',
                                                    fontSize: 14),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () async {
                                                if (formkey.currentState
                                                    .validate()) {
                                                  var res = await ApiHelper.post(
                                                      servicesAPI.API_LenhDienTu +
                                                          'chinh-sua-thong-tin-ca-nhan',
                                                      {
                                                        'noiDung':
                                                            '${emailController.text}',
                                                        'tenTruong': 'email'
                                                      });
                                                  if (res['status']) {
                                                    loadInfo();
                                                    Navigator.pop(
                                                        context, 'OK');
                                                  } else {
                                                    print('failed');
                                                    Navigator.pop(
                                                        context, 'OK');
                                                  }
                                                }
                                              },
                                              child: const Text(
                                                'Xác nhận',
                                                style: TextStyle(
                                                    fontFamily:
                                                        'Roboto Regular',
                                                    fontSize: 14),
                                              ),
                                            ),
                                          ],
                                        );
                                      });
                                }),
                                SizedBox(
                                  height: spaceInfo,
                                ),
                                rowItemInforAddress(
                                    'Địa chỉ',
                                    address != null ? address : unselect,
                                    true, () {
                                  addressController.text =
                                      fetchdata['data']['diaChi'];
                                  var tinhtemp = province.where((value) =>
                                      fetchdata['data']['idTinh'] ==
                                      value.idTinh);
                                  if (!tinhtemp.isEmpty || tinhtemp != null) {
                                    tinh = tinhtemp.first.tenTinh;
                                  }
                                  var huyentemp = district.firstWhereOrNull(
                                      (value) =>
                                          fetchdata['data']['idHuyen'] ==
                                          value.idHuyen);
                                  if (huyentemp != null) {
                                    huyen = huyentemp.tenHuyen;
                                  }
                                  return showDialog(
                                      context: context,
                                      builder: (context) {
                                        return StatefulBuilder(
                                            builder: (context, setStateDialog) {
                                          setstatedialog = setStateDialog;
                                          return AlertDialog(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            title: Text(
                                              'Sửa địa chỉ',
                                              style: TextStyle(
                                                  fontFamily: 'Roboto Medium',
                                                  fontSize: 18),
                                            ),
                                            content: Form(
                                                key: formkey,
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Container(
                                                      child:
                                                          DropdownButtonFormField(
                                                        decoration:
                                                            InputDecoration(
                                                                labelText:
                                                                    'tỉnh(*)'),
                                                        items: province
                                                            .map((text) {
                                                          return new DropdownMenuItem(
                                                            child: Container(
                                                                child: Text(
                                                                    text
                                                                        .tenTinh,
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            'Roboto Regular',
                                                                        fontSize:
                                                                            14))),
                                                            value: text.tenTinh,
                                                            onTap: () {
                                                              print(
                                                                  'tinh moi : ${text.idTinh}  ${text.tenTinh}');
                                                              setStateDialog(
                                                                  () {
                                                                idTinh =
                                                                    text.idTinh;

                                                                huyen = null;
                                                                loadHuyen(true);
                                                              });
                                                            },
                                                          );
                                                        }).toList(),
                                                        value: tinh,
                                                        onChanged: (t1) {
                                                          setStateDialog(() {
                                                            tinh = t1;
                                                          });
                                                        },
                                                        hint: Text('chọn tỉnh',
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                fontFamily:
                                                                    'Roboto Regular')),
                                                        menuMaxHeight: 200,
                                                        validator: (vl1) {
                                                          if (vl1 == null ||
                                                              vl1.isEmpty) {
                                                            return 'Chưa chọn tỉnh';
                                                          }
                                                          return null;
                                                        },
                                                      ),
                                                    ),
                                                    Container(
                                                      // height: 45,
                                                      child:
                                                          DropdownButtonFormField(
                                                        decoration: InputDecoration(
                                                            labelText:
                                                                'Quận/huyện(*)'),
                                                        items: district
                                                            .map((text) {
                                                          return new DropdownMenuItem(
                                                            child: Container(
                                                                child: Text(
                                                                    text
                                                                        .tenHuyen,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            15))),
                                                            value:
                                                                text.tenHuyen,
                                                          );
                                                        }).toList(),
                                                        value: huyen,
                                                        onChanged: (t2) {
                                                          huyentemp = district
                                                              .firstWhereOrNull(
                                                                  (value) =>
                                                                      t2 ==
                                                                      value
                                                                          .tenHuyen);
                                                          print(
                                                              'huyen chonj ${huyentemp.idHuyen}');
                                                          setStateDialog(() {
                                                            huyen = t2;
                                                          });
                                                        },
                                                        hint: Text('chọn huyện',
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                fontFamily:
                                                                    'Roboto Regular')),
                                                        menuMaxHeight: 200,
                                                        validator: (vl2) {
                                                          if (vl2 == null ||
                                                              vl2.isEmpty) {
                                                            return 'Chưa chọn huyện';
                                                          }
                                                          return null;
                                                        },
                                                        onTap: () {},
                                                      ),
                                                    ),
                                                    TextFormField(
                                                      controller:
                                                          addressController,
                                                      inputFormatters: [],
                                                      maxLines: null,
                                                      decoration: InputDecoration(
                                                          labelText:
                                                              'Địa chỉ cụ thể(*)'),
                                                      validator: (vl4) {
                                                        if (vl4 == null ||
                                                            vl4.isEmpty) {
                                                          return 'Chưa điền địa chỉ cụ thể';
                                                        }
                                                        return null;
                                                      },
                                                      autovalidateMode: AutovalidateMode.onUserInteraction,
                                                    )
                                                  ],
                                                )),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  loadInfo();
                                                  Navigator.pop(
                                                      context, 'Cancel');
                                                },
                                                child: const Text('Cancel',
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontFamily:
                                                            'Roboto Regular')),
                                              ),
                                              TextButton(
                                                onPressed: () async {
                                                  Map<String, dynamic>
                                                      Mappostdata = {
                                                    'diaChi':
                                                        '${addressController.text}',
                                                    'idHuyen':
                                                        '${huyentemp.idHuyen}',
                                                  };
                                                  if (formkey.currentState
                                                      .validate()) {
                                                    var res = await ApiHelper.post(
                                                        servicesAPI
                                                                .API_LenhDienTu +
                                                            'chinh-sua-dia-chi-ca-nhan',
                                                        Mappostdata);

                                                    loadInfo();
                                                    Navigator.pop(
                                                        context, 'OK');
                                                  }
                                                  ;
                                                },
                                                child: const Text('OK',
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontFamily:
                                                            'Roboto Regular')),
                                              ),
                                            ],
                                          );
                                        });
                                      });
                                }, fetchdata['data']['diaChiThuongTru']),
                                SizedBox(
                                  height: spaceInfo,
                                ),
                                rowItemInfor('Năm bắt đầu hành nghề', '2022',
                                    false, () {}),
                                SizedBox(
                                  height: spaceInfo,
                                ),
                                rowItemInfor(
                                    'Số GPLX',
                                    fetchdata['data']['soGPLX'] == null
                                        ? unselect
                                        : fetchdata['data']['soGPLX'],
                                    false,
                                    () {}),
                                SizedBox(
                                  height: spaceInfo,
                                ),
                                rowItemInfor(
                                    'Hạng bằng',
                                    fetchdata['data']['hangBang'] == null
                                        ? unselect
                                        : fetchdata['data']['hangBang'],
                                    false,
                                    () {}),
                                SizedBox(
                                  height: spaceInfo,
                                ),
                                rowItemInfor(
                                    'Ngày bắt đầu hiệu lực',
                                    fetchdata['data']['ngayBatDauHieuLuc'] ==
                                            null
                                        ? unselect
                                        : fetchdata['data']
                                            ['ngayBatDauHieuLuc'],
                                    false,
                                    () {}),
                                SizedBox(
                                  height: spaceInfo,
                                ),
                                rowItemInfor('Thời hạn hiệu lực', '21/03/2022',
                                    false, () {}),
                                SizedBox(
                                  height: spaceInfo,
                                ),
                                rowItemInfor(
                                    'Cơ quan cấp',
                                    fetchdata['data']['coQuanCap'] == null
                                        ? unselect
                                        : fetchdata['data']['coQuanCap'],
                                    false,
                                    () {}),
                                SizedBox(
                                  height: spaceInfo,
                                ),
                                rowItemInfor(
                                    'Ngày cấp',
                                    fetchdata['data']['ngayCap'] == null
                                        ? unselect
                                        : fetchdata['data']['ngayCap'],
                                    false,
                                    () {}),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            onPressed: () async{
                              print('Đăng xuất');
                              await storage.deleteAll();
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => checkAccount()));
                            },
                            child: Text('ĐĂNG XUẤT',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Roboto Medium',
                                    fontSize: 14,
                                    letterSpacing: 1.25)),
                            color: Colors.blue,
                          )
                        ],
                      );
                    }
                    return Center(
                        child: Text('No data',
                            style: TextStyle(
                                fontSize: 14, fontFamily: 'Roboto Regular')));
                  })
              : Center(
                  child: Text(
                    'Lỗi 401 nhé !',
                    style:
                        TextStyle(fontSize: 14, fontFamily: 'Roboto Regular'),
                  ),
                ),
        ],
      )),
    );
  }

  Row rowItemInfor(String t1, String t2, bool active, VoidCallback click) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          t1,
          style: TextStyle(
              color: Colors.black, fontFamily: 'Roboto Regular', fontSize: 14),
        ),
        SizedBox(
          width: 100,
        ),
        Row(
          children: [
            SizedBox(
              child: Text(
                t2,
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Roboto Medium',
                    fontSize: 14),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                softWrap: true,
              ),
            ),
            GestureDetector(
              child: active
                  ? RotatedBox(
                      child: Icon(Icons.arrow_back_ios,
                          size: 14, color: Color.fromARGB(255, 73, 73, 72)),
                      quarterTurns: 2,
                    )
                  : Container(width: 0, height: 0),
              onTap: click,
            )
          ],
        )
      ],
    );
  }

  Row rowItemInforAddress(String t1, String t2, bool active, VoidCallback click,
      String checkspace) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          t1,
          style: TextStyle(
              color: Colors.black, fontFamily: 'Roboto Regular', fontSize: 14),
        ),
        // SizedBox(
        //   width: 100,
        // ),
        Row(
          children: [
            // Spacer(),
            SizedBox(
              width: checkspace == null ? 70 : 200,
              child: Text(
                t2,
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Roboto Medium',
                    fontSize: 14),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                softWrap: true,
              ),
            ),
            GestureDetector(
              child: active
                  ? RotatedBox(
                      child: Icon(Icons.arrow_back_ios,
                          size: 14, color: Color.fromARGB(255, 73, 73, 72)),
                      quarterTurns: 2,
                    )
                  : Container(width: 0, height: 0),
              onTap: click,
            )
          ],
        )
      ],
    );
  }

  Expanded buildMapItemView(String value, String key) {
    return Expanded(
      child: Column(
        children: <Widget>[
          Text(
            value,
            style: TextStyle(fontSize: 16, fontFamily: 'Roboto Medium'),
          ),
          Divider(
            height: 5,
            color: Colors.transparent,
          ),
          Text(
            key,
            style: TextStyle(
                color: Colors.grey, fontSize: 12, fontFamily: 'Roboto Regular'),
          )
        ],
      ),
      flex: 1,
    );
  }
}
