class DSHanhKhachMuaVe {
  bool status;
  String message;
  int errorCode;
  List<DataDSHangKhachMuaVe> data;

  DSHanhKhachMuaVe({this.status, this.message, this.errorCode, this.data});

  DSHanhKhachMuaVe.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    errorCode = json['errorCode'];
    if (json['data'] != null) {
      data = <DataDSHangKhachMuaVe>[];
      json['data'].forEach((v) {
        data.add(new DataDSHangKhachMuaVe.fromJson(v));
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

class DataDSHangKhachMuaVe {
  String idChuyenDi;
  String idDonHang;
  String maDatCho;
  String tenCho;
  int thanhTien;
  String hoTen;
  String soDienThoai;
  String tenDiemXuong;
  bool check=false;
  DataDSHangKhachMuaVe(
      this.idChuyenDi,
      this.idDonHang,
      this.maDatCho,
      this.tenCho,
      this.thanhTien,
      this.hoTen,
      this.soDienThoai,
      this.tenDiemXuong,
      this.check);

  DataDSHangKhachMuaVe.fromJson(Map<String, dynamic> json) {
    idChuyenDi = json['idChuyenDi'];
    idDonHang = json['idDonHang'];
    maDatCho = json['maDatCho'];
    tenCho = json['tenCho'];
    thanhTien = json['thanhTien'];
    hoTen = json['hoTen'];
    soDienThoai = json['soDienThoai'];
    tenDiemXuong = json['tenDiemXuong'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idChuyenDi'] = idChuyenDi;
    data['idDonHang'] = idDonHang;
    data['maDatCho'] = maDatCho;
    data['tenCho'] = tenCho;
    data['thanhTien'] = thanhTien;
    data['hoTen'] = hoTen;
    data['soDienThoai'] = soDienThoai;
    data['tenDiemXuong'] = tenDiemXuong;
    return data;
  }
}
