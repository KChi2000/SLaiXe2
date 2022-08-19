class DSHanhKhachGhePhu {
  bool status;
  String message;
  int errorCode;
  List<DataDSHanhKhachGhePhu> data;

  DSHanhKhachGhePhu({this.status, this.message, this.errorCode, this.data});

  DSHanhKhachGhePhu.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    errorCode = json['errorCode'];
    if (json['data'] != null) {
      data = <DataDSHanhKhachGhePhu>[];
      json['data'].forEach((v) {
        data.add(new DataDSHanhKhachGhePhu.fromJson(v));
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

class DataDSHanhKhachGhePhu {
  String guidChoNgoi;
  String maDatCho;
  String soDienThoai;
  String hoTen;
  bool daPhatHanh;
  String diemXuong;
  int giaVe;

  DataDSHanhKhachGhePhu(
      {this.guidChoNgoi,
      this.maDatCho,
      this.soDienThoai,
      this.hoTen,
      this.daPhatHanh,
      this.diemXuong,
      this.giaVe});

  DataDSHanhKhachGhePhu.fromJson(Map<String, dynamic> json) {
    guidChoNgoi = json['guidChoNgoi'];
    maDatCho = json['maDatCho'];
    soDienThoai = json['soDienThoai'];
    hoTen = json['hoTen'];
    daPhatHanh = json['daPhatHanh'];
    diemXuong = json['diemXuong'];
    giaVe = json['giaVe'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['guidChoNgoi'] = this.guidChoNgoi;
    data['maDatCho'] = this.maDatCho;
    data['soDienThoai'] = this.soDienThoai;
    data['hoTen'] = this.hoTen;
    data['daPhatHanh'] = this.daPhatHanh;
    data['diemXuong'] = this.diemXuong;
    data['giaVe'] = this.giaVe;
    return data;
  }
}
