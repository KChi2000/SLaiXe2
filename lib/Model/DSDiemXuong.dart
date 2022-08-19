class DSDiemXuong {
  bool status;
  String message;
  int errorCode;
  List<DiemXuongData> data;

  DSDiemXuong({this.status, this.message, this.errorCode, this.data});

  DSDiemXuong.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    errorCode = json['errorCode'];
    if (json['data'] != null) {
      data = <DiemXuongData>[];
      json['data'].forEach((v) {
        data.add(new DiemXuongData.fromJson(v));
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

class DiemXuongData {
  String guidDiemXuong;
  String tenDiemXuong;

  DiemXuongData({this.guidDiemXuong, this.tenDiemXuong});

  DiemXuongData.fromJson(Map<String, dynamic> json) {
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
