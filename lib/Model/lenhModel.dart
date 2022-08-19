

// class lenhModel {
//  String time;
//  String date;
//  String sohieu;
//  String diemden;
//  String diemdi;
//  int khach;
//  bool status;
//  lenhModel(this.time,this.date,this.sohieu,this.diemdi,this.diemden,this.khach,this.status);
// }
class DSLenh {
  bool status;
  String message;
  int errorCode;
  Data data;

  DSLenh({this.status, this.message, this.errorCode, this.data});

  DSLenh.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    errorCode = json['errorCode'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['errorCode'] = this.errorCode;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  List<LenhData> list;
  int totalCount;
  int groupCount;
  Null summary;

  Data({this.list, this.totalCount, this.groupCount, this.summary});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      list = <LenhData>[];
      json['data'].forEach((v) {
        list.add(new LenhData.fromJson(v));
      });
    }
    totalCount = json['totalCount'];
    groupCount = json['groupCount'];
    summary = json['summary'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (list != null) {
      data['data'] = list.map((v) => v.toJson()).toList();
    }
    data['totalCount'] = totalCount;
    data['groupCount'] = groupCount;
    data['summary'] = summary;
    return data;
  }
}

class LenhData {
  String guidLenh;
  String maLenh;
  String thoiGianXuatBenKeHoach;
  String bienKiemSoat;
  String tenTuyen;
  String maTuyen;
  String tenBenXe;
  String tenLaiXe;
  int idTrangThai;
  String tenTrangThai;
  String maMauTrangThai;

  LenhData(
      {this.guidLenh,
      this.maLenh,
      this.thoiGianXuatBenKeHoach,
      this.bienKiemSoat,
      this.tenTuyen,
      this.maTuyen,
      this.tenBenXe,
      this.tenLaiXe,
      this.idTrangThai,
      this.tenTrangThai,
      this.maMauTrangThai});

  LenhData.fromJson(Map<String, dynamic> json) {
    guidLenh = json['guidLenh'];
    maLenh = json['maLenh'];
    thoiGianXuatBenKeHoach = json['thoiGianXuatBenKeHoach'];
    bienKiemSoat = json['bienKiemSoat'];
    tenTuyen = json['tenTuyen'];
    maTuyen = json['maTuyen'];
    tenBenXe = json['tenBenXe'];
    tenLaiXe = json['tenLaiXe'];
    idTrangThai = json['idTrangThai'];
    tenTrangThai = json['tenTrangThai'];
    maMauTrangThai = json['maMauTrangThai'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['guidLenh'] = this.guidLenh;
    data['maLenh'] = this.maLenh;
    data['thoiGianXuatBenKeHoach'] = this.thoiGianXuatBenKeHoach;
    data['bienKiemSoat'] = this.bienKiemSoat;
    data['tenTuyen'] = this.tenTuyen;
    data['maTuyen'] = this.maTuyen;
    data['tenBenXe'] = this.tenBenXe;
    data['tenLaiXe'] = this.tenLaiXe;
    data['idTrangThai'] = this.idTrangThai;
    data['tenTrangThai'] = this.tenTrangThai;
    data['maMauTrangThai'] = this.maMauTrangThai;
    return data;
  }
}
class ChiTietLenh {
  bool status;
  String message;
  int errorCode;
  ThongTinLenh data;

  ChiTietLenh({this.status, this.message, this.errorCode, this.data});

