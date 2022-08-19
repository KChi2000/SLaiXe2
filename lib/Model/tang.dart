class tang {
  bool status;
  String message;
  int errorCode;
  List<tangData> data;

  tang({this.status, this.message, this.errorCode, this.data});

  tang.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    errorCode = json['errorCode'];
    if (json['data'] != null) {
      data = <tangData>[];
      json['data'].forEach((v) {
        data.add(new tangData.fromJson(v));
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

class tangData {
  String idTang;
  String tenTang;
  int soHang;
  int soCot;

  tangData({this.idTang, this.tenTang, this.soHang, this.soCot});

  tangData.fromJson(Map<String, dynamic> json) {
    idTang = json['idTang'];
    tenTang = json['tenTang'];
    soHang = json['soHang'];
    soCot = json['soCot'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idTang'] = this.idTang;
    data['tenTang'] = this.tenTang;
    data['soHang'] = this.soHang;
    data['soCot'] = this.soCot;
    return data;
  }
}