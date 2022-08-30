import 'dart:convert';



import 'package:slaixe2/Model/DanhSachKeHoach.dart';
import 'package:slaixe2/servicesAPI.dart';

import '../Model/Huyen.dart';
import '../Model/LenhHienTai.dart';
import '../Model/Tinh.dart';



import 'package:http/http.dart' as http;

import 'LoginHelper.dart';
// Theo quy ước, các backends hiện tại đều hỗ trợ định dạng dữ liệu json vả input và output.
class ApiHelper {
  // Sau khi đã đăng nhập và lấy được token thì khi truy vấn api ta đưa thêm header authorization như dưới đây để server hiểu và cho phép xác thực.
  static Future<Map<String, dynamic>> get(String url) async {
    return await http.get(Uri.parse(url), headers: {
      "authorization": "Bearer ${LoginHelper.Default.access_token}",
    }).then((resp) {
      // print(resp.body);
      if (resp.body.isNotEmpty) print('infoapi ${resp.body.toString()}');
      return json.decode(resp.body);
    });
  }

//tinh

  static Future<Tinh> getProvince() async {
    return await get( servicesAPI.API_LenhDienTu + "lay-danh-sach-tinh").then((value) => Tinh.fromJson(value));
  }

  //huyen
  static Future<Huyen> getDistrict(String idtinh) async {
    return await get(servicesAPI.API_LenhDienTu + "lay-danh-sach-huyen?IdTinh=$idtinh").then((value) => Huyen.fromJson(value));
  }

  
  
  //lenh hien tai
  static Future<LenhHienTai> getLenhHienTai() async {
    return await get( servicesAPI.API_LenhDienTu+'lay-lenh-hien-tai-cua-lai-xe').then((value) => LenhHienTai.fromJson(value));
  }

  
 

  

  

 

  

  

 

  
  

  
  

 

  

 

  
  //get ds ke hoach
  static Future<DanhSachKeHoach> getDSKeHoach() async {
    return await get(apilenh.apidskehoach)
        .then((value) => DanhSachKeHoach.fromJson(value));
  }
  

  static Future<Map<String, dynamic>> post(String url, dynamic data) async {
    return await http
        .post(Uri.parse(url),
            headers: {
              "authorization": "Bearer ${LoginHelper.Default.access_token}",
              "Content-Type": "application/json",
            },
            body: jsonEncode(data))
        .then((resp)  {
          print('json : ${resp.body}');
          return jsonDecode(resp.body);
        });
  }

  static Future<String> postMultipart(
      String url, Map<String, String> data) async {
    var request = http.MultipartRequest('POST', Uri.parse(url))
      ..fields.addAll(data);
    request.headers.addAll(
      {
        "authorization": "Bearer ${LoginHelper.Default.access_token}",
        "Content-Type": "application/json",
      },
    );
    var resp = await request.send();
    if (resp.statusCode == 200) {
      print('Uploadd');
      print(resp);
      return 'Uploadd';
    }
    return resp.statusCode.toString();
  }
}