  ChiTietLenh.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    errorCode = json['errorCode'];
    data = json['data'] != null ? new ThongTinLenh.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['errorCode'] = this.errorCode;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class ThongTinLenh {
  String guidLenh;
  String maLenh;
  String bienKiemSoat;
  String hieuLucTuNgay;
  String hieuLucDenNgay;
  String benDi;
  String benDen;
  String maTuyen;
  List<DanhSachLaiXe> danhSachLaiXe;
  String qrCode;
  int idTrangThai;
  String trangThai;
  String maMauTrangThai;
  String hanPhuHieuTuyen;
  Null hanDangKiem;
  Null hanBaoHiem;
  String tenDoanhNghiep;
  String nguoiCapLenh;
  String thoiGianCapLenh;
  int soGhe;
  int soGiuong;
  String hinhThucChay;
  String hanhTrinhChay;
  String nhanVienPhucVuTrenXe;
  String gioXuatBen;
  Null soKhachXuatBen;
  Null gioDenBen;
  Null soKhachDenBen;
  bool thuTruongDonViDaKyLenh;
  bool benDiDaKyLenh;
  bool benDenDaKyLenh;
  Null thoiGianDungHanhTrinh;
  Null laiXeDungHanhTrinh;
  Null lyDoDungHanhTrinh;
  Null danhSachHinhAnhSuCo;
  int soKhachMuaVe;
  int soKhachTrenXe;

  ThongTinLenh(
      {this.guidLenh,
      this.maLenh,
      this.bienKiemSoat,
      this.hieuLucTuNgay,
      this.hieuLucDenNgay,
      this.benDi,
      this.benDen,
      this.maTuyen,
      this.danhSachLaiXe,
      this.qrCode,
      this.idTrangThai,
      this.trangThai,
      this.maMauTrangThai,
      this.hanPhuHieuTuyen,
      this.hanDangKiem,
      this.hanBaoHiem,
      this.tenDoanhNghiep,
      this.nguoiCapLenh,
      this.thoiGianCapLenh,
      this.soGhe,
      this.soGiuong,
      this.hinhThucChay,
      this.hanhTrinhChay,
      this.nhanVienPhucVuTrenXe,
      this.gioXuatBen,
      this.soKhachXuatBen,
      this.gioDenBen,
      this.soKhachDenBen,
      this.thuTruongDonViDaKyLenh,
      this.benDiDaKyLenh,
      this.benDenDaKyLenh,
      this.thoiGianDungHanhTrinh,
      this.laiXeDungHanhTrinh,
      this.lyDoDungHanhTrinh,
      this.danhSachHinhAnhSuCo,
      this.soKhachMuaVe,
      this.soKhachTrenXe});

  ThongTinLenh.fromJson(Map<String, dynamic> json) {
    guidLenh = json['guidLenh'];
    maLenh = json['maLenh'];
    bienKiemSoat = json['bienKiemSoat'];
    hieuLucTuNgay = json['hieuLucTuNgay'];
    hieuLucDenNgay = json['hieuLucDenNgay'];
    benDi = json['benDi'];
    benDen = json['benDen'];
    maTuyen = json['maTuyen'];
    if (json['danhSachLaiXe'] != null) {
      danhSachLaiXe = <DanhSachLaiXe>[];
      json['danhSachLaiXe'].forEach((v) {
        danhSachLaiXe.add(new DanhSachLaiXe.fromJson(v));
      });
    }
    qrCode = json['qrCode'];
    idTrangThai = json['idTrangThai'];
    trangThai = json['trangThai'];
    maMauTrangThai = json['maMauTrangThai'];
    hanPhuHieuTuyen = json['hanPhuHieuTuyen'];
    hanDangKiem = json['hanDangKiem'];
    hanBaoHiem = json['hanBaoHiem'];
    tenDoanhNghiep = json['tenDoanhNghiep'];
    nguoiCapLenh = json['nguoiCapLenh'];
    thoiGianCapLenh = json['thoiGianCapLenh'];
    soGhe = json['soGhe'];
    soGiuong = json['soGiuong'];
    hinhThucChay = json['hinhThucChay'];
    hanhTrinhChay = json['hanhTrinhChay'];
    nhanVienPhucVuTrenXe = json['nhanVienPhucVuTrenXe'];
    gioXuatBen = json['gioXuatBen'];
    soKhachXuatBen = json['soKhachXuatBen'];
    gioDenBen = json['gioDenBen'];
    soKhachDenBen = json['soKhachDenBen'];
    thuTruongDonViDaKyLenh = json['thuTruongDonViDaKyLenh'];
    benDiDaKyLenh = json['benDiDaKyLenh'];
    benDenDaKyLenh = json['benDenDaKyLenh'];
    thoiGianDungHanhTrinh = json['thoiGianDungHanhTrinh'];
    laiXeDungHanhTrinh = json['laiXeDungHanhTrinh'];
    lyDoDungHanhTrinh = json['lyDoDungHanhTrinh'];
    danhSachHinhAnhSuCo = json['danhSachHinhAnhSuCo'];
    soKhachMuaVe = json['soKhachMuaVe'];
    soKhachTrenXe = json['soKhachTrenXe'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['guidLenh'] = this.guidLenh;
    data['maLenh'] = this.maLenh;
    data['bienKiemSoat'] = this.bienKiemSoat;
    data['hieuLucTuNgay'] = this.hieuLucTuNgay;
    data['hieuLucDenNgay'] = this.hieuLucDenNgay;
    data['benDi'] = this.benDi;
    data['benDen'] = this.benDen;
    data['maTuyen'] = this.maTuyen;
    if (this.danhSachLaiXe != null) {
      data['danhSachLaiXe'] =
          this.danhSachLaiXe.map((v) => v.toJson()).toList();
    }
    data['qrCode'] = this.qrCode;
    data['idTrangThai'] = this.idTrangThai;
    data['trangThai'] = this.trangThai;
    data['maMauTrangThai'] = this.maMauTrangThai;
    data['hanPhuHieuTuyen'] = this.hanPhuHieuTuyen;
    data['hanDangKiem'] = this.hanDangKiem;
    data['hanBaoHiem'] = this.hanBaoHiem;
    data['tenDoanhNghiep'] = this.tenDoanhNghiep;
    data['nguoiCapLenh'] = this.nguoiCapLenh;
    data['thoiGianCapLenh'] = this.thoiGianCapLenh;
    data['soGhe'] = this.soGhe;
    data['soGiuong'] = this.soGiuong;
    data['hinhThucChay'] = this.hinhThucChay;
    data['hanhTrinhChay'] = this.hanhTrinhChay;
    data['nhanVienPhucVuTrenXe'] = this.nhanVienPhucVuTrenXe;
    data['gioXuatBen'] = this.gioXuatBen;
    data['soKhachXuatBen'] = this.soKhachXuatBen;
    data['gioDenBen'] = this.gioDenBen;
    data['soKhachDenBen'] = this.soKhachDenBen;
    data['thuTruongDonViDaKyLenh'] = this.thuTruongDonViDaKyLenh;
    data['benDiDaKyLenh'] = this.benDiDaKyLenh;
    data['benDenDaKyLenh'] = this.benDenDaKyLenh;
    data['thoiGianDungHanhTrinh'] = this.thoiGianDungHanhTrinh;
    data['laiXeDungHanhTrinh'] = this.laiXeDungHanhTrinh;
    data['lyDoDungHanhTrinh'] = this.lyDoDungHanhTrinh;
    data['danhSachHinhAnhSuCo'] = this.danhSachHinhAnhSuCo;
    data['soKhachMuaVe'] = this.soKhachMuaVe;
    data['soKhachTrenXe'] = this.soKhachTrenXe;
    return data;
  }
}

class DanhSachLaiXe {
  String guidLaiXe;
  String tenLaiXe;
  String hangBangLai;
  bool daKyLenh;

  DanhSachLaiXe(
      {this.guidLaiXe, this.tenLaiXe, this.hangBangLai, this.daKyLenh});

  DanhSachLaiXe.fromJson(Map<String, dynamic> json) {
    guidLaiXe = json['guidLaiXe'];
    tenLaiXe = json['tenLaiXe'];
    hangBangLai = json['hangBangLai'];
    daKyLenh = json['daKyLenh'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['guidLaiXe'] = this.guidLaiXe;
    data['tenLaiXe'] = this.tenLaiXe;
    data['hangBangLai'] = this.hangBangLai;
    data['daKyLenh'] = this.daKyLenh;
    return data;
  }
}