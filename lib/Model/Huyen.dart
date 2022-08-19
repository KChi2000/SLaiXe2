class Huyen {
  bool status;
  String message;
  int errorCode;
  List<DataHuyen> data;

  Huyen({this.status, this.message, this.errorCode, this.data});

  Huyen.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    errorCode = json['errorCode'];
    if (json['data'] != null) {
      data = <DataHuyen>[];
      json['data'].forEach((v) {
        data.add(new DataHuyen.fromJson(v));
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

class DataHuyen {
  String idHuyen;
  String tenHuyen;

  DataHuyen({this.idHuyen, this.tenHuyen});

  DataHuyen.fromJson(Map<String, dynamic> json) {
    idHuyen = json['id_Huyen'];
    tenHuyen = json['tenHuyen'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_Huyen'] = this.idHuyen;
    data['tenHuyen'] = this.tenHuyen;
    return data;
  }
}