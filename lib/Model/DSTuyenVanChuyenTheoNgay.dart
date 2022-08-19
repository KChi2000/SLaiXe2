class DSTuyenVanChuyenTheoNgay {
  bool status;
  String message;
  int errorCode;
  List<DataTuyenTheoNgay> data;

  DSTuyenVanChuyenTheoNgay(
      {this.status, this.message, this.errorCode, this.data});

  DSTuyenVanChuyenTheoNgay.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    errorCode = json['errorCode'];
    if (json['data'] != null) {
      data = <DataTuyenTheoNgay>[];
      json['data'].forEach((v) {
        data.add(new DataTuyenTheoNgay.fromJson(v));
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

class DataTuyenTheoNgay {
  String idTuyen;
  String tenTuyen;

  DataTuyenTheoNgay(this.idTuyen, this.tenTuyen);

  DataTuyenTheoNgay.fromJson(Map<String, dynamic> json) {
    idTuyen = json['idTuyen'];
    tenTuyen = json['tenTuyen'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idTuyen'] = this.idTuyen;
    data['tenTuyen'] = this.tenTuyen;
    return data;
  }
}
