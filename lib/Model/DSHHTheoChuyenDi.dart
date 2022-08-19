class DSHHTheoChuyenDi {
  bool status;
  String message;
  int errorCode;
  List<DataDSHH> data;

  DSHHTheoChuyenDi({this.status, this.message, this.errorCode, this.data});

  DSHHTheoChuyenDi.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    errorCode = json['errorCode'];
    if (json['data'] != null) {
      data = <DataDSHH>[];
      json['data'].forEach((v) {
        data.add(new DataDSHH.fromJson(v));
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

class DataDSHH {
  String idNhatKy;
  String tenDiemNhan;
  String soDienThoaiNguoiNhan;
  String thoiGianDuKienGiaoHang;
  String thoiGianGiaoHangThucTe;
  String trangThaiThanhToan;
  String maMauThanhToan;
  String trangThaiVanChuyen;
  String maMauVanChuyen;
  int donGia;
  // List<String> danhSachHinhAnh;

  DataDSHH(
      {this.idNhatKy,
      this.tenDiemNhan,
      this.soDienThoaiNguoiNhan,
      this.thoiGianDuKienGiaoHang,
      this.thoiGianGiaoHangThucTe,
      this.trangThaiThanhToan,
      this.maMauThanhToan,
      this.trangThaiVanChuyen,
      this.maMauVanChuyen,
      this.donGia,
      });

  DataDSHH.fromJson(Map<String, dynamic> json) {
    idNhatKy = json['idNhatKy'];
    tenDiemNhan = json['tenDiemNhan'];
    soDienThoaiNguoiNhan = json['soDienThoaiNguoiNhan'];
    thoiGianDuKienGiaoHang = json['thoiGianDuKienGiaoHang'];
    thoiGianGiaoHangThucTe = json['thoiGianGiaoHangThucTe'];
    trangThaiThanhToan = json['trangThaiThanhToan'];
    maMauThanhToan = json['maMauThanhToan'];
    trangThaiVanChuyen = json['trangThaiVanChuyen'];
    maMauVanChuyen = json['maMauVanChuyen'];
    donGia = json['donGia'];
    // if (json['danhSachHinhAnh'] != null) {
    //   danhSachHinhAnh = <String>[];
    //   json['danhSachHinhAnh'].forEach((v) {
    //     danhSachHinhAnh.add(new String.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idNhatKy'] = this.idNhatKy;
    data['tenDiemNhan'] = this.tenDiemNhan;
    data['soDienThoaiNguoiNhan'] = this.soDienThoaiNguoiNhan;
    data['thoiGianDuKienGiaoHang'] = this.thoiGianDuKienGiaoHang;
    data['thoiGianGiaoHangThucTe'] = this.thoiGianGiaoHangThucTe;
    data['trangThaiThanhToan'] = this.trangThaiThanhToan;
    data['maMauThanhToan'] = this.maMauThanhToan;
    data['trangThaiVanChuyen'] = this.trangThaiVanChuyen;
    data['maMauVanChuyen'] = this.maMauVanChuyen;
    data['donGia'] = this.donGia;
    // if (this.danhSachHinhAnh != null) {
    //   data['danhSachHinhAnh'] =
    //       this.danhSachHinhAnh.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}