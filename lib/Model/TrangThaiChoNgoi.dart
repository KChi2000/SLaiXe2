class TrangThaiChoNgoi {
  bool status;
  String message;
  int errorCode;
  List<TrangThaiData> data;

  TrangThaiChoNgoi({this.status, this.message, this.errorCode, this.data});

  TrangThaiChoNgoi.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    errorCode = json['errorCode'];
    if (json['data'] != null) {
      data = <TrangThaiData>[];
      json['data'].forEach((v) {
        data.add(new TrangThaiData.fromJson(v));
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

class TrangThaiData {
  int idTrangThai;
  String tenTrangThai;
  String maMau;
  int soLuong;

  TrangThaiData({this.idTrangThai, this.tenTrangThai, this.maMau, this.soLuong});

  TrangThaiData.fromJson(Map<String, dynamic> json) {
    idTrangThai = json['idTrangThai'];
    tenTrangThai = json['tenTrangThai'];
    maMau = json['maMau'];
    soLuong = json['soLuong'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idTrangThai'] = this.idTrangThai;
    data['tenTrangThai'] = this.tenTrangThai;
    data['maMau'] = this.maMau;
    data['soLuong'] = this.soLuong;
    return data;
  }
}
