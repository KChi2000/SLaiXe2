class DSDiemXuongLoTrinh {
  bool status;
  String message;
  int errorCode;
  List<DataDSDiemXuongLoTrinh> data;

  DSDiemXuongLoTrinh({this.status, this.message, this.errorCode, this.data});

  DSDiemXuongLoTrinh.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    errorCode = json['errorCode'];
    if (json['data'] != null) {
      data = <DataDSDiemXuongLoTrinh>[];
      json['data'].forEach((v) {
        data.add(new DataDSDiemXuongLoTrinh.fromJson(v));
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

class DataDSDiemXuongLoTrinh {
  String guidDiemXuong;
  String tenDiemXuong;

  DataDSDiemXuongLoTrinh(this.guidDiemXuong, this.tenDiemXuong);

  DataDSDiemXuongLoTrinh.fromJson(Map<String, dynamic> json) {
    guidDiemXuong = json['guidDiemXuong'];
    tenDiemXuong = json['tenDiemXuong'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['guidDiemXuong'] = this.guidDiemXuong;
    data['tenDiemXuong'] = this.tenDiemXuong;
    return data;
  }
}
