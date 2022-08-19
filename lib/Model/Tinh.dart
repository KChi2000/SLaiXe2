class Tinh {
  bool status;
  String message;
  int errorCode;
  List<DataTinh> data;

  Tinh({this.status, this.message, this.errorCode, this.data});

  Tinh.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    errorCode = json['errorCode'];
    if (json['data'] != null) {
      data = <DataTinh>[];
      json['data'].forEach((v) {
        data.add(new DataTinh.fromJson(v));
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

class DataTinh {
  String idTinh;
  String tenTinh;

  DataTinh({this.idTinh, this.tenTinh});

  DataTinh.fromJson(Map<String, dynamic> json) {
    idTinh = json['id_Tinh'];
    tenTinh = json['tenTinh'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_Tinh'] = this.idTinh;
    data['tenTinh'] = this.tenTinh;
    return data;
  }
}