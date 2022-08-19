class LichSuChuyenDi {
  bool status;
  String message;
  int errorCode;
  List<DataLichSuChuyenDi> data;

  LichSuChuyenDi({this.status, this.message, this.errorCode, this.data});

  LichSuChuyenDi.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    errorCode = json['errorCode'];
    if (json['data'] != null) {
      data = <DataLichSuChuyenDi>[];
      json['data'].forEach((v) {
        data.add(new DataLichSuChuyenDi.fromJson(v));
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

class DataLichSuChuyenDi {
  String guidChuyenDi;
  String maChuyenDi;
  String tenBenDi;
  String tenBenDen;
  String gioXuatBen;

  DataLichSuChuyenDi(
      {this.guidChuyenDi,
      this.maChuyenDi,
      this.tenBenDi,
      this.tenBenDen,
      this.gioXuatBen});

  DataLichSuChuyenDi.fromJson(Map<String, dynamic> json) {
    guidChuyenDi = json['guidChuyenDi'];
    maChuyenDi = json['maChuyenDi'];
    tenBenDi = json['tenBenDi'];
    tenBenDen = json['tenBenDen'];
    gioXuatBen = json['gioXuatBen'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['guidChuyenDi'] = this.guidChuyenDi;
    data['maChuyenDi'] = this.maChuyenDi;
    data['tenBenDi'] = this.tenBenDi;
    data['tenBenDen'] = this.tenBenDen;
    data['gioXuatBen'] = this.gioXuatBen;
    return data;
  }
}
