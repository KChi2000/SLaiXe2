import 'dart:convert';



import 'package:slaixe2/Model/DanhSachKeHoach.dart';
import 'package:slaixe2/servicesAPI.dart';

import '../Model/Huyen.dart';
import '../Model/Tinh.dart';
import '../Model/lenhModel.dart';
import '../Model/tang.dart';
import '../model/DSDiemXuong.dart';
import '../model/DSDiemxuongLotrinh.dart';
import '../model/DSHHTheoChuyenDi.dart';
import '../model/DSHanhKhachGhePhu.dart';
import '../model/DSHanhKhachMuaVe.dart';
import '../model/DSTrangThai.dart';
import '../model/DSTuyenVanChuyenTheoNgay.dart';
import '../model/DonGiaTheoTuyen.dart';
import '../model/KhachTrenXe.dart';
import '../model/LayChiTietNhatKyVanChuyen.dart';
import '../model/LenhHienTai.dart';
import '../model/LichSuChuyenDi.dart';
import '../model/SLVe.dart';
import '../model/ThongTinHanhKhachGhe.dart';
import '../model/ThongTinThem.dart';
import '../model/TrangThaiChoNgoi.dart';
import '../model/chuyendiganday.dart';
import '../model/sodocho.dart';
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

  //chi tiet lenh
  static Future<ChiTietLenh> getChiTietLenh() async {
    return await get(servicesAPI.API_LenhDienTu + 'lay-chi-tiet-lenh-dang-thuc-hien').then((value) => ChiTietLenh.fromJson(value));
  }

  // khach tren xe
  static Future<KhachTrenXe> getKhachTrenXe(String idlenhdientu) async {
    return await get(servicesAPI.API_ThongTin+'QuanLyThongTin/lay-thong-tin-chuyen-di-theo-lenh?idLenhDienTu=$idlenhdientu').then((value) => KhachTrenXe.fromJson(value));
  }

  //lenh hien tai
  static Future<LenhHienTai> getLenhHienTai() async {
    return await get( servicesAPI.API_LenhDienTu+'lay-lenh-hien-tai-cua-lai-xe').then((value) => LenhHienTai.fromJson(value));
  }

  // tim kiem chuyen di gan day
  static Future<chuyendiganday> getchuyendiganday() async {
    return get(servicesAPI.API_DoiSoat + 'tim-kiem-chuyen-di-gan-day').then((value) => chuyendiganday.fromJson(value));
  }

  // danh sach hang hoa theo chuyen di
  static Future<DSHHTheoChuyenDi> getDSHHTheoChuyenDi(String vl,String s) async {
    return await get(servicesAPI
              .API_HangHoa +
          'HangHoa/lay-danh-sach-hang-hoa-theo-chuyen-di?idChuyenDi=$vl&timKiem=$s').then((value) => DSHHTheoChuyenDi.fromJson(value));
  }

  // thong tin them chuyen di
  static Future<ThongTinThem> getThongTinThem(String guidChuyendi) async {
    return await get(servicesAPI.API_ChuyenDi +
            'lay-thong-tin-them-cua-chuyen-di?GuidChuyenDi=$guidChuyendi')
        .then((value) => ThongTinThem.fromJson(value));
  }

  //ds trang thai
  static Future<DSTrangThai> getDSTrangThai(String idchuyendi) async {
    return await get(servicesAPI.API_HangHoa +
        'HangHoa/lay-danh-sach-trang-thai-van-chuyen?idChuyenDi=$idchuyendi').then((value) => DSTrangThai.fromJson(value));
  }

  //lich su chuyen di cua lai xe
  static Future<LichSuChuyenDi> getLichSuChuyenDi(String guidchuyendi) async {
    return await get(servicesAPI.API_ChuyenDi+ 'lay-danh-sach-lich-su-chuyen-di-cua-lai-xe?GuidChuyenDi=$guidchuyendi').then((value) => LichSuChuyenDi.fromJson(value));
  }

  //get tang xe
  static Future<tang> gettang(String idChuyenDi) async {
    return await get(servicesAPI.API_BaseUrl +
            'dat-ve/danh-sach-tang-xe?IdChuyenDi=$idChuyenDi')
        .then((value) => tang.fromJson(value));
  }

  //get so do xe
  static Future<sodocho> getsodocho(String idchuyendi, String idtang) async {
    return await get(servicesAPI.API_ThongTin +
            'dat-ve/ma-tran-cho-ngoi?IdChuyenDi=$idchuyendi&IdTang=$idtang')
        .then((value) => sodocho.fromJson(value));
  }

  // get trang thai cho ngoi
  static Future<TrangThaiChoNgoi> getTrangThaiChoNgoi(
      String guidchuyendi) async {
    return await get(servicesAPI.API_DoiSoat +
            'lay-trang-thai-cho-ngoi-soat-ve?GuidChuyenDi=$guidchuyendi')
        .then((value) => TrangThaiChoNgoi.fromJson(value));
  }

  // get danh sach diem xuong
  static Future<DSDiemXuong> getDSDiemXuong(String guidlotrinh) async {
    return await get(servicesAPI.API_ThongTin +
            'DiemDung/lay-danh-sach-diem-xuong-cua-lo-trinh?guidLoTrinh=$guidlotrinh')
        .then((value) => DSDiemXuong.fromJson(value));
  }

  // get danh sach tuyen van chuyen theo ngay
  static Future<DSTuyenVanChuyenTheoNgay> getDSTuyenVanChuyenTheoNgay(
      String ngay) async {
    return await get(servicesAPI.API_LenhDienTu +
            'lay-danh-sach-tuyen-van-chuyen-theo-ngay?Ngay=$ngay')
        .then((value) => DSTuyenVanChuyenTheoNgay.fromJson(value));
  }

  // get chi tiet nhat ky van chuyen
  static Future<LayChiTietNhatKyVanChuyen> getLayChiTietNhatKyVanChuyen(
      String idnhatky) async {
    return await get(servicesAPI.API_HangHoa +
            'HangHoa/lay-chi-tiet-nhat-ky-van-chuyen?idNhatKy=$idnhatky')
        .then((value) => LayChiTietNhatKyVanChuyen.fromJson(value));
  }

  // get ds hanh khach tren xe
  static Future<DSHanhKhachMuaVe> getDSHanhKhachMuaVe(
      String idlenhdientu) async {
    return await get(servicesAPI.API_ThongTin +
            'QuanLyThongTin/lay-danh-sach-hanh-khach-mua-ve-tren-xe?idLenhDienTu=$idlenhdientu')
        .then((value) => DSHanhKhachMuaVe.fromJson(value));
  }

  //get thong tin hanh khach ngoi tren ghe
  static Future<ThongTinHanhKhachGhe> getThongTinHanhKhachGhe(
      String machuyendi, String guidchongoi) async {
    return await get(servicesAPI.API_DoiSoat +
            'lay-thong-tin-hanh-khach-qua-cho-ngoi?MaChuyenDi=$machuyendi&GuidChoNgoi=$guidchongoi')
        .then((value) => ThongTinHanhKhachGhe.fromJson(value));
  }

  //get thong tin hanh khach ngoi tren ghe phu
  static Future<DSHanhKhachGhePhu> getDSHanhKhachGhePhu(
      String guidchuyendi) async {
    return await get(servicesAPI.API_DonHang +
            'lay-danh-sach-hanh-khach-mua-ve-ghe-phu?guidChuyenDi=$guidchuyendi')
        .then((value) => DSHanhKhachGhePhu.fromJson(value));
  }

  //get ds diem xuong cua lo trinh
  static Future<DSDiemXuongLoTrinh> getDSDiemXuongLoTrinh(
      String guidlotrinh) async {
    return await get(servicesAPI.API_TuyenDuong +
            'DiemDung/lay-danh-sach-diem-xuong-cua-lo-trinh?guidLoTrinh=$guidlotrinh')
        .then((value) => DSDiemXuongLoTrinh.fromJson(value));
  }

  //get so luong ve ban dc
  static Future<SLVe> getSLVe(String guidchuyendi) async {
    return await get(servicesAPI.API_DonHang +
            'lay-so-luong-ve-ban-theo-loai-diem-ban?GuidChuyenDi=$guidchuyendi')
        .then((value) => SLVe.fromJson(value));
  }

  //get don gia theo tuyen
  static Future<DonGiaTheoTuyen> getDonGiaTheoTuyen(String idlotrinh) async {
    return await get(servicesAPI.API_ThongTin +
            'QuanLyThongTin/lay-don-gia-theo-tuyen?idLoTrinh=$idlotrinh')
        .then((value) => DonGiaTheoTuyen.fromJson(value));
  }
  //get ds ke hoach
  static Future<DanhSachKeHoach> getDSKeHoach() async {
    return await get(apilenh.apidskehoach)
        .then((value) => DanhSachKeHoach.fromJson(value));
  }
  static Future<DSLenh> postDsLenh(String url, dynamic data) async {
    return await post(url, data).then((value) => DSLenh.fromJson(value));
  }

  static Future<Map<String, dynamic>> post(String url, dynamic data) async {
    return await http
        .post(Uri.parse(url),
            headers: {
              "authorization": "Bearer ${LoginHelper.Default.access_token}",
              "Content-Type": "application/json",
            },
            body: jsonEncode(data))
        .then((resp) => jsonDecode(resp.body));
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
