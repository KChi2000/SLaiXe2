class LenhHienTai {
  bool status;
  String message;
  int errorCode;
  DataLenhHienTai data;

  LenhHienTai({this.status, this.message, this.errorCode, this.data});

  LenhHienTai.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    errorCode = json['errorCode'];
    data = json['data'] != null ? new DataLenhHienTai.fromJson(json['data']) : null;
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

class DataLenhHienTai {
  String idLenh;
  String maLenh;
  Null maChuyenDi;
  String guidDoanhNghiep;
  String bienKiemSoat;
  String tenTuyen;
  String maTuyen;
  String thoiGianXuatBenKeHoach;
  int soKhach;
  int idTrangThai;
  String trangThai;
  String maMauTrangThai;

  DataLenhHienTai(
      {this.idLenh,
      this.maLenh,
      this.maChuyenDi,
      this.guidDoanhNghiep,
      this.bienKiemSoat,
      this.tenTuyen,
      this.maTuyen,
      this.thoiGianXuatBenKeHoach,
      this.soKhach,
      this.idTrangThai,
      this.trangThai,
      this.maMauTrangThai});

  DataLenhHienTai.fromJson(Map<String, dynamic> json) {
    idLenh = json['idLenh'];
    maLenh = json['maLenh'];
    maChuyenDi = json['maChuyenDi'];
    guidDoanhNghiep = json['guidDoanhNghiep'];
    bienKiemSoat = json['bienKiemSoat'];
    tenTuyen = json['tenTuyen'];
    maTuyen = json['maTuyen'];
    thoiGianXuatBenKeHoach = json['thoiGianXuatBenKeHoach'];
    soKhach = json['soKhach'];
    idTrangThai = json['idTrangThai'];
    trangThai = json['trangThai'];
    maMauTrangThai = json['maMauTrangThai'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idLenh'] = this.idLenh;
    data['maLenh'] = this.maLenh;
    data['maChuyenDi'] = this.maChuyenDi;
    data['guidDoanhNghiep'] = this.guidDoanhNghiep;
    data['bienKiemSoat'] = this.bienKiemSoat;
    data['tenTuyen'] = this.tenTuyen;
    data['maTuyen'] = this.maTuyen;
    data['thoiGianXuatBenKeHoach'] = this.thoiGianXuatBenKeHoach;
    data['soKhach'] = this.soKhach;
    data['idTrangThai'] = this.idTrangThai;
    data['trangThai'] = this.trangThai;
    data['maMauTrangThai'] = this.maMauTrangThai;
    return data;
  }
}