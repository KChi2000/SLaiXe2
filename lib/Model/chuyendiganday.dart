class chuyendiganday {
  bool status;
  String message;
  int errorCode;
  Data data;

  chuyendiganday({this.status, this.message, this.errorCode, this.data});

  chuyendiganday.fromJson(Map<String, dynamic> json) {
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
  String guidChuyenDi;
  String guidXe;
  String guidLoTrinh;
  String guidDoanhNghiep;
  String maChuyenDi;
  String bienKiemSoat;
  String noiDi;
  String noiDen;
  String gioXuatBenKeHoach;
  String maTuyen;
  String trangThai;
  String maMauTrangThai;
  int soKhachMuaVe;
  int soKhachTrenXe;
  String qrData;

  Data(
      {this.guidChuyenDi,
      this.guidXe,
      this.guidLoTrinh,
      this.guidDoanhNghiep,
      this.maChuyenDi,
      this.bienKiemSoat,
      this.noiDi,
      this.noiDen,
      this.gioXuatBenKeHoach,
      this.maTuyen,
      this.trangThai,
      this.maMauTrangThai,
      this.soKhachMuaVe,
      this.soKhachTrenXe,
      this.qrData});

  Data.fromJson(Map<String, dynamic> json) {
    guidChuyenDi = json['guidChuyenDi'];
    guidXe = json['guidXe'];
    guidLoTrinh = json['guidLoTrinh'];
    guidDoanhNghiep = json['guidDoanhNghiep'];
    maChuyenDi = json['maChuyenDi'];
    bienKiemSoat = json['bienKiemSoat'];
    noiDi = json['noiDi'];
    noiDen = json['noiDen'];
    gioXuatBenKeHoach = json['gioXuatBenKeHoach'];
    maTuyen = json['maTuyen'];
    trangThai = json['trangThai'];
    maMauTrangThai = json['maMauTrangThai'];
    soKhachMuaVe = json['soKhachMuaVe'];
    soKhachTrenXe = json['soKhachTrenXe'];
    qrData = json['qrData'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['guidChuyenDi'] = this.guidChuyenDi;
    data['guidXe'] = this.guidXe;
    data['guidLoTrinh'] = this.guidLoTrinh;
    data['guidDoanhNghiep'] = this.guidDoanhNghiep;
    data['maChuyenDi'] = this.maChuyenDi;
    data['bienKiemSoat'] = this.bienKiemSoat;
    data['noiDi'] = this.noiDi;
    data['noiDen'] = this.noiDen;
    data['gioXuatBenKeHoach'] = this.gioXuatBenKeHoach;
    data['maTuyen'] = this.maTuyen;
    data['trangThai'] = this.trangThai;
    data['maMauTrangThai'] = this.maMauTrangThai;
    data['soKhachMuaVe'] = this.soKhachMuaVe;
    data['soKhachTrenXe'] = this.soKhachTrenXe;
    data['qrData'] = this.qrData;
    return data;
  }
}
