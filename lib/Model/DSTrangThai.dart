class DSTrangThai {
  bool status;
  String message;
  int errorCode;
  List<DataDSTrangThai> data;

  DSTrangThai({this.status, this.message, this.errorCode, this.data});

  DSTrangThai.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    errorCode = json['errorCode'];
    if (json['data'] != null) {
      data = <DataDSTrangThai>[];
      json['data'].forEach((v) {
        data.add(new DataDSTrangThai.fromJson(v));
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

class DataDSTrangThai {
  int idTrangThai;
  String tenTrangThai;
  String maMau;
  int soLuong;

  DataDSTrangThai({this.idTrangThai, this.tenTrangThai, this.maMau, this.soLuong});

  DataDSTrangThai.fromJson(Map<String, dynamic> json) {
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
