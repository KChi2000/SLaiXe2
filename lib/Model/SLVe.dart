class SLVe {
  bool status;
  String message;
  int errorCode;
  List<DataSLVe> data;

  SLVe({this.status, this.message, this.errorCode, this.data});

  SLVe.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    errorCode = json['errorCode'];
    if (json['data'] != null) {
      data = <DataSLVe>[];
      json['data'].forEach((v) {
        data.add(new DataSLVe.fromJson(v));
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

class DataSLVe {
  int idLoaiDiemBan;
  int soLuong;
  String moTa;
  int thanhTien;

  DataSLVe({this.idLoaiDiemBan, this.soLuong, this.moTa, this.thanhTien});

  DataSLVe.fromJson(Map<String, dynamic> json) {
    idLoaiDiemBan = json['idLoaiDiemBan'];
    soLuong = json['soLuong'];
    moTa = json['moTa'];
    thanhTien = json['thanhTien'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idLoaiDiemBan'] = this.idLoaiDiemBan;
    data['soLuong'] = this.soLuong;
    data['moTa'] = this.moTa;
    data['thanhTien'] = this.thanhTien;
    return data;
  }
}
