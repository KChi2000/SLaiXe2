class DSLuongTuyen {
  bool status;
  String message;
  int errorCode;
  List<DataLuongTuyen> data;

  DSLuongTuyen({this.status, this.message, this.errorCode, this.data});

  DSLuongTuyen.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    errorCode = json['errorCode'];
    if (json['data'] != null) {
      data = <DataLuongTuyen>[];
      json['data'].forEach((v) {
        data.add(new DataLuongTuyen.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['errorCode'] = this.errorCode;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataLuongTuyen {
  String idDnvtTuyen;
  String idLuongTuyen;
  String maTuyen;
  String tenTuyen;
  String benDi;
  String benDen;
  double cuLy;
  String trangThai;
  String maMauTrangThai;
  String loaiTuyen;

  DataLuongTuyen(
      this.idDnvtTuyen,
      this.idLuongTuyen,
      this.maTuyen,
      this.tenTuyen,
      this.benDi,
      this.benDen,
      this.cuLy,
      this.trangThai,
      this.maMauTrangThai,
      this.loaiTuyen);

  DataLuongTuyen.fromJson(Map<String, dynamic> json) {
    idDnvtTuyen = json['IdDnvtTuyen'];
    idLuongTuyen = json['IdLuongTuyen'];
    maTuyen = json['MaTuyen'];
    tenTuyen = json['TenTuyen'];
    benDi = json['BenDi'];
    benDen = json['BenDen'];
    cuLy = json['CuLy'];
    trangThai = json['TrangThai'];
    maMauTrangThai = json['MaMauTrangThai'];
    loaiTuyen = json['LoaiTuyen'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IdDnvtTuyen'] = this.idDnvtTuyen;
    data['IdLuongTuyen'] = this.idLuongTuyen;
    data['MaTuyen'] = this.maTuyen;
    data['TenTuyen'] = this.tenTuyen;
    data['BenDi'] = this.benDi;
    data['BenDen'] = this.benDen;
    data['CuLy'] = this.cuLy;
    data['TrangThai'] = this.trangThai;
    data['MaMauTrangThai'] = this.maMauTrangThai;
    data['LoaiTuyen'] = this.loaiTuyen;
    return data;
  }
}
