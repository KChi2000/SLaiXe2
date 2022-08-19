class ThongTinHanhKhachGhe {
  bool status;
  String message;
  int errorCode;
  DataThongTinHanhKhachGhe data;

  ThongTinHanhKhachGhe({this.status, this.message, this.errorCode, this.data});

  ThongTinHanhKhachGhe.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    errorCode = json['errorCode'];
    data = json['data'] != null ? new DataThongTinHanhKhachGhe.fromJson(json['data']) : null;
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

class DataThongTinHanhKhachGhe {
  String guidChoNgoi;
  String maChuyenDi;
  String maDatCho;
  String soDienThoai;
  String hoTen;
  String soGhe;
  String soVe;
  bool daPhatHanh;
  String tenDiemXuong;
  Null guidDiemXuong;
  TrangThaiThanhToan trangThaiThanhToan;
  TrangThaiThanhToan trangThaiTiemPhong;
  List<LichSuSoatVe> lichSuSoatVe;

  DataThongTinHanhKhachGhe(
      {this.guidChoNgoi,
      this.maChuyenDi,
      this.maDatCho,
      this.soDienThoai,
      this.hoTen,
      this.soGhe,
      this.soVe,
      this.daPhatHanh,
      this.tenDiemXuong,
      this.guidDiemXuong,
      this.trangThaiThanhToan,
      this.trangThaiTiemPhong,
      this.lichSuSoatVe});

  DataThongTinHanhKhachGhe.fromJson(Map<String, dynamic> json) {
    guidChoNgoi = json['guidChoNgoi'];
    maChuyenDi = json['maChuyenDi'];
    maDatCho = json['maDatCho'];
    soDienThoai = json['soDienThoai'];
    hoTen = json['hoTen'];
    soGhe = json['soGhe'];
    soVe = json['soVe'];
    daPhatHanh = json['daPhatHanh'];
    tenDiemXuong = json['tenDiemXuong'];
    guidDiemXuong = json['guidDiemXuong'];
    trangThaiThanhToan = json['trangThaiThanhToan'] != null
        ? new TrangThaiThanhToan.fromJson(json['trangThaiThanhToan'])
        : null;
    trangThaiTiemPhong = json['trangThaiTiemPhong'] != null
        ? new TrangThaiThanhToan.fromJson(json['trangThaiTiemPhong'])
        : null;
    if (json['lichSuSoatVe'] != null) {
      lichSuSoatVe = <LichSuSoatVe>[];
      json['lichSuSoatVe'].forEach((v) {
        lichSuSoatVe.add(new LichSuSoatVe.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['guidChoNgoi'] = this.guidChoNgoi;
    data['maChuyenDi'] = this.maChuyenDi;
    data['maDatCho'] = this.maDatCho;
    data['soDienThoai'] = this.soDienThoai;
    data['hoTen'] = this.hoTen;
    data['soGhe'] = this.soGhe;
    data['soVe'] = this.soVe;
    data['daPhatHanh'] = this.daPhatHanh;
    data['tenDiemXuong'] = this.tenDiemXuong;
    data['guidDiemXuong'] = this.guidDiemXuong;
    if (this.trangThaiThanhToan != null) {
      data['trangThaiThanhToan'] = this.trangThaiThanhToan.toJson();
    }
    if (this.trangThaiTiemPhong != null) {
      data['trangThaiTiemPhong'] = this.trangThaiTiemPhong.toJson();
    }
    if (this.lichSuSoatVe != null) {
      data['lichSuSoatVe'] = this.lichSuSoatVe.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TrangThaiThanhToan {
  String tenTrangThai;
  String maMau;

  TrangThaiThanhToan({this.tenTrangThai, this.maMau});

  TrangThaiThanhToan.fromJson(Map<String, dynamic> json) {
    tenTrangThai = json['tenTrangThai'];
    maMau = json['maMau'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tenTrangThai'] = this.tenTrangThai;
    data['maMau'] = this.maMau;
    return data;
  }
}

class LichSuSoatVe {
  String hoTen;
  String thoiGianThucHien;

  LichSuSoatVe({this.hoTen, this.thoiGianThucHien});

  LichSuSoatVe.fromJson(Map<String, dynamic> json) {
    hoTen = json['hoTen'];
    thoiGianThucHien = json['thoiGianThucHien'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hoTen'] = this.hoTen;
    data['thoiGianThucHien'] = this.thoiGianThucHien;
    return data;
  }
}
