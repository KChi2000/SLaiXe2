class KhachTrenXe {
  bool status;
  String message;
  int errorCode;
  Data data;

  KhachTrenXe({this.status, this.message, this.errorCode, this.data});

  KhachTrenXe.fromJson(Map<String, dynamic> json) {
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
  String idChuyenDi;
  int soKhachMuaVe;
  int soKhachTrenXe;

  Data({this.idChuyenDi, this.soKhachMuaVe, this.soKhachTrenXe});

  Data.fromJson(Map<String, dynamic> json) {
    idChuyenDi = json['idChuyenDi'];
    soKhachMuaVe = json['soKhachMuaVe'];
    soKhachTrenXe = json['soKhachTrenXe'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idChuyenDi'] = this.idChuyenDi;
    data['soKhachMuaVe'] = this.soKhachMuaVe;
    data['soKhachTrenXe'] = this.soKhachTrenXe;
    return data;
  }
}