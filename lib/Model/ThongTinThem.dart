class ThongTinThem {
  bool status;
  String message;
  int errorCode;
  DataThongTinThem data;

  ThongTinThem({this.status, this.message, this.errorCode, this.data});

  ThongTinThem.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    errorCode = json['errorCode'];
    data = json['data'] != null ? new DataThongTinThem.fromJson(json['data']) : null;
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

class DataThongTinThem {
  String maChuyenDi;
  String hanhTrinhChay;
  String tenBenDi;
  String tenBenDen;
  String thoiGianKhoiHanh;
  String thoiGianDenBen;
  List<Null> danhSachDieuKhoan;

  DataThongTinThem(
      {this.maChuyenDi,
      this.hanhTrinhChay,
      this.tenBenDi,
      this.tenBenDen,
      this.thoiGianKhoiHanh,
      this.thoiGianDenBen,
      this.danhSachDieuKhoan});

  DataThongTinThem.fromJson(Map<String, dynamic> json) {
    maChuyenDi = json['maChuyenDi'];
    hanhTrinhChay = json['hanhTrinhChay'];
    tenBenDi = json['tenBenDi'];
    tenBenDen = json['tenBenDen'];
    thoiGianKhoiHanh = json['thoiGianKhoiHanh'];
    thoiGianDenBen = json['thoiGianDenBen'];
    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['maChuyenDi'] = this.maChuyenDi;
    data['hanhTrinhChay'] = this.hanhTrinhChay;
    data['tenBenDi'] = this.tenBenDi;
    data['tenBenDen'] = this.tenBenDen;
    data['thoiGianKhoiHanh'] = this.thoiGianKhoiHanh;
    data['thoiGianDenBen'] = this.thoiGianDenBen;
    
    return data;
  }
}